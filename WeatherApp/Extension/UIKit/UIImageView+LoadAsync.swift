//
//  UIImageView+LoadAsync.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import Foundation
import UIKit

extension UIImageView {
    func loadAsync(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
