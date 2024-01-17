//
//  UIButtonExtension.swift
//  SeSAC4Network
//
//  Created by Minho on 1/17/24.
//

import Foundation
import UIKit

extension UIButton {
    func configureStyle() {
        self.tintColor = .black
        self.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.titleLabel?.textAlignment = .center
    }
}
