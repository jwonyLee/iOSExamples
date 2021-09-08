//
//  CoreDataStack.swift
//  CoreDataStack
//
//  Created by 이지원 on 2021/08/19.
//

import Foundation
import CoreData

final class CoreDataContextProvider {
    static let shared: CoreDataContextProvider = CoreDataContextProvider()
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container: NSPersistentContainer = NSPersistentContainer(name: "PersistentManager")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error: NSError = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    func saveContext () {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                let nserror: NSError = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
