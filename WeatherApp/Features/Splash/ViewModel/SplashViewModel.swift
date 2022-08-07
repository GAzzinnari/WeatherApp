//
//  SplashViewModel.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import Foundation

protocol SplashViewModel: AnyObject {
    // Bindings
    var onError: () -> Void { get set }

    // Actions
    func viewLoaded()
}

class SplashViewModelDefault: SplashViewModel {
    var onError: () -> Void = { }

    // MARK: Dependencies
    private let coordinator: MainCoordinator
    private let locationHelper: LocationHelper

    init(coordinator: MainCoordinator,
         locationHelper: LocationHelper = LocationHelperDefault()) {
        self.coordinator = coordinator
        self.locationHelper = locationHelper
    }

    /// Loads dependencies.
    func viewLoaded() {
        locationHelper.getCurrent { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let coordinate):
                    self.handleGetLocationSuccess(latitude: coordinate.latitude,
                                                  longitude: coordinate.longitude)
                case .failure:
                    self.handleGetLocationError()
                }
            }
        }
    }
}

private extension SplashViewModelDefault {
    private func handleGetLocationSuccess(latitude: Double, longitude: Double) {
        coordinator.showCurrentWeather(latitude: latitude, longitude: longitude)
    }

    private func handleGetLocationError() {
        onError()
    }
}
