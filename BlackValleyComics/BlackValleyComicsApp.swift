//
//  BlackValleyComicsApp.swift
//  BlackValleyComics
//
//  Created by Eliel Kilembo on 1/28/24.
//

import SwiftUI

@main
struct BlackValleyComicsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
