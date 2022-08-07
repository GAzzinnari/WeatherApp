//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import Foundation

protocol WeatherRepository {
    func getCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherData, Error>) -> Void)
}

class WeatherRepositoryDefault: WeatherRepository {
    // MARK: Dependencies
    private let networkHelper: NetworkHelper

    init(networkHelper: NetworkHelper = NetworkHelperDefault()) {
        self.networkHelper = networkHelper
    }

    func getCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let url = Constants.baseURL
        let queryParams = buildGetWeatherParams(latitude: latitude, longitude: longitude)
        networkHelper.get(url: url,
                          queryParams: queryParams,
                          responseType: WeatherData.self,
                          completion: { result in
            completion(result.mapError { $0 as Error })
        })
    }
}

private extension WeatherRepositoryDefault {
    private func buildGetWeatherParams(latitude: Double, longitude: Double) -> [String: String] {
        return [
            Keys.latitude: "\(latitude)",
            Keys.longitude: "\(longitude)",
            Keys.appId: Constants.appId,
            Keys.units: Constants.units
        ]
    }

    private enum Keys {
        static let latitude = "lat"
        static let longitude = "lon"
        static let appId = "appid"
        static let units = "units"
    }

    // This constants could be extracted to plist / xcconfig files and fetched by means of another object,
    // that'd enable different environments to be ran, better secrets management, etc.
    private enum Constants {
        static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
        static let appId = "ADD-WORKING-APP-ID-HERE"
        static let units = "imperial"
    }
}
