//
//  UILabelHelper.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import UIKit

extension UILabel {
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.masksToBounds = true
    }
}
