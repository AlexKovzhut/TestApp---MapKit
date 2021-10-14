//
//  AppDelegate.swift
//  TestApp - MapKit
//
//  Created by Alexander Kovzhut on 09.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var windowScene: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        windowScene = UIWindow(frame: UIScreen.main.bounds)
        windowScene?.rootViewController = ViewController()
        windowScene?.makeKeyAndVisible()
        
        return true
    }

//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func appMatisyahulication(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//    }
//
//
//
}

