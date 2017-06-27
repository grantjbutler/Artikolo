// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import CoreData
import UIKit

enum CoreDataInitializationError: Error {

    case invalidProperty(String)

}

// MARK: - CoreDataInitializable for classes, protocols, structs
extension Article {

    static var entityName: String {
        return "Article"
    }

    init(managedObject: NSManagedObject) throws {
        guard let url = managedObject.value(forKey: "url") as? URL else { throw CoreDataInitializationError.invalidProperty("url") }
        guard let addedOn = managedObject.value(forKey: "addedOn") as? Date else { throw CoreDataInitializationError.invalidProperty("addedOn") }
        guard let createdOn = managedObject.value(forKey: "createdOn") as? Date else { throw CoreDataInitializationError.invalidProperty("createdOn") }
        guard let tagsManagedObjects = managedObject.value(forKey: "tags") as? [NSManagedObject] else { throw CoreDataInitializationError.invalidProperty("tags") }
        let tags = try tagsManagedObjects.map { try Tag(managedObject: $0) }

        self.url = url
        self.addedOn = addedOn
        self.createdOn = createdOn
        self.tags = tags
    }

    func toManagedObject(in context: NSManagedObjectContext) throws -> NSManagedObject {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: type(of: self).entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "%K == %@", argumentArray: ["url", url]),
        ])

        let results = try context.fetch(fetchRequest)
        let managedObject = results.first ?? NSEntityDescription.insertNewObject(forEntityName: type(of: self).entityName, into: context)

        managedObject.setValue(url, forKey: "url")
        managedObject.setValue(addedOn, forKey: "addedOn")
        managedObject.setValue(createdOn, forKey: "createdOn")
        let tagsManagedObjects = try tags.map { try $0.toManagedObject(in: context) }
        managedObject.setValue(tagsManagedObjects, forKey: "tags")

        return managedObject
    }

}
extension Tag {

    static var entityName: String {
        return "Tag"
    }

    init(managedObject: NSManagedObject) throws {
        guard let name = managedObject.value(forKey: "name") as? String else { throw CoreDataInitializationError.invalidProperty("name") }
        guard let color = managedObject.value(forKey: "color") as? UIColor else { throw CoreDataInitializationError.invalidProperty("color") }
        guard let articlesManagedObjects = managedObject.value(forKey: "articles") as? [NSManagedObject] else { throw CoreDataInitializationError.invalidProperty("articles") }
        let articles = try articlesManagedObjects.map { try Article(managedObject: $0) }

        self.name = name
        self.color = color
        self.articles = articles
    }

    func toManagedObject(in context: NSManagedObjectContext) throws -> NSManagedObject {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: type(of: self).entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "%K == %@", argumentArray: ["name", name]),
        ])

        let results = try context.fetch(fetchRequest)
        let managedObject = results.first ?? NSEntityDescription.insertNewObject(forEntityName: type(of: self).entityName, into: context)

        managedObject.setValue(name, forKey: "name")
        managedObject.setValue(color, forKey: "color")
        let articlesManagedObjects = try articles.map { try $0.toManagedObject(in: context) }
        managedObject.setValue(articlesManagedObjects, forKey: "articles")

        return managedObject
    }

}
