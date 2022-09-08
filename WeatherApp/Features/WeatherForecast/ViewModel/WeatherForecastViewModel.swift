//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/9/22.
//

import Foundation

class WeatherForecastViewModel {
    private let latitude: Double
    private let longitude: Double
    private let repository: WeatherRepository
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, HH:mm"
        return formatter
    }()


    init(latitude: Double, longitude: Double, repository: WeatherRepository = WeatherRepositoryDefault()) {
        self.latitude = latitude
        self.longitude = longitude
        self.repository = repository
    }

    func fetchForecastData(completion: @escaping ([WeatherForecastItem]) -> Void) {
        repository.getWeatherForecast(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let data):
                completion(data.list.map(WeatherForecastViewModel.map))
            case .failure:
                break
                // TODO: Implement
            }
        }
    }

    private static func map(_ data: ForecastItem) -> WeatherForecastItem {
        let date = Date(timeIntervalSince1970: data.dt)
        return WeatherForecastItem(dayAndTime: WeatherForecastViewModel.dateFormatter.string(from: date),
                                   description: data.weather.first?.main ?? "No description",
                                   icon: data.weather.first?.icon ?? "No icon") // TODO: Check how to handle no icon
    }
}
