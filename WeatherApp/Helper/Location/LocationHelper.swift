//
//  LocationHelper.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import Foundation
import CoreLocation

protocol LocationHelper {
    func getCurrent(completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void)
}

class LocationHelperDefault: NSObject, LocationHelper {
    private var locationManager: CLLocationManager
    private var getCurrentCompletion: ((Result<CLLocationCoordinate2D, Error>) -> Void)?

    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }

    func getCurrent(completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        getCurrentCompletion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

// MARK: CLLocationManagerDelegate extension
extension LocationHelperDefault: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let completion = getCurrentCompletion else { return }
        if let coordinate = locations.last?.coordinate {
            completion(.success(coordinate))
        } else {
            completion(.failure(NSError(domain: Bundle.main.bundleIdentifier ?? "", code: 1, userInfo: nil)))
        }
        getCurrentCompletion = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let completion = getCurrentCompletion {
            completion(.failure(error))
            getCurrentCompletion = nil
        }
    }
}
