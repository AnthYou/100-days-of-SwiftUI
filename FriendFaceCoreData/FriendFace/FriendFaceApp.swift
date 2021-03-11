//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Anthony You on 09/03/2021.
//

import SwiftUI
import CoreData

@main
struct FriendFaceApp: App {
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
