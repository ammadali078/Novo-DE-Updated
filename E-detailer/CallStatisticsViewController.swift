//
//  CallStatisticsViewController.swift
//  E-detailer
//
//  Created by Macbook Air on 07/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import DatePickerDialog

class CallStatisticsViewController: UIViewController {
    
    @IBOutlet weak var clinicActivityCountLabel: UILabel!
    @IBOutlet weak var clinicActivityPatientCount: UILabel!
    @IBOutlet weak var homeActivityCallCountLabel: UILabel!
    @IBOutlet weak var totalVisitCountLabel: UILabel!
    @IBOutlet weak var newPatientCountLabel: UILabel!
    @IBOutlet weak var recsheduleAndCancelCount: UILabel!
    @IBOutlet weak var clinicTotalCallView: UIView!
    @IBOutlet weak var clinicTotalPatientView: UIView!
    @IBOutlet weak var totalVisitView: UIView!
    @IBOutlet weak var homeTotalCallView: UIView!
    @IBOutlet weak var newPatientView: UIView!
    @IBOutlet weak var recsheduleView: UIView!
    @IBOutlet weak var dateLabelView: UILabel!
    @IBOutlet weak var cancelCountLabel: UILabel!
    
    @IBOutlet weak var empIdLabelView: UILabel!
    
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var selectedTab: String = "0"
    
    var callCount: CountResult?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.empIdLabelView.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        
        clinicTotalCallView.layer.cornerRadius = 10
        clinicTotalCallView.clipsToBounds = true
        
        clinicTotalPatientView.layer.cornerRadius = 10
        clinicTotalPatientView.clipsToBounds = true
        
        totalVisitView.layer.cornerRadius = 10
        totalVisitView.clipsToBounds = true
        
        homeTotalCallView.layer.cornerRadius = 10
        homeTotalCallView.clipsToBounds = true
        
        newPatientView.layer.cornerRadius = 10
        newPatientView.clipsToBounds = true
        
        recsheduleView.layer.cornerRadius = 10
        recsheduleView.clipsToBounds = true
        
        let date = Date()
        let formatter = DateFormatter()
        let apiformatter = DateFormatter()
        apiformatter.dateFormat = "yyyy-MM-dd"
        
        formatter.dateFormat = "dd-MM-YYYY"
        let result = formatter.string(from: date)
        let apiResult = apiformatter.string(from: date)
        self.dateLabelView.text = result
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.callselectedDate, withJson: apiResult)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateInfo()
        }
        
    }
    
    func updateInfo()  {
        
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        let date = CommonUtils.getJsonFromUserDefaults(forKey: Constants.callselectedDate)
        switch selectedTab {
        case "0":
            if (callCount == nil) {
                callState(apiName: String(format: Constants.getCallCount, userId, date))
            } else if (callCount != nil) {
                
                callState(apiName: String(format: Constants.getCallCount, userId, date))
                
                
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
                    let callCountModel = Mapper<CallCountModel>().map(JSONString: response.value!) //JSON to model
                    
                    if callCountModel != nil {
                        if (callCountModel?.success)! {
                            if (self.selectedTab == "0") {
                                
                                self.callCount = callCountModel?.result
                                self.clinicActivityCountLabel.text = "\(self.callCount?.clinicalActivityCallCount ?? 0)"
                                self.clinicActivityPatientCount.text = "\(self.callCount?.clinicalActivityPatientCount ?? 0)"
                                self.homeActivityCallCountLabel.text = "\(self.callCount?.homeActivityCallCount ?? 0)"
                                self.totalVisitCountLabel.text = "\(self.callCount?.homeActivityVisitCount ?? 0)"
                                self.newPatientCountLabel.text = "\(self.callCount?.homeActivityNewPatientCount ?? 0)"
                                self.recsheduleAndCancelCount.text = "\(self.callCount?.rescheduleCount ?? 0)"
                                self.cancelCountLabel.text = "\(self.callCount?.cancelCount ?? 0)"
                            } else {
                                
                            }
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (callCountModel?.error!)!)
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                    
                })
            })
    }
    
    
    
    @IBAction func onDateClick(_ sender: Any) {
        
        DatePickerDialog().show("Plan Visit", doneButtonTitle: "Search",cancelButtonTitle: "Cancel", datePickerMode: .date) { date in
            if let dt = date {
                let formatter = DateFormatter()
                let apiFormatter = DateFormatter()
                apiFormatter.dateFormat = "yyyy-MM-dd"
                formatter.dateFormat = "dd-MM-YYYY"
                let planPasteDate = formatter.string(from: dt)
                let apiPlanPasteDate = apiFormatter.string(from: dt)
                self.dateLabelView.text = planPasteDate
                CommonUtils.saveJsonToUserDefaults(forKey: Constants.callselectedDate, withJson: apiPlanPasteDate)
                self.updateInfo()
                
                
            }
        }
    }
    
    @IBAction func clinicCallBtn(_ sender: Any) {
        
        if self.callCount?.clinicalActivityCallCount == 0 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "NOVO", withMessage: "No clinic education available to show")
            
        }else {
            
            self.performSegue(withIdentifier: "SendToClicnicCallDetail", sender: self)
            
        }
        
        
    }
    @IBAction func patientActivityDetailBtn(_ sender: Any) {
        
        if self.callCount?.clinicalActivityPatientCount == 0 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "NOVO", withMessage: "No patient available to show")
            
        }else {
            
            self.performSegue(withIdentifier: "SendToPatientActivityDetail", sender: self)
            
        }
        
        
    }
    @IBAction func homeCallActivityBtn(_ sender: Any) {
        
        if self.callCount?.homeActivityCallCount == 0 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "NOVO", withMessage: "No home education available to show")
            
        }else {
            
            self.performSegue(withIdentifier: "SendToHomeCallDetail", sender: self)
            
        }
        
        
    }
    
    @IBAction func homeVisitActClicked(_ sender: Any) {
        
        
        if self.callCount?.homeActivityVisitCount == 0 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "NOVO", withMessage: "No visit available to show")
            
        }else {
            
            self.performSegue(withIdentifier: "sendToHomeVisitActController", sender: self)
            
        }
    }
    
    @IBAction func homeActivityPatientBtn(_ sender: Any) {
        
        //        SendToHomeActivityPatient
        
        if self.callCount?.homeActivityNewPatientCount == 0 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "NOVO", withMessage: "No new patient available to show")
            
        }else {
            
            self.performSegue(withIdentifier: "SendToHomeActivityPatient", sender: self)
            
        }
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
