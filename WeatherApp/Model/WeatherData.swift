//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import Foundation

struct WeatherData: Decodable, Equatable {
    let name: String
    let wind: Wind
    let main: Main
    let weather: [Weather]
}

struct Weather: Decodable, Equatable {
    let id: Int
    let description: String
    let icon: String
}

struct Wind: Decodable, Equatable {
    let speed: Double
    let deg: Int
}

struct Main: Decodable, Equatable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
}
