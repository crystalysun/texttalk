//
//  TextTalkApp.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/6/23.
//

import SwiftUI
//import FirebaseCore
//import FirebaseAuth

//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}


@main
struct TextTalkApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
//            if Auth.auth().currentUser == nil {
//                SignInView()
//            }
//            else {
                ContentView()
//            }
        }
    }
}
