//
//  UITableViewCell+Identifier.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/9/22.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }
}
