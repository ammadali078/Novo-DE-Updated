//
//  PatientDetailCollectionView.swift
//  E-detailer
//
//  Created by Macbook Air on 24/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import RLBAlertsPickers
import ActionSheetPicker_3_0
import DatePickerDialog

class PatientDetailViewController: UIViewController {
 
    @IBOutlet weak var patientDetailLayoutView: UIView!
    @IBOutlet weak var patientListCollectionView: UICollectionView!
    
//    var plannedPatientDataSource: PlannedPatientListCell!
    var patientDetailDataSource: PatientDetailListCell!
    var selectedPlan: Patients?
    var allPatients: [PatientDetail]?
    var selectedTab: String = "0"
    var indicator: UIActivityIndicatorView!
    var plannedPatients: [PatientDetail]?
    var activitiyViewController: ActivityViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patientDetailDataSource = PatientDetailListCell()
        patientListCollectionView.dataSource = patientDetailDataSource
        
        let patientId = self.selectedPlan?.id
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.patientId, withJson: "\(patientId ?? 0)")
        self.updateInfo()
    }
    
    func updateInfo()  {
        
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.patientId)
        switch selectedTab {
        case "0":
            if (allPatients == nil) {
                patientDetail(apiName: String(format: Constants.GetAllPatientPlan, userId))
            } else {
                patientDetailDataSource.setItems(items: allPatients, type: selectedTab)
                patientListCollectionView.reloadData()
            }
            break
        
        default:
            print("no case found")
        }
    }
    
        
        func patientDetail(apiName: String) {
            Alamofire.request(apiName, method: .get, encoding: JSONEncoding.default, headers: nil)
                .responseString(completionHandler: {(response) in
                    // On Response
//                    self.activitiyViewController.dismiss(animated: false, completion: {() in
                        //On Dialog Close
                        if (response.error != nil) {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                            return
                        }
                        let patientDetailModel = Mapper<PatientDetailModel>().map(JSONString: response.value!) //JSON to model
                        
                        if patientDetailModel != nil {
                            if (patientDetailModel?.success)! {
                                if (self.selectedTab == "0") {
                                    self.allPatients = patientDetailModel?.result
                                    self.updateInfo()
                                } else {
                                    self.plannedPatients = patientDetailModel?.result
                                    self.patientDetailDataSource.setItems(items: self.plannedPatients, type: self.selectedTab)
                                    self.patientListCollectionView.reloadData()
    //                                self.updateInfo()
                                }
                            } else {
                                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (patientDetailModel?.error!)!)
                            }
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                        }
                        
//                    })
                })
        }
        
        
    @IBAction func onBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
