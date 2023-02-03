//
//  ContactViewController.swift
//  E-detailer
//
//  Created by Ammad on 12/31/04.
//  Copyright © 2004 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class ContactViewController: UIViewController {
    
    @IBOutlet weak var contactListLayout: UIView!
    @IBOutlet weak var contactListCollectionView: UICollectionView!
    
    var attendence : [AttendencePostModel] = []
    var contactListDataSource: ContactListCell!
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    
    @IBAction func BTNSinc(_ sender: Any) {
        callApi()
        let json = CommonUtils.getJsonFromUserDefaults(forKey: Constants.CallToUploadKey)
        
        attendence = Mapper<AttendencePostModel>().mapArray(JSONString: json)!
        
        var req = AttendencePostModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        let a = req?.toJSON()
        Alamofire.request(Constants.AttendencePostApi, method: .post, parameters: a, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                //On Dialog Close
                if (response.error != nil) {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                    return
                }
                
                if (response.value == "1") {
                    
                    CommonUtils.saveJsonToUserDefaults(forKey: Constants.LastTimeOfUpload, withJson: String(CommonUtils.getCurrentTime()))
                    
                    
                    CommonUtils.saveJsonToUserDefaults(forKey: Constants.CallToUploadKey, withJson: "[]")
                    self.dismiss(animated: false, completion: nil)
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: response.value!)
                }
            })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactListDataSource = ContactListCell()
        contactListCollectionView.dataSource = contactListDataSource
        activitiyViewController = ActivityViewController(message: "Loading...")
        contactListDataSource.onClick = {(selectedModel: ContactResult) in
            
            CommonUtils.getJsonFromUserDefaults(forKey:Constants.MorningStartTime)
            CommonUtils.getJsonFromUserDefaults(forKey:Constants.MaxMorningTime)
            CommonUtils.getJsonFromUserDefaults(forKey:Constants.EveningTimeStart)
            CommonUtils.getJsonFromUserDefaults(forKey: Constants.MaxEveningTime)
            
            CommonUtils.showMsgBoxWithButtons(title: "Attendence", message: "Are you sure, you want to mark attendance at " + selectedModel.dESCR! + " ?", controller: self, onYesClicked:{()
                
            })
        }
        callApi()
    }
    
    func callApi() {
        
        activitiyViewController.show(existingUiViewController: self)
        
        let callApi = CallApi()		
        callApi.getAllContacts(url: Constants.ContactApi, completionHandler: {(contactModel: ContactModel?, error: String?) in 
            
            if (error != nil) {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: error!)
                return
            }
            // On Response
            self.activitiyViewController.dismiss(animated: false, completion: nil)
            if contactModel != nil {
                if (contactModel?.success)! {
                    
                    self.contactListDataSource.setItems(items: contactModel?.result)
                    self.contactListCollectionView.reloadData()
                    
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (contactModel?.error!)!)
                }
            } else {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
            }
        })
        
    }
    
    @IBAction func onBackClick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
