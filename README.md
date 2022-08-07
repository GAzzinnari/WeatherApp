# WeatherApp

## App that displays current weather conditions based on user's location.

## Frameworks / APIs
* UIKit
* CoreLocation
* URLSession
* JSONDecoder / Codable
* XCTest

## Build & Run
For the purpose of this challenge no third-party dependency was used, so CocoaPods wasn't needed. To run simply open `WeatherApp.xcodeproj`, select `WeatherApp` scheme, select an iOS device and click Start or `Cmd + R`.

## Running on Simulator
If project is ran on a Simulator, the app needs to have a mocked location. To do this, on `WeatherApp` scheme, select "Edit scheme", "Run" and under "Options" tab select any location from "Default Location" item.

## Tests
The project contains a couple of test classes to showcase XCTest usage with current implementation. To execute the entire test suite follow same instructions as above, except for last step, type `Cmd + U` instead to run the test bundle.