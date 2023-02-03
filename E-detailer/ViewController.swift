//
//  ViewController.swift
//  E-detailer
//
//  Created by Ammad on 8/1/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ViewController: UIViewController {
    @IBOutlet weak var tabButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Api Executed
        
        Alamofire.request(Constants.AttendenceApi, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    let attendenceModel = Mapper<AttendenceModel>().map(JSONString: response.value!) //JSON to model
                    
                    if attendenceModel != nil {
                        
                        if (attendenceModel?.success)! {
                            
                          CommonUtils.saveJsonToUserDefaults(forKey: Constants.MorningStartTime, withJson: (attendenceModel?.result?.morningTimeStart)!)
                            
                           CommonUtils.saveJsonToUserDefaults(forKey: Constants.MaxMorningTime, withJson: (attendenceModel?.result?.maxMorningTime)!)
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.EveningTimeStart, withJson: (attendenceModel?.result?.eveningTimeStart)!)
                            
                             CommonUtils.saveJsonToUserDefaults(forKey: Constants.MaxEveningTime, withJson: (attendenceModel?.result?.maxEveningTime)!)
                            
                        } else {
//                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (attendenceModel?.error!)!)
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
              
            })
        
        tabButton.layer.cornerRadius = 20
        tabButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}

