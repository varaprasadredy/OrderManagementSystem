//
//  UserDefaults+helpers.swift
//  OrderManagement
//
//  Created by VaraPrasadReddy on 11/16/18.
//  Copyright © 2018 VaraPrasadReddy. All rights reserved.
//

import Foundation
/**
 This Extension is used for maintain the login status and more
 */
extension UserDefaults {
    ///This Enumaretion is used for maintain the Login Status and more
    enum UserDefaultsKeys: String {
        case isLoggedIn
    }
    ///Set Login Status Value
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    ///Login Status
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
}
