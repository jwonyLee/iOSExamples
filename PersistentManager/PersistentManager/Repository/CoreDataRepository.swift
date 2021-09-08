//
//  CoreDataRepository.swift
//  PersistentManager
//
//  Created by 이지원 on 2021/08/19.
//

import Foundation
import CoreData

enum CoreDataRepositoryError: Error {
    case invaildManagedObjectType
}

final class CoreDataRepository<T: NSManagedObject>: Repository {
    typealias Entity = T
    
    private var managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    // Create
    func create() -> Result<Entity, Error> {
        let entityName: String = String(describing: Entity.self)
        guard let managedObject: Entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: managedObjectContext) as? Entity else {
            return .failure(CoreDataRepositoryError.invaildManagedObjectType)
        }
        return .success(managedObject)
    }

    // Read
    func get(withPredicate predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]? = nil) -> Result<[Entity], Error> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            if let fetchResults: [Entity] = try managedObjectContext.fetch(fetchRequest) as? [Entity] {
                return .success(fetchResults)
            } else {
                return .failure(CoreDataRepositoryError.invaildManagedObjectType)
            }
        } catch {
            return .failure(error)
        }
    }
    
    // Update
    func update(_ entity: Entity) {
    }
    
    // Delete
    func delete(_ entity: Entity) -> Result<Bool, Error> {
        managedObjectContext.delete(entity)
        return .success(true)
    }
    
    func delete<S: Sequence>(_ entities: S) -> Result<Bool, Error> {
        for entity in entities {
            guard let entity: Entity = entity as? Entity else {
                return .failure(CoreDataRepositoryError.invaildManagedObjectType)
            }
            managedObjectContext.delete(entity)
        }
        return .success(true)
    }
    
    func delete(fromEntity entity: T.Type, withPredicate predicate: NSPredicate?) -> Result<Bool, Error> {
        return .success(true)
    }
}
