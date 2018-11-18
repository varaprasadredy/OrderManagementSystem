//
//  RoundedTextField.swift
//  OrderManagement
//
//  Created by VaraPrasadReddy on 11/16/18.
//  Copyright © 2018 VaraPrasadReddy. All rights reserved.
//

import Foundation
import UIKit

class RoundedTextField: UITextField{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setCornerRadius(5.0)
        self.clipsToBounds = true
        //Set Left Padding
        self.setLeftPaddingPoints()
        self.borderStyle = .roundedRect
        //Remove Spell Check
        self.spellCheckingType = .no
    }
}
