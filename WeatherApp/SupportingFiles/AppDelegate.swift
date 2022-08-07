//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = MainCoordinator(window: window)
        coordinator.start()
        return true
    }
}
