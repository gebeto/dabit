//
//  dabitApp.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI
import CoreData


@main
struct dabitApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
