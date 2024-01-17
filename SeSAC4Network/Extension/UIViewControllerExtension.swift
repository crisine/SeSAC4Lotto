//
//  UIViewControllerExtension.swift
//  SeSAC4Network
//
//  Created by Minho on 1/17/24.
//

import UIKit

extension UIViewController: ReusableViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
}
