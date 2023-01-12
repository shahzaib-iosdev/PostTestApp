//
//  PostTestAppApp.swift
//  PostTestApp
//
//  Created by CrownSDS on 10/01/2023.
//

import SwiftUI

@main
struct PostTestAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
