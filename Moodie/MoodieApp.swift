//
//  MoodieApp.swift
//  Moodie
//
//  Created by Virginia Zheng on 2025-02-17.
//

import SwiftUI
import SwiftData
import FirebaseCore
import UserNotifications

@main
struct MoodieApp: App {
    @StateObject private var notificationManager = NotificationManager.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
   // let locationManager = LocationManager()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
//                .environmentObject(WeatherAlertService(
//                    locationManager: locationManager,
//                    notificationManager: notificationManager
//                ))
                .onAppear {
                    notificationManager.requestAuthorization()
                }
        }
        .modelContainer(sharedModelContainer)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    
    // Register for remote notifications
    UNUserNotificationCenter.current().delegate = self
    application.registerForRemoteNotifications()

    return true
  }
  
  // Called when APNs has assigned the device a unique token
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    // Convert token to string
    let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
    let token = tokenParts.joined()
    print("Device Token: \(token)")
    
    // Forward the token to your server/Firebase
    // Firebase will automatically use this token if using Firebase Cloud Messaging
  }
  
  // Called when APNs failed to register the device for push notifications
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Failed to register for remote notifications: \(error)")
  }
}
