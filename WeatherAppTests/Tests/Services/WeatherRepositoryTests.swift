//
//  WeatherRepositoryTests.swift
//  WeatherAppTests
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import Foundation
import XCTest
@testable import WeatherApp

class WeatherRepositoryTests: XCTestCase {
    // Mocks & SUT
    private let mockData = WeatherData(
        name: "Montevideo",
        wind: Wind(speed: 14.9, deg: 270),
        main: Main(temp: 60, tempMin: 45, tempMax: 70),
        weather: [Weather(id: 1, description: "broken clouds", icon: "10d")]
    )
    private let mockLatitude = 10.123
    private let mockLongitude = -30.123
    private var networkHelper: NetworkHelperMock!
    private var subject: WeatherRepositoryDefault!

    // Helper properties
    private var getWeatherResult: Result<WeatherData, Error>?

    // MARK: Test cases
    func test_getCurrent_success() {
        givenSubject()
        givenGetWeatherIsCalled()

        whenGetWeatherSuccessfulResponse()

        thenGetWeatherInvokedWithCorrectParams()
        thenGetWeatherResultShouldBeSuccess()
    }

    func test_getCurrent_failure() {
        givenSubject()
        givenGetWeatherIsCalled()

        whenGetWeatherFailedResponse()

        thenGetWeatherInvokedWithCorrectParams()
        thenGetWeatherResultShouldBeFailure()
    }
}

extension WeatherRepositoryTests {
    // MARK: Given
    func givenSubject() {
        networkHelper = NetworkHelperMock()
        subject = WeatherRepositoryDefault(networkHelper: networkHelper)
    }

    func givenGetWeatherIsCalled() {
        subject.getCurrentWeather(latitude: mockLatitude, longitude: mockLongitude) { [weak self] result in
            self?.getWeatherResult = result
        }
    }

    // MARK: When
    func whenGetWeatherSuccessfulResponse() {
        networkHelper.resolve(with: .success(mockData))
    }

    func whenGetWeatherFailedResponse() {
        let result: Result<WeatherData, NetworkError> = .failure(.errorStatus)
        networkHelper.resolve(with: result)
    }

    // MARK: Then
    func thenGetWeatherResultShouldBeSuccess() {
        guard case .success(let actualData) = getWeatherResult else {
            return XCTFail("Expected getWeather result to be success")
        }
        XCTAssertEqual(mockData, actualData)
    }

    func thenGetWeatherResultShouldBeFailure() {
        guard case .failure(let error) = getWeatherResult else {
            return XCTFail("Expected getWeather result to be failure")
        }
        XCTAssertNotNil(error)
    }

    func thenGetWeatherInvokedWithCorrectParams() {
        XCTAssertTrue(networkHelper.didCallGet)
        XCTAssertEqual(networkHelper.didCallGetUrl, "https://api.openweathermap.org/data/2.5/weather")
        XCTAssertEqual(networkHelper.didCallGetQueryParams?["appid"], "d4277b87ee5c71a468ec0c3dc311a724")
        XCTAssertEqual(networkHelper.didCallGetQueryParams?["lat"], "10.123")
        XCTAssertEqual(networkHelper.didCallGetQueryParams?["lon"], "-30.123")
        XCTAssertEqual(networkHelper.didCallGetQueryParams?["units"], "imperial")
    }
}
