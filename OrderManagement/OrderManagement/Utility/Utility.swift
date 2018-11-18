//
//  Utility.swift
//  OrderManagement
//
//  Created by VaraPrasadReddy on 11/17/18.
//  Copyright © 2018 VaraPrasadReddy. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    /**
     This Function is used for Email Validation
     - paramete: Apped the User Email to this paramete
     */
    func validateEmail(enteredEmail:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: enteredEmail)
        return result
    }
    /**
     Download image from remote URL
     - parameter url: append the URL string
     */
    func downloadImage(_ url: String) -> UIImage? {
        let aUrl = URL(string: url)
        guard let data = try? Data(contentsOf: aUrl!),
            let image = UIImage(data: data) else {
                return nil
        }
        return image
    }
    
    /**
     This method is used for displayed the Alert Popup
     */
    func customAlertMessage(_ title: String, message: String, alertButtonTitles: [String], alertButtonStyles: [UIAlertAction.Style], vc: UIViewController, completion: @escaping (Int)->Void) -> Void
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        for title in alertButtonTitles {
            let actionObj = UIAlertAction(title: title,
                                          style: alertButtonStyles[alertButtonTitles.index(of: title)!], handler: { action in
                                            completion(alertButtonTitles.index(of: action.title!)!)
            })
            alert.addAction(actionObj)
        }
        //vc will be the view controller on which you will present your alert as you cannot use self because this method is static.
        vc.present(alert, animated: true, completion: nil)
    }
    ///Convert UTC LocalTime to String
    func convertUTCLocalTimeString(dateString:String) -> String {
        //Date String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let anAbbreviation = NSTimeZone(abbreviation: "UTC") {
            dateFormatter.timeZone = anAbbreviation as TimeZone
        }
        let date: Date? = dateFormatter.date(from: dateString)
        // change to a readable time format and change to local time zone
        dateFormatter.dateFormat = "MMM d, yyyy hh:mm a"
        //dateFormatter.timeZone = NSTimeZone.system
        let timestamp = dateFormatter.string(from: date!)
        return timestamp
    }
    ///getCurrentDateTime
    func getCurrentDateTime() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        let convertedDate: String = dateFormatter.string(from: currentDate)
        return convertedDate
    }
    
    /**
     This method is used for Changed the Date String to our String Date formatter
     */
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return nil
    }
    
    func loadJson(filename fileName: String) -> [Any] {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    return dictionary["orders"] as! [Any]
                }
            } catch {
                print("Error!! Unable to parse  \(fileName).json \(error)")
            }
        }
        return []
    }
}
