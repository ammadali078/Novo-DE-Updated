//
//  DiscussionPatientViewController.swift
//  E-detailer
//
//  Created by Macbook Air on 09/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class DiscussionPatientViewController: UIViewController, UITextViewDelegate {
    var lblPlaceHolder : UILabel!

    @IBOutlet weak var visitObjectiveLabelview: UITextView!
    @IBOutlet weak var patientDiscussionTextField: UITextView!
    @IBOutlet weak var btnViewOutlet: UIView!
    
    var activitiyViewController: ActivityViewController!
    var selectedPatient: PlannedPatients? = nil
    var startTime: String?
    var maxLength : Int?
    
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceHolder.isHidden = !textView.text.isEmpty
    }
    
    override func viewDidLoad() {
        patientDiscussionTextField.delegate = self
        lblPlaceHolder = UILabel()
        lblPlaceHolder.text = "Enter your conversation with patient"
        lblPlaceHolder.font = UIFont.systemFont(ofSize: patientDiscussionTextField.font!.pointSize)
        lblPlaceHolder.sizeToFit()
        patientDiscussionTextField.addSubview(lblPlaceHolder)
        lblPlaceHolder.frame.origin = CGPoint(x: 5, y: (patientDiscussionTextField.font?.pointSize)! / 2)
        lblPlaceHolder.textColor = UIColor.lightGray
        lblPlaceHolder.isHidden = !patientDiscussionTextField.text.isEmpty
        
        self.patientDiscussionTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.patientDiscussionTextField.layer.borderWidth = 1.0
        self.patientDiscussionTextField.layer.cornerRadius = 8
        
        activitiyViewController = ActivityViewController(message: "Loading...")

        startTime = String(CommonUtils.getCurrentTime())

        btnViewOutlet.layer.cornerRadius = 10
        btnViewOutlet.clipsToBounds = true
        
        let vObjective = CommonUtils.getJsonFromUserDefaults(forKey: Constants.Objective)
        
        if vObjective == "" {
            visitObjectiveLabelview.text = "No Objective"
        } else {
            
            visitObjectiveLabelview.text = vObjective
            
        }
    }
    
    func textView(_ tsextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (patientDiscussionTextField.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 700    // 10 Limit Value
    }
    
    @IBAction func onSaveBtn(_ sender: Any) {
        activitiyViewController.show(existingUiViewController: self)
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)

        if self.patientDiscussionTextField.text == "" {
            self.activitiyViewController.dismiss(animated: true, completion: {() in
                
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter Discussion")
            })
            return
        }
        var params = Dictionary<String, Any>()
        params["PatientId"] = self.selectedPatient?.patientId
        params["Comments"] = self.patientDiscussionTextField.text
        params["Lat"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        params["Lng"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        
//        "24.882927332207792"
//        "67.08349033068399"
    //CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        params["EmployeeUserId"] = userId
        params["StartTime"] = Double(startTime ?? "")
        params["EndTime"] = CommonUtils.getCurrentTime()
        params["ActivityObjective"] = self.visitObjectiveLabelview.text
        params["PatinetConsent"] = "true"
        params["ActivityType"] = "Call"
        params["PatinetConsentAttachmentUrl"] = ""
        params["PrescriptionAvailable"] = ""
        params["PrescriptionAttachmentUrl"] = ""
        params["InformationAboutProductGiven"] = ""
        params["DeviceDemonstrationGiven"] = ""
        params["BloodGlucose"] = ""
        params["BloodPressure"] = ""
        params["Weight"] = ""
        params["FeedbackStars"] = ""
        params["HomeActivityConcomitantProduct"] = []
        params["HomeActivityCurrentProduct"] = []
        params["HomeActivityPreviousProduct"] = []
        params["HomeActivityPreviousOtherProduct"] = []
        params["HomeActivityDiscussionTopic"] = []
        
        var HomeActivity: [Dictionary<String, Any>] = []
        HomeActivity.append(params)
        Alamofire.request(Constants.SyncHomeActivity, method: .post, parameters: ["HomeActivity": HomeActivity], encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: true, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    if (response.value == "1") {
                        
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.LastTimeOfUpload, withJson: String(CommonUtils.getCurrentTime()))
                        
                        
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.CallToUploadKey, withJson: "[]")
                       
                        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Call Submit Successfully", onOkClicked: {()in
                            self.dismiss(animated: false, completion: {
                                self.dismiss(animated: true, completion: nil)
                            })
                        })
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: response.value!)
                    }
                })
            })
    }
    
    @IBAction func onBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
