//
//  Repository.swift
//  PersistentManager
//
//  Created by 이지원 on 2021/08/19.
//

import Foundation
import CoreData

protocol Repository {
    associatedtype Entity
    
    // Create
    func create() -> Result<Entity, Error>
    //    func add<S: Sequence>(_ objects: S) where S.Iterator.Element == Entity
    
    // Read
    func get(withPredicate predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Entity], Error>
    
    // Update
    func update(_ entity: Entity)
    
    // Delete
    func delete(_ entity: Entity) -> Result<Bool, Error>
    // where S.Iterator.Element == (Entity)
    func delete<S: Sequence>(_ entities: S) -> Result<Bool, Error>
    func delete(fromEntity entity: Entity.Type, withPredicate predicate: NSPredicate?) -> Result<Bool, Error> 
}
