//
//  Constants.swift
//  OrderManagement
//
//  Created by VaraPrasadReddy on 11/16/18.
//  Copyright © 2018 VaraPrasadReddy. All rights reserved.
//

import Foundation
import UIKit

/**
 This Struct Constants is used for Alert,Suggestand Constant Messages
 */
struct Constants {
    ///No Internet Connection Alert Messages
    struct Internet {
        static let noInternetTitle = "No Internet Connection"
        static let noInternetMsg = "Check your internet connection and try again"
    }
    ///Login Failed Alert Messages
    struct Login {
        static let loginFailedTitle = "Login Failed"
        static let emailErrorMsg = "Enter your valid username"
        static let passwordErrorMsg = "Enter your correct password"
    }
    /**
     Global Error Messages like Error Title String and Msg String like Something Went wrong
     */
    struct Error {
        static let errorTitle = "Error"
        static let errorMsg = "Something went wrong, Please try again"
    }
}

