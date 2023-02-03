//
//  PatientActivityDetailViewController.swift
//  E-detailer
//
//  Created by Macbook Air on 09/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import DatePickerDialog

class PatientActivityDetailViewController: UIViewController {
    
//    @IBOutlet weak var clinicActivityDetailLayout: UIView!
//    @IBOutlet weak var clinicActivityDetailCollectionView: UICollectionView!
    @IBOutlet weak var patientActivityLayOut: UIView!
    @IBOutlet weak var patientActivityDetailCollectionView: UICollectionView!
    
    var patientActivityDetailDataSource: PatientActivityDetailListCell!
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var selectedTab: String = "0"
    
    var callDetail: [PatientActivityResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patientActivityDetailDataSource = PatientActivityDetailListCell()
        patientActivityDetailCollectionView.dataSource = patientActivityDetailDataSource
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        self.updateInfo()
        
    }
    
    func updateInfo()  {
        
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        let date = CommonUtils.getJsonFromUserDefaults(forKey: Constants.callselectedDate)
        switch selectedTab {
        case "0":
            if (callDetail == nil) {
                callState(apiName: String(format: Constants.getPatientactivity, userId, date))
            } else if (callDetail != nil) {
                
                callState(apiName: String(format: Constants.getPatientactivity, userId, date))
                
                
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
                    let patientActivityDetailModel = Mapper<PatientActivityDetailModel>().map(JSONString: response.value!) //JSON to model
                    
                    if patientActivityDetailModel != nil {
                        if (patientActivityDetailModel?.success)! {
                            
                            if patientActivityDetailModel?.result == nil {
                                
                                CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "No Calls Available To Show", onOkClicked: {()
                                    
                                    self.dismiss(animated: true, completion: nil)
                                    
                                })
                                
                            } else {
                                if (self.selectedTab == "0") {
                                    
                                    self.callDetail = patientActivityDetailModel?.result
                                    self.patientActivityDetailDataSource.setItems(items: self.callDetail, type: self.selectedTab)
                                    self.patientActivityDetailCollectionView.reloadData()
                                    
                                } else {
                                    
                                }
                                
                            }
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (patientActivityDetailModel?.error!)!)
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
