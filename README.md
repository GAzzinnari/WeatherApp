# WeatherApp

## App that displays current weather conditions based on user's location.

## Screenshots
<p align="middle">
  <img src="https://user-images.githubusercontent.com/67511162/183927275-b849bb09-f66c-4c64-8580-37a97be3e83d.png" data-canonical-src="https://user-images.githubusercontent.com/67511162/183927275-b849bb09-f66c-4c64-8580-37a97be3e83d.png" width="20%" />
  <img src="https://user-images.githubusercontent.com/67511162/183927264-bc0baa11-5cf0-4ca7-b586-596a8221d80c.png" data-canonical-src="https://user-images.githubusercontent.com/67511162/183927264-bc0baa11-5cf0-4ca7-b586-596a8221d80c.png" width="20%" />
</p>

## Frameworks / APIs
* UIKit
* CoreLocation
* URLSession
* JSONDecoder / Codable
* XCTest

## Prerequisites
* Xcode
* OpenWeatherMap API Key

## Setup API Key
Create an API key for your project (https://openweathermap.org/appid#use) and replace mock value in `WeatherRepository.Constants.appId` to your API key.

## Build & Run
For the purpose of this challenge no third-party dependency was used, so CocoaPods wasn't needed. To run simply open `WeatherApp.xcodeproj`, select `WeatherApp` scheme, select an iOS device and click Start or `Cmd + R`.

## Running on Simulator
If project is ran on a Simulator, the app needs to have a mocked location. To do this, on `WeatherApp` scheme, select "Edit scheme", "Run" and under "Options" tab select any location from "Default Location" item.

## Tests
The project contains a couple of test classes to showcase XCTest usage with current implementation. To execute the entire test suite follow same instructions as above, except for last step, type `Cmd + U` instead to run the test bundle.
