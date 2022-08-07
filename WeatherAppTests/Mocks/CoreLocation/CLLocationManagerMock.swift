//
//  CLLocationManagerMock.swift
//  WeatherAppTests
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import Foundation
import CoreLocation

class CLLocationManagerMock: CLLocationManager {
    var didCallRequestLocation: Bool = false
    var didCallRequestWhenInUseAuthorization: Bool = false

    override func requestLocation() {
        didCallRequestLocation = true
    }

    override func requestWhenInUseAuthorization() {
        didCallRequestWhenInUseAuthorization = true
    }
}
