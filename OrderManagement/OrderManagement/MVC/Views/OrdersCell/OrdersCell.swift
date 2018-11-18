//
//  OrdersCell.swift
//  OrderManagement
//
//  Created by VaraPrasadReddy on 11/17/18.
//  Copyright © 2018 VaraPrasadReddy. All rights reserved.
//

import UIKit
/**
    This OrdersCell used for display the user orders infomation.
 */
class OrdersCell: UITableViewCell {
    //Properties
    @IBOutlet weak var customerName : UILabel!
    @IBOutlet weak var customerPhone : UILabel!
    @IBOutlet weak var customerAddress : UILabel!
    @IBOutlet weak var orderNumber : UILabel!
    @IBOutlet weak var dueDate : UILabel!
    @IBOutlet weak var ordersCount : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    ///Set the OrdersListModel data to cell properties
    var ordersListModel: OrdersListModel! {
        didSet {
            customerName?.text = ordersListModel.customerName
            customerPhone?.text = ordersListModel.customerPhone
            customerAddress?.text = ordersListModel.customerAddress
            orderNumber?.text = "Order Num: #" + (ordersListModel.orderNumber ?? "")
            dueDate?.text = ordersListModel.dueDate
            ordersCount?.text = "Orders: " + String(ordersListModel.orderTotal)
        }
    }
}
