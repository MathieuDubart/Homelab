//
//  HomelabApp.swift
//  Homelab
//
//  Created by Mathieu Dubart on 18/03/2026.
//

import SwiftUI
import UserNotifications

@main
struct HomelabApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: requestNotificationPermission)
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("✅ Permission accordée !")
            } else if let error = error {
                print("❌ Erreur permission : \(error.localizedDescription)")
            }
        }
    }
}
