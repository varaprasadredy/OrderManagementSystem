//
//  AddEditOrderViewController.swift
//  OrderManagement
//
//  Created by VaraPrasadReddy on 11/18/18.
//  Copyright © 2018 VaraPrasadReddy. All rights reserved.
//

import UIKit
/**
 This AddEditOrderViewController is used for Add or Edit the Order Details.
 ## UI Properties
 - Customer Name Text Field
 - Customer Phone Number Text Field
 - Customer Address Text Field
 - Order Date Text Field
 - Total Order Stepper
 - Cancel Button
 - Done Button
 - Title Label
 - Orders Count Label
 
 ## Written and Used Methods
 1. **doneAction()** : is used for check the validation and save the orders data.
 2. **cancelAction()** : This method is used for dismiss the view controller.
 3. **totalOrdersStepperAction()** : This method is used for increase or decrease the total orders.
 */
class AddEditOrderViewController: UIViewController {
    //Properties
    @IBOutlet weak var customerNameField: UITextField!
    @IBOutlet weak var customerPhoneNumberField: UITextField!
    @IBOutlet weak var customerAddressField: UITextField!
    @IBOutlet weak var orderDateField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalOrdersLabel: UILabel!
    @IBOutlet weak var totalOrdersStepper: UIStepper!

    //Orders Count
    var totalOrders:Int = 0
    //CompletionHandler for pass the add or edit data
    typealias CompletionHandler = (_ order: OrdersListModel?) -> Void
    //Maintain Bool value
    var isEditOrder:Bool = false
    //Model for save order details
    var orderModel: OrdersListModel?
    // Set closure for edit or add order.
    public var completion: CompletionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.orderDateField.inputView = datePicker
        self.orderDateField.inputAccessoryView = toolbar
        self.totalOrdersLabel.text = "Total Orders: " + String(totalOrders)

        if isEditOrder {
            self.titleLabel.text = "Edit your order"
            //Populate order details
            self.customerNameField.text = orderModel?.customerName
            self.customerPhoneNumberField.text = orderModel?.customerPhone
            self.customerAddressField.text = orderModel?.customerAddress
            self.orderDateField.text = orderModel?.dueDate
            self.totalOrders = orderModel?.orderTotal ?? 0
            self.totalOrdersLabel.text = "Total Orders: " + String(totalOrders)
            //Set total orders value
            self.totalOrdersStepper.value = Double(self.totalOrders)
        }
    }
    
    ///Date Picker for Order Due Date
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        return picker
    }()
    
    ///Date Formatter
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    //Tool bar
    lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        toolbar.barStyle = .blackTranslucent
        toolbar.tintColor = .white
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed(_:)))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed(_:)))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([cancelButton, flexButton, doneButton], animated: true)
        return toolbar
    }()
    
    ///This method is used for dismiss the date picker view
    @objc func cancelPressed(_ sender: UIBarButtonItem) {
        self.orderDateField.resignFirstResponder()
    }
    
    ///This method is used for get the date form date picker
    @objc func donePressed(_ sender: UIBarButtonItem) {
        self.orderDateField.text = dateFormatter.string(from: self.datePicker.date)
        self.orderDateField.resignFirstResponder()
    }
    
    ///This metho is used for check the validation and save the orders data.
    @IBAction func doneAction(){
        self.view.endEditing(true)
        //Check  Name Text Field
        guard let name = customerNameField.text, !name.isEmpty else{
            Utility().customAlertMessage("Error", message: "Enter your name", alertButtonTitles: ["OK"], alertButtonStyles: [.default], vc: self, completion: { (Int) in
            })
            return
        }
        //Check Phone Number Text Field
        guard let phoneNumber = customerPhoneNumberField.text, !phoneNumber.isEmpty, phoneNumber.count==10 else{
            Utility().customAlertMessage("Error", message: "Enter valid phone number", alertButtonTitles: ["OK"], alertButtonStyles: [.default], vc: self, completion: { (Int) in
            })
            return
        }
        //Check  Address Text Field
        guard let address = customerAddressField.text, !address.isEmpty else{
            Utility().customAlertMessage("Error", message: "Enter your address", alertButtonTitles: ["OK"], alertButtonStyles: [.default], vc: self, completion: { (Int) in
            })
            return
        }
        //Check Order Date Text Field
        guard let orderDate = orderDateField.text, !orderDate.isEmpty else{
            Utility().customAlertMessage("Error", message: "Select order due date", alertButtonTitles: ["OK"], alertButtonStyles: [.default], vc: self, completion: { (Int) in
            })
            return
        }
        if isEditOrder == false{
            //Create Instance of OderListModel
            orderModel = OrdersListModel()
            let orderNumber = UUID().uuidString.split(separator: "-").first
            orderModel?.orderNumber = String(orderNumber ?? "12345")
        }
        orderModel?.customerName = self.customerNameField.text
        orderModel?.customerPhone = self.customerPhoneNumberField.text
        orderModel?.customerAddress = self.customerAddressField.text
        orderModel?.dueDate = self.orderDateField.text
        orderModel?.orderTotal = totalOrders
        //Pass OrderModel data
        completion?(orderModel)
    }
    
    ///Dismiss view controller
    @IBAction func cancelAction(_ sender: UIButton){
        self.dismiss(animated: false, completion: nil)
    }
    
    ///This method is used for increase or decrease the total orders.
    @IBAction func totalOrdersStepperAction(_ sender: UIStepper){
        self.totalOrders = Int(sender.value)
        self.totalOrdersLabel.text = "Total Orders: " + String(totalOrders)
    }
    
    /// This method is used for pass the data or update the data.
    func setCompletionHandler(handler:@escaping CompletionHandler){
        completion = handler
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
//MARK: UITextFieldDelgate Methods
extension AddEditOrderViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == customerNameField {
            customerPhoneNumberField.becomeFirstResponder()
        }
        if textField == customerPhoneNumberField {
            customerAddressField.becomeFirstResponder()
        }
        if textField == customerAddressField {
            orderDateField.becomeFirstResponder()
        }
        if textField == orderDateField {
            orderDateField.resignFirstResponder()
            doneAction()
        }
        return true
    }
}
