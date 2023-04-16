//
//  CallManduApp.swift
//  CallMandu
//
//  Created by mandu on 2023/04/16.
//

import SwiftUI

@main
struct CallManduApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
