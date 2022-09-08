//
//  WeatherForecastViewController.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/9/22.
//

import Foundation
import UIKit

class WeatherForecastViewController: UIViewController {
    private let tableView: UITableView = UITableView()

    private let viewModel: WeatherForecastViewModel
    private var forecastItems: [WeatherForecastItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    init(viewModel: WeatherForecastViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.fetchForecastData(completion: { [weak self] forecastData in
            DispatchQueue.main.async {
                self?.forecastItems = forecastData
            }
        })
    }

    private func setupView() {
        view.backgroundColor = .black
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(WeatherForecastCell.self, forCellReuseIdentifier: WeatherForecastCell.identifier)

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: UITableView delegation
extension WeatherForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < forecastItems.count,
              let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForecastCell.identifier),
              let itemCell = cell as? WeatherForecastCell else { return UITableViewCell() }

        itemCell.setup(with: forecastItems[indexPath.row])
        return itemCell
    }
}
