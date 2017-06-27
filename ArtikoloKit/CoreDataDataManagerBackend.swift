//
//  CoreDataDataManagerBackend.swift
//  Artikolo
//
//  Created by Grant Butler on 4/30/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import RxCoreData

private let AppGroupIdentifier = "group.com.grantjbutler.Artikolo.Database"
private class PersistentContainer: NSPersistentContainer {
    
    override class func defaultDirectoryURL() -> URL {
        guard let directoryURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: AppGroupIdentifier) else {
            fatalError("No application group with the identifier \(AppGroupIdentifier)")
        }
        return directoryURL
    }
    
}

private extension NSPersistentContainer {
    
    func removeStores() throws {
        let coordinator = persistentStoreCoordinator
        try persistentStoreDescriptions.forEach({ (store) in
            guard let storeURL = store.url else { return }
            try coordinator.destroyPersistentStore(at: storeURL, ofType: store.type, options: store.options)
        })
    }
    
}

public class CoreDataDataManagerBackend: DataManagerBackend {
    
    private let container: NSPersistentContainer
    
    public let articles: Observable<[Article]>
    public let tags: Observable<[Tag]>
    
    private static func makePersistentContainer(name: String) -> NSPersistentContainer {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        guard let managedObjectModelURL = Bundle.init(for: self).url(forResource: "Artikolo", withExtension: "momd") else { fatalError("No URL for the managed object model.") }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: managedObjectModelURL) else { fatalError("Unable to load managed object model.") }
        let container = PersistentContainer(name: "Artikolo", managedObjectModel: managedObjectModel)
        container.persistentStoreDescriptions.forEach { $0.shouldMigrateStoreAutomatically = true }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            guard let error = error else { return }
            
#if DEBUG
            print("Got error, reseting container to attempt a resolve: \(error)")
            
            try! container.removeStores()
            
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
#else
            fatalError("Unresolved error \(error), \(error.userInfo)")
#endif
        })
        return container
    }
    
    public init(containerName: String) {
        container = type(of: self).makePersistentContainer(name: containerName)
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        let articleFetchRequest = NSFetchRequest<NSManagedObject>(entityName: Article.entityName)
        articleFetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "addedOn", ascending: false)
        ]
        
        articles = container.viewContext.rx.entities(fetchRequest: articleFetchRequest)
                .map {
                    $0.map { return try! Article(managedObject: $0) }
                }
        
        let tagFetchRequest = NSFetchRequest<NSManagedObject>(entityName: Tag.entityName)
        tagFetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        tags = container.viewContext.rx.entities(fetchRequest: tagFetchRequest)
            .map {
                $0.map { return try! Tag(managedObject: $0) }
            }
    }
    
    public func save(article: Article) {
        let context = container.newBackgroundContext()
        context.performAndWait {
            do {
                let _ = try article.toManagedObject(in: context)
                try context.save()
            }
            catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func reset() throws {
        let coordinator = container.persistentStoreCoordinator
        let stores = coordinator.persistentStores
        try stores.forEach({ (store) in
            guard let storeURL = store.url else { return }
            try coordinator.destroyPersistentStore(at: storeURL, ofType: store.type, options: store.options)
            try coordinator.addPersistentStore(ofType: store.type, configurationName: store.configurationName, at: store.url, options: store.options)
        })
        
    }
    
}
