//
//  LinkMarkApp.swift
//  LinkMark
//
//  Created by t&a on 2024/01/04.
//

import SwiftUI

@main
struct LinkMarkApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
