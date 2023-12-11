//
//  DiabetesTrackerApp.swift
//  DiabetesTracker
//
//  Created by James Greiner on 11/28/23.
//

import SwiftUI
import SwiftData

@main
struct DiabetesTrackerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            GlucoseReading.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            GlucoseListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
