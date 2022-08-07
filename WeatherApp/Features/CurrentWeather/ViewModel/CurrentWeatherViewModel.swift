//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import Foundation

protocol CurrentWeatherViewModel: AnyObject {
    // Bindings
    var onWeatherDataChanged: (WeatherDataUpdate) -> Void { get set }
    var onGetWeatherError: (String) -> Void { get set }

    // Actions
    func fetchWeather()
}

class CurrentWeatherViewModelDefault: CurrentWeatherViewModel {
    // MARK: Bindings
    var onWeatherDataChanged: (WeatherDataUpdate) -> Void = { _ in }
    var onGetWeatherError: (String) -> Void = { _ in }

    // MARK: Properties / constants
    private let latitude: Double
    private let longitude: Double

    // MARK: Dependencies
    private let weatherRepository: WeatherRepository

    init(latitude: Double, longitude: Double, weatherRepository: WeatherRepository = WeatherRepositoryDefault()) {
        self.latitude = latitude
        self.longitude = longitude
        self.weatherRepository = weatherRepository
    }

    // MARK: Actions
    func fetchWeather() {
        weatherRepository.getCurrentWeather(latitude: latitude,
                                            longitude: longitude) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherData):
                self.handleGetWeatherSuccess(weatherData: weatherData)
            case .failure:
                self.handleGetWeatherError()
            }
        }
    }
}

// MARK: Private methods
private extension CurrentWeatherViewModelDefault {
    func handleGetWeatherSuccess(weatherData: WeatherData) {
        guard let weather = weatherData.weather.first else {
            handleGetWeatherError()
            return
        }
        let weatherUpdate = WeatherDataUpdate(cityName: weatherData.name,
                                              iconUrl: URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png"),
                                              description: weather.description,
                                              temperature: "\(weatherData.main.temp)°",
                                              temperatureHighLow: "Low: \(weatherData.main.tempMin) - High: \(weatherData.main.tempMax)",
                                              wind: "Wind: \(weatherData.wind.speed) (\(weatherData.wind.deg))")
        onWeatherDataChanged(weatherUpdate)
    }

    func handleGetWeatherError() {
        onGetWeatherError("Could not fetch current weather information")
    }
}

// MARK: Helper types
struct WeatherDataUpdate {
    let cityName: String
    let iconUrl: URL?
    let description: String
    let temperature: String
    let temperatureHighLow: String
    let wind: String
}
