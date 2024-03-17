//
//  AppDelegate.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 09.02.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        window.makeKeyAndVisible()
        
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "GrayText")
        
        return true
    }

    private func setupProviders() {
        
    }
}

