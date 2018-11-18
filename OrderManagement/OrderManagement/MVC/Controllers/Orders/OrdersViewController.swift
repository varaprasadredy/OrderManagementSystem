//
//  OrdersViewController.swift
//  OrderManagement
//
//  Created by VaraPrasadReddy on 11/16/18.
//  Copyright © 2018 VaraPrasadReddy. All rights reserved.
//

import UIKit
/**
 This OrdersViewController is used for to displayed the list of orders.
 ## UI Properties
 - TableView
 - TableViewCell
 - RightBarButton
## Functionality
 1. Display the Orders List.
 2. User can add new order.
 3. User can edit order.
 4. User can delete the order.
 */
class OrdersViewController: UITableViewController {
    var orders = [OrdersListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title =  "Orders"
        fetchData()
        registerOrdersTableCell()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "New Order",style: .plain, target: self,action: #selector(addNewOrderAction)
        )
    }
    
    ///New Order Action is is used for popup(present) the AddEditOrderViewController.
    @objc func addNewOrderAction(){
       presentOrderPopup(isEditOrder: false, order: nil)
    }
    ///
    func presentOrderPopup(isEditOrder:Bool, order:OrdersListModel!){
        let addOrderVC = self.storyboard?.instantiateViewController(withIdentifier: "AddndEditOrder") as? AddEditOrderViewController
        addOrderVC?.isEditOrder = isEditOrder
        addOrderVC?.orderModel = order
        addOrderVC?.setCompletionHandler(handler: { (order) in
            self.dismiss(animated: false, completion: nil)
            if order != nil && isEditOrder == false{
                // Add Order
               self.orders.append(order!)
            }
            self.tableView.reloadData()
        })
        addOrderVC?.modalPresentationStyle = .overCurrentContext
        addOrderVC?.view.backgroundColor = UIColor.clear
        present(addOrderVC!, animated: false, completion: nil)
    }
    
    
    ///Register TableView Cell
    func registerOrdersTableCell(){
        tableView.register(UINib.init(nibName: "OrdersCell", bundle: nil), forCellReuseIdentifier: "OrdersCell")
    }
    
    ///This method is used for fetch json data from "Orders" json file.
    fileprivate func fetchData() {
        //self.courseViewModels = courses?.map({return CourseViewModel(course: $0)}) ?? []
        let jsonData = Utility().loadJson(filename: "Orders")
        for i in 0 ..< jsonData.count{
            let info = jsonData[i] as! [String:AnyObject]
            self.orders.append(OrdersListModel(withDictionary: info))
        }
        self.tableView.reloadData()
    }
    ///This method is used for need to ask user permission to delete order
    func deleteOrderWithPermission(indexPath:Int) {
        let alertController = UIAlertController(title: "Are you sure you want to delete this order?",
                                                message: "",
                                                preferredStyle: .alert)
        //Cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        //Delete
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action) in
            self.orders.remove(at: indexPath)
            self.tableView.reloadData()
        }
        alertController.addAction(deleteAction)
        //Present
        self.present(alertController, animated: true, completion: nil)
    }
    ///TableView Delegate and Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Orders Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersCell", for: indexPath) as! OrdersCell
        //Selection Style
        cell.selectionStyle = .none
        let ordersListModel = orders[indexPath.row]
        cell.ordersListModel = ordersListModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            print("Delete Button Tapped")
            self.deleteOrderWithPermission(indexPath: indexPath.row)
        }
        
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            // Edit item at indexPath
            print("Edit Button Tapped")
            let ordersListModel = self.orders[indexPath.row]
            self.presentOrderPopup(isEditOrder: true, order: ordersListModel)
        }
        edit.backgroundColor = UIColor.blue
        return [delete, edit]
        
    }
}
