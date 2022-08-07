//
//  SplashViewController.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    // MARK: Subviews
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let label: UILabel = UILabel()

    // MARK: Dependencies
    private let viewModel: SplashViewModel

    init(viewModel: SplashViewModel) {
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
        showLoading()
        viewModel.viewLoaded()
    }
}

// MARK: Private setup methods
private extension SplashViewController {
    func setupView() {
        view.backgroundColor = .black
        view.addSubview(activityIndicator)
        view.addSubview(label)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 20.0),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func setupBindings() {
        viewModel.onError = { [weak self] in
            self?.showError()
        }
    }

    private func showLoading() {
        label.text = "Fetching your location"
        activityIndicator.startAnimating()
    }

    private func showError() {
        label.text = "Could not fetch your location.\nPlease enable location permission to continue"
        label.textColor = .red
    }
}
