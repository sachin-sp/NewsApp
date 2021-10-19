//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Sachin on 18/10/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        CoreDataStack.shared.setup { }
        let tabBarControl = TabBarController()
        window?.rootViewController = tabBarControl
        
        return true
    }

}

