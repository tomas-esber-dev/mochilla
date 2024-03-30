//
//  mochillaApp.swift
//  mochilla
//
//  Created by Tomas Esber on 3/28/24.
//

import SwiftUI
import Firebase

@main
struct mochillaApp: App {
    
    @StateObject var courseLoader = CourseLoader(apiClient: CoursesAPIClient())
    @StateObject var courseStore = CourseStore()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
                    .environmentObject(courseLoader)
                    .environmentObject(courseStore)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
