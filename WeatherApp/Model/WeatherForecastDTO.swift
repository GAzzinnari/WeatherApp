//
//  WeatherForecastDTO.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/9/22.
//

import Foundation

struct ForecastDTO: Decodable {
    let list: [ForecastItem]
}

struct ForecastItem: Decodable {
    let dt: Double // Day and time
    let weather: [ForecastWeather]
}

struct ForecastWeather: Decodable {
    let icon: String // icon
    let main: String // description
}
