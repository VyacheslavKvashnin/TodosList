//
//  TodosListApp.swift
//  TodosList
//
//  Created by Вячеслав Квашнин on 22.02.2021.
//

import SwiftUI

@main
struct TodosListApp: App {
    let persistenceContainer = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
