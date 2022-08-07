//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import UIKit

class CurrentWeatherView: UIView {
    private let container: UIStackView = UIStackView()
    private let cityLabel: UILabel = UILabel()
    private let weatherImageView: UIImageView = UIImageView()
    private let descriptionLabel: UILabel = UILabel()
    private let tempLabel: UILabel = UILabel()
    private let tempHiLoLabel: UILabel = UILabel()
    private let windLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupSubviewsStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with data: WeatherDataUpdate) {
        cityLabel.text = data.cityName
        tempLabel.text = data.temperature
        tempHiLoLabel.text = data.temperatureHighLow
        descriptionLabel.text = data.description
        windLabel.text = data.wind
        data.iconUrl.map { weatherImageView.loadAsync(url: $0) }
    }

    private func setupSubviews() {
        container.axis = .vertical
        container.alignment = .center
        container.spacing = 16.0

        container.addArrangedSubview(cityLabel)
        container.addArrangedSubview(weatherImageView)
        container.addArrangedSubview(tempLabel)
        container.addArrangedSubview(descriptionLabel)
        container.addArrangedSubview(tempHiLoLabel)
        container.addArrangedSubview(windLabel)

        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: 120),
            weatherImageView.widthAnchor.constraint(equalToConstant: 120),
        ])
    }

    private func setupSubviewsStyle() {
        cityLabel.textColor = .lightGray
        cityLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        tempLabel.textColor = .lightGray
        tempLabel.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = UIFont.systemFont(ofSize: 24, weight: .light)
        tempHiLoLabel.textColor = .lightGray
        tempHiLoLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        windLabel.textColor = .lightGray
        windLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
}
