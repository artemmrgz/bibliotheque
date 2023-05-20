//
//  CoreDataStack.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 19/05/2023.
//

import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let persistentContainer: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Bibliotheque")
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }
        context = persistentContainer.viewContext
    }
}
