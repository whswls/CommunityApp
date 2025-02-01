//
//  CommunityAppApp.swift
//  CommunityApp
//
//  Created by 존진 on 1/21/25.
//

import SwiftUI
import SwiftData

@main
struct CommunityAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Member.self,
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
