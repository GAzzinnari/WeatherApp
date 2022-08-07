//
//  LocationHelperTests.swift
//  WeatherAppTests
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import XCTest
import CoreLocation
@testable import WeatherApp

class LocationHelperTests: XCTestCase {
    // MARK: Mocks & SUT
    private let mockError: NSError = NSError(domain: "", code: 0, userInfo: nil)
    private let mockLocation: CLLocation = CLLocation(latitude: 10.0,
                                                      longitude: 20.0)
    private var locationManager: CLLocationManagerMock!
    private var subject: LocationHelperDefault!

    // MARK: Helper properties
    private var getLocationResult: Result<CLLocationCoordinate2D, Error>?

    func test_getLocation_success() {
        givenSubject()
        givenFetchLocationRequest()

        whenFetchLocationResponseHasLocation()

        thenFetchLocationResultIsSuccessful()
    }

    func test_getLocation_noLocationsReturned() {
        givenSubject()
        givenFetchLocationRequest()

        whenFetchLocationResponseHasNoLocation()

        thenFetchLocationResultIsFailed()
    }

    func test_getLocation_failure() {
        givenSubject()
        givenFetchLocationRequest()

        whenFetchLocationResponseFails()

        thenFetchLocationResultIsFailed()
    }
}

private extension LocationHelperTests {
    // MARK: Given
    func givenSubject() {
        locationManager = CLLocationManagerMock()
        subject = LocationHelperDefault(locationManager: locationManager)
    }

    func givenFetchLocationRequest() {
        subject.getCurrent { [weak self] result in
            self?.getLocationResult = result
        }
    }

    // MARK: When
    func whenFetchLocationResponseHasLocation() {
        subject.locationManager(locationManager, didUpdateLocations: [mockLocation])
    }

    func whenFetchLocationResponseHasNoLocation() {
        subject.locationManager(locationManager, didUpdateLocations: [])
    }

    func whenFetchLocationResponseFails() {
        subject.locationManager(locationManager, didFailWithError: mockError)
    }

    // MARK: Then
    func thenFetchLocationResultIsSuccessful() {
        guard case .success(let coordinates) = getLocationResult else {
            return XCTFail("Expected result to be success")
        }
        XCTAssertEqual(coordinates.latitude, mockLocation.coordinate.latitude)
        XCTAssertEqual(coordinates.longitude, mockLocation.coordinate.longitude)
    }

    func thenFetchLocationResultIsFailed() {
        guard case .failure(let error) = getLocationResult else {
            return XCTFail("Expected result to be failure")
        }
        XCTAssertNotNil(error)
    }
}
