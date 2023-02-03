//
//  HomeActivityPatientDetailViewController.swift
//  E-detailer
//
//  Created by Macbook Air on 10/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import DatePickerDialog

class HomeActivityPatientDetailViewController: UIViewController {
    
    @IBOutlet weak var homePatientActivityLayOut: UIView!
    @IBOutlet weak var homePatientActivityCollectionView: UICollectionView!
    
    var homeActivityPatientDetailDataSource: HomeActivityPatientDetailListCell!
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var selectedTab: String = "0"
    
    var callDetail: [HomePatientResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeActivityPatientDetailDataSource = HomeActivityPatientDetailListCell()
        homePatientActivityCollectionView.dataSource = homeActivityPatientDetailDataSource
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        self.updateInfo()
        
    }
    
    func updateInfo()  {
        
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        let date = CommonUtils.getJsonFromUserDefaults(forKey: Constants.callselectedDate)
        switch selectedTab {
        case "0":
            if (callDetail == nil) {
                callState(apiName: String(format: Constants.getHomeActivityPatient, userId, date))
            } else if (callDetail != nil) {
                
                callState(apiName: String(format: Constants.getHomeActivityPatient, userId, date))
                
            }
            break
            
        default:
            print("no case found")
        }
    }
    
    
    func callState(apiName: String) {
        activitiyViewController.show(existingUiViewController: self)
        Alamofire.request(apiName, method: .get, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    let homeActivityPatientModel = Mapper<HomeActivityPatientModel>().map(JSONString: response.value!) //JSON to model
                    
                    if homeActivityPatientModel != nil {
                        if (homeActivityPatientModel?.success)! {
                            
                            if homeActivityPatientModel?.result == nil {
                                
                                CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "No Calls Available To Show", onOkClicked: {()
                                    
                                    self.dismiss(animated: true, completion: nil)
                                    
                                })
                                
                            } else {
                                if (self.selectedTab == "0") {
                                    
                                    self.callDetail = homeActivityPatientModel?.result
                                    self.homeActivityPatientDetailDataSource.setItems(items: self.callDetail, type: self.selectedTab)
                                    self.homePatientActivityCollectionView.reloadData()
                                    
                                } else {
                                    
                                }
                                
                            }
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (homeActivityPatientModel?.error!)!)
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                    
                })
            })
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

