//
//  WeatherForecastCell.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/9/22.
//

import Foundation
import UIKit

class WeatherForecastCell: UITableViewCell {
    private let iconImageView: UIImageView = UIImageView()
    private let descriptionLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with forecastItem: WeatherForecastItem) {
        iconImageView.loadAsync(url: URL(string: "https://openweathermap.org/img/wn/\(forecastItem.icon)@2x.png")!)
        descriptionLabel.text = forecastItem.description
        dateLabel.text = forecastItem.dayAndTime
    }

    override func prepareForReuse() {
        iconImageView.image = nil
        descriptionLabel.text = nil
        dateLabel.text = nil
    }

    private func setupView() {
        backgroundColor = .clear
        let labelStack = UIStackView()
        labelStack.axis = .vertical
        labelStack.spacing = 4

        dateLabel.textColor = .white
        descriptionLabel.textColor = .white

        labelStack.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false

        labelStack.addArrangedSubview(dateLabel)
        labelStack.addArrangedSubview(descriptionLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(labelStack)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
            labelStack.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            labelStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            labelStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
