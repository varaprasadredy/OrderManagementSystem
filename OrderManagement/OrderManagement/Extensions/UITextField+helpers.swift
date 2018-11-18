//
//  UITextField+helpers.swift
//  OrderManagement
//
//  Created by VaraPrasadReddy on 11/16/18.
//  Copyright © 2018 VaraPrasadReddy. All rights reserved.
//

import Foundation
import UIKit
//Text Type
public enum TextType {
    /// UITextField is used to enter email addresses.
    case emailAddress
    
    /// UITextField is used to enter passwords.
    case password
    
    /// UITextField is used to enter generic text.
    case generic
}
///UITextField extenstion with some methods
/// UITextField text type.
/// - emailAddress: UITextField is used to enter email addresses.
/// - password: UITextField is used to enter passwords.
/// - generic: UITextField is used to enter generic text.
///Some UITextField methods
public extension UITextField {
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    func setLeftPaddingPoints(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ padding:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
        /// Check if textFields text is a valid email format.
        public var hasValidEmail: Bool {
            return text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                               options: String.CompareOptions.regularExpression,
                               range: nil, locale: nil) != nil
        }
        /// Set placeholder text color.
        ///
        /// - Parameter color: placeholder text color.
        public func setPlaceHolderTextColor(_ color: UIColor) {
            guard let holder = placeholder, !holder.isEmpty else { return }
            self.attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
        }
        /// SwifterSwift: Return text with no spaces or new lines in beginning and end.
        public var trimmedText: String? {
            return text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        /// SwifterSwift: Check if text field is empty.
        public var isEmpty: Bool {
            return text?.isEmpty == true
        }
        /// SwifterSwift: Set textField for common text types.
        public var textType: TextType {
            get {
                if keyboardType == .emailAddress {
                    return .emailAddress
                } else if isSecureTextEntry {
                    return .password
                }
                return .generic
            }
            set {
                switch newValue {
                case .emailAddress:
                    keyboardType = .emailAddress
                    autocorrectionType = .no
                    autocapitalizationType = .none
                    isSecureTextEntry = false
                    placeholder = "Email Address"
                    
                case .password:
                    keyboardType = .asciiCapable
                    autocorrectionType = .no
                    autocapitalizationType = .none
                    isSecureTextEntry = true
                    placeholder = "Password"
                    
                case .generic:
                    isSecureTextEntry = false
                }
            }
        }
    }
