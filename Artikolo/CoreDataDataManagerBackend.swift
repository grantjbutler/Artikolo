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

private extension NSPersistentContainer {
    
    func removeStores() throws {
        let coordinator = persistentStoreCoordinator
        try persistentStoreDescriptions.forEach({ (store) in
            guard let storeURL = store.url else { return }
            try coordinator.destroyPersistentStore(at: storeURL, ofType: store.type, options: store.options)
        })
    }
    
}

class CoreDataDataManagerBackend: DataManagerBackend {
    
    private let container: NSPersistentContainer
    
    let articles: Observable<[Article]>
    
    private static func makePersistentContainer(name: String) -> NSPersistentContainer {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Artikolo")
        container.persistentStoreDescriptions.forEach { $0.shouldMigrateStoreAutomatically = true }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            guard let error = error else { return }
            print("Got error, reseting container to attempt a resolve: \(error)")
            
            try! container.removeStores()
            
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
        })
        return container
    }
    
    init(containerName: String) {
        container = type(of: self).makePersistentContainer(name: containerName)
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Article")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "addedOn", ascending: false)
        ]
        
        articles = container.viewContext.rx.entities(fetchRequest: fetchRequest)
                .map {
                    $0.map {
                        let url = $0.value(forKey: "url") as! URL
                        let addedOn = $0.value(forKey: "addedOn") as! Date
                        let createdOn = $0.value(forKey: "createdOn") as! Date
                        
                        return Article(url: url, addedOn: addedOn, createdOn: createdOn)
                    }
                }
    }
    
    func save(article: Article) {
        let context = container.newBackgroundContext()
        context.performAndWait {
            let articleObject = NSEntityDescription.insertNewObject(forEntityName: "Article", into: context)
            articleObject.setValue(article.url, forKey: "url")
            articleObject.setValue(article.addedOn, forKey: "addedOn")
            articleObject.setValue(article.createdOn, forKey: "createdOn")
            
            do {
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
    
    func reset() throws {
        let coordinator = container.persistentStoreCoordinator
        let stores = coordinator.persistentStores
        try stores.forEach({ (store) in
            guard let storeURL = store.url else { return }
            try coordinator.destroyPersistentStore(at: storeURL, ofType: store.type, options: store.options)
            try coordinator.addPersistentStore(ofType: store.type, configurationName: store.configurationName, at: store.url, options: store.options)
        })
        
    }
    
}
