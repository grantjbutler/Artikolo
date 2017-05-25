// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import CoreData

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

        self.url = url
        self.addedOn = addedOn
        self.createdOn = createdOn
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

        return managedObject
    }

}
