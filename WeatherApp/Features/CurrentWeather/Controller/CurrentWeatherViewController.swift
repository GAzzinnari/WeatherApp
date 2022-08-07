//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import Foundation
import UIKit

class CurrentWeatherViewController: UIViewController {
    // MARK: Subviews
    private var weatherView: CurrentWeatherView = CurrentWeatherView()
    private var errorLabel: UILabel = UILabel()

    // MARK: Dependencies
    private let viewModel: CurrentWeatherViewModel

    init(viewModel: CurrentWeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle events
    override func viewDidLoad() {
        setupView()
        setupBindings()
        viewModel.fetchWeather()
    }
}

// MARK: Private setup methods
private extension CurrentWeatherViewController {
    func setupView() {
        view.backgroundColor = .black
        view.addSubview(weatherView)
        view.addSubview(errorLabel)

        weatherView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .systemRed

        NSLayoutConstraint.activate([
            weatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    func showWeather(data: WeatherDataUpdate) {
        weatherView.setup(with: data)
        weatherView.isHidden = false
        errorLabel.text = nil
    }

    func showError(error: String) {
        errorLabel.text = error
        weatherView.isHidden = true
    }

    func setupBindings() {
        viewModel.onWeatherDataChanged = { [weak self] update in
            DispatchQueue.main.async {
                self?.showWeather(data: update)
            }
        }
        viewModel.onGetWeatherError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showError(error: error)
            }
        }
    }
}

