//
//  OrdersListModel.swift
//  OrderManagement
//
//  Created by Vara Prasad P on 16/11/18.
//  Copyright © 2018 VaraPrasadReddy. All rights reserved.
//

import Foundation
///Store Orders Info in this class
class OrdersListModel: NSObject {
    var orderNumber:String?
    var dueDate:String?
    var customerName:String?
    var customerAddress:String?
    var customerPhone:String?
    var orderTotal = 0
    //Init
    override init() {
        super.init()
    }
    init(withDictionary dictionary:[String:Any]) {
        self.dueDate  = dictionary["dueDate"] as? String
        self.customerName  = dictionary["customerName"] as? String
        self.customerAddress  = dictionary["customerAddress"] as? String
        self.customerPhone  = dictionary["customerPhone"] as? String
        self.orderTotal = dictionary["orderTotal"] as? Int ?? 0
        self.orderNumber = dictionary["orderNumber"] as? String
    }
}
