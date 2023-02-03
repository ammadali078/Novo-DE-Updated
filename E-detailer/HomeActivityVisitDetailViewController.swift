//
//  HomeActivityVisitDetailViewController.swift
//  E-detailer
//
//  Created by Macbook Air on 09/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//


import Foundation
import Alamofire
import ObjectMapper
import DatePickerDialog

class HomeActivityVisitDetailViewController: UIViewController {
    
    
    @IBOutlet weak var homeVisitActivityLayOut: UIView!
    @IBOutlet weak var homeVisitActivityCollectionView: UICollectionView!
    
    var homeActivityVisitDetailDataSource: HomeActivityVisitDetailListCell!
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var selectedTab: String = "0"
    
    var callDetail: [HomeVisitResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeActivityVisitDetailDataSource = HomeActivityVisitDetailListCell()
        homeVisitActivityCollectionView.dataSource = homeActivityVisitDetailDataSource
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        self.updateInfo()
        
    }
    
    func updateInfo()  {
        
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        let date = CommonUtils.getJsonFromUserDefaults(forKey: Constants.callselectedDate)
        switch selectedTab {
        case "0":
            if (callDetail == nil) {
                callState(apiName: String(format: Constants.getHomeActivityVisit, userId, date))
            } else if (callDetail != nil) {
                
                callState(apiName: String(format: Constants.getHomeActivityVisit, userId, date))
                
                
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
                    let homeActivityVistModel = Mapper<HomeActivityVistModel>().map(JSONString: response.value!) //JSON to model
                    
                    if homeActivityVistModel != nil {
                        if (homeActivityVistModel?.success)! {
                            
                            if homeActivityVistModel?.result == nil {
                                
                                CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "No Calls Available To Show", onOkClicked: {()
                                    
                                    self.dismiss(animated: true, completion: nil)
                                    
                                })
                                
                            } else {
                                if (self.selectedTab == "0") {
                                    
                                    self.callDetail = homeActivityVistModel?.result
                                    self.homeActivityVisitDetailDataSource.setItems(items: self.callDetail, type: self.selectedTab)
                                    self.homeVisitActivityCollectionView.reloadData()
                                    
                                } else {
                                    
                                }
                                
                            }
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (homeActivityVistModel?.error!)!)
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
