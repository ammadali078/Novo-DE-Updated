//
//  CommonUtils.swift
//  E-detailer
//
//  Created by Ammad on 8/3/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration


class CommonUtils {

    static func showMsgDialog(showingPopupOn controller: UIViewController, withTitle title:String, withMessage msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
            
        }))
        
        controller.present(alert, animated: true, completion: nil)
    }
    static func showMsgDialogWithOk(showingPopupOn controller: UIViewController, withTitle title:String, withMessage msg: String, onOkClicked: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
            onOkClicked()
        }))
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func stringDate(dateString: String) -> Date{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let date = dateFormatter.date(from: dateString)
            return date!
        }
    
    static func showMsgBoxWithButtons(title: String, message: String, controller: UIViewController, onYesClicked: @escaping () -> Void){
        
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
            onYesClicked()
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
           // onYesClicked()
        }))
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func showQuesBoxWithButtons(title: String, message: String, controller: UIViewController, onYesClicked: @escaping () -> Void , onNoClicked: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
            onYesClicked()
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
           onNoClicked()
        }))
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func showQuesCameraButtons(title: String, message: String, controller: UIViewController, onYesClicked: @escaping () -> Void , onNoClicked: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
            onYesClicked()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.cancel, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
           onNoClicked()
        }))
        controller.present(alert, animated: true, completion: nil)
    }
    static func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15

        controller.present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    static func showCallBoxWithButtons(title: String, message: String, controller: UIViewController, onYesClicked: @escaping () -> Void){
        
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Joint Call", style: UIAlertAction.Style.default, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
            onYesClicked()
        }))
        
        alert.addAction(UIAlertAction(title: "Single Call", style: UIAlertAction.Style.cancel, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
            //onYesClicked()
        }))
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func showCallBoxWithYesButtons(title: String, message: String, controller: UIViewController, onYesClicked: @escaping () -> Void){
        
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
            onYesClicked()
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
            //onYesClicked()
        }))
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func getCurrentTime() -> Double {
        return Date.init().timeIntervalSince1970
    }
    
    static func saveJsonToUserDefaults(forKey key: String, withJson json: String) {
        UserDefaults.standard.set(json, forKey: key);
    }
    
    static func getJsonFromUserDefaults(forKey key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? "";
    }
    
    static func log(value: String){
        print(value)
    }
    
    static func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    static func showCallBoxWithButtons(title: String, message: String, controller: UIViewController, onYesClicked: @escaping () -> Void , onNoClicked: @escaping () -> Void , onCancelClicked: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Within 24 Hours", style: UIAlertAction.Style.default, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
            onYesClicked()
        }))
        
        alert.addAction(UIAlertAction(title: "After 24 Hours", style: UIAlertAction.Style.default, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
            onNoClicked()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {_ in
            alert.dismiss(animated: false, completion: nil)
            onCancelClicked()
        }))
        
        controller.present(alert, animated: true, completion: nil)
       
    }
    
    static func getDateFromTimeStamp(timeStamp : Double) -> String {
        let date = NSDate(timeIntervalSince1970: timeStamp)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd-MM-YYYY, hh:mm a"
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}
