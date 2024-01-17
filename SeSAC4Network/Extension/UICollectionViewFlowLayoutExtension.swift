//
//  UICollectionViewFlowLayoutExtension.swift
//  SeSAC4Network
//
//  Created by Minho on 1/17/24.
//

import UIKit

extension UICollectionViewFlowLayout {
    func setupLayout() {
        let twoItems = (UIScreen.main.bounds.width / 2.0) - 24
        self.itemSize = CGSize(width: twoItems, height: twoItems)
        self.minimumLineSpacing = 8
        self.minimumInteritemSpacing = 0
        self.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        self.scrollDirection = .vertical
    }
}
