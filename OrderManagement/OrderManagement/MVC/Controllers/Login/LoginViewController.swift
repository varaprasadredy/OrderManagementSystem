//
//  LoginViewController.swift
//  OrderManagement
//
//  Created by VaraPrasadReddy on 11/16/18.
//  Copyright © 2018 VaraPrasadReddy. All rights reserved.
//

import UIKit
/**
 This LoginViewController class indicates App Login Screen,Once user login successfully it will navigate to Orders View Controller(Orders Screen)
 ## UI Properties
 - User Name Text Field
 - Password Text Field
 - Login Button
 - Remeber Me Label
 - Switch
 
 ## UI Action or Functionality
 - **User Name Text Field** :- In this field user has to be enter their user name
 - **Password Text Field** :- In this field user has to be enter their user password
 - **Login Button** :- In this action first check the user details correct or not , if user enter correct  details,Present the **Order View Controller**! or Home screen, otherwise displayed the Alert.
 
 ## Written and Used Methods
 1. **setUpCornerRadius()** : Set Corner Radius to TextFields and Login Button
 3. **goToOrdersViewController()** : This method is used for it will present the Home Screen when login success

 */
class LoginViewController: UIViewController {
    ///User Name Text Filed
    @IBOutlet weak var userNameField: RoundedTextField!
    ///Password Name Text Filed
    @IBOutlet weak var passwordField: RoundedTextField!
    ///Login Button
    @IBOutlet weak var logInButton: UIButton!
    ///Switch
    @IBOutlet weak var rememberSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Sign In"
//        self.userNameField.text = "Navtech"
//        self.passwordField.text = "12345"
        self.logInButton.setCornerRadius(5.0)
        print(isLoggedIn())
        //Set Login Status to Switch.
        if !isLoggedIn() {
            rememberSwitch.setOn(false, animated: true)
        }
    }
    
    ///Login Button Action Method
    @IBAction func logInButtonAction(){
        self.view.endEditing(true)
        //Check User Name Text Field
        guard let userName = userNameField.text, !userName.isEmpty, userName=="Navtech" else{
            Utility().customAlertMessage(Constants.Login.loginFailedTitle, message: Constants.Login.emailErrorMsg, alertButtonTitles: ["OK"], alertButtonStyles: [.default], vc: self, completion: { (Int) in
            })
            return
        }
        //Check Password Text Field
        guard let password = passwordField.text, !password.isEmpty, password=="12345" else{
            Utility().customAlertMessage(Constants.Login.loginFailedTitle, message: Constants.Login.passwordErrorMsg, alertButtonTitles: ["OK"], alertButtonStyles: [.default], vc: self, completion: { (Int) in
            })
            return
        }
        print("Login successfull")
        UserDefaults.standard.setIsLoggedIn(value: rememberSwitch.isOn)
        UserDefaults.standard.synchronize()
        //Once login sucessfull navigate to Orders Screen
        goToOrderViewController()
    }
    
    ///Get User LogIn Status
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    ///This method is used for it will present the Home Screen when login success
    fileprivate func goToOrderViewController() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let navController = appDelegate.window?.rootViewController as? UINavigationController
        navController?.setViewControllers([homeViewController], animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//MARK: UITextFieldDelgate Methods
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            passwordField.becomeFirstResponder()
            userNameField.resignFirstResponder()
        }
        if textField == passwordField {
            passwordField.resignFirstResponder()
            logInButtonAction()
        }
        return true
    }
}
