//
//  UIButton+helpers.swift
//  OrderManagement
//
//  Created by VaraPrasadReddy on 11/16/18.
//  Copyright © 2018 VaraPrasadReddy. All rights reserved.
//

import Foundation
import UIKit
///UIButton Custom Methods
extension UIButton {
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    func setShadow(_ color:UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1.0
    }
}
