//
//  Persistence.swift
//  TodosList
//
//  Created by Вячеслав Квашнин on 22.02.2021.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "TodosList")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}
