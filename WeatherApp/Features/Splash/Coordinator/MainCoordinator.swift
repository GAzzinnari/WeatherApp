//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import Foundation
import UIKit

class MainCoordinator {
    private weak var window: UIWindow?
    private weak var navigation: UINavigationController?

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        let viewModel = SplashViewModelDefault(coordinator: self)
        let controller = SplashViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        self.navigation = navigation
    }

    func showCurrentWeather(latitude: Double, longitude: Double) {
        let viewModel = CurrentWeatherViewModelDefault(latitude: latitude, longitude: longitude)
        let controller = CurrentWeatherViewController(viewModel: viewModel)
        if let previous = navigation?.viewControllers.first?.view {
            UIView.transition(from: previous,
                              to: controller.view,
                              duration: 0.5,
                              options: [.transitionCrossDissolve],
                              completion: { _ in
                self.navigation?.viewControllers = [controller]
            })
        }
    }
}
