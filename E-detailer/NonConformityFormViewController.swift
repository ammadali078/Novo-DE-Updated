//
//  NonConformityFormViewController.swift
//  E-detailer
//
//  Created by macbook on 23/02/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class NonConformityFormViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var empIdNOTextField: UITextField!
    @IBOutlet weak var designationTextField: UITextField!
    @IBOutlet weak var BaseTToextField: UITextField!
    @IBOutlet weak var referenceNoNCTextField: UITextField!
    @IBOutlet weak var categoryNCTextField: UITextField!
    @IBOutlet weak var dateOfNCTextField: UITextField!
    @IBOutlet weak var empNameTextField: UITextField!
    @IBOutlet weak var nonConfTextField: UITextField!
    @IBOutlet weak var dateOfNonConf: UITextField!
    @IBOutlet weak var correctiveActionTextField: UITextField!
    @IBOutlet weak var dateOfCompilition: UITextField!
    @IBOutlet weak var verificationOfCorrective: UITextField!
    @IBOutlet weak var dateOfVerification: UITextField!
    
    let ADEventdatePicker = UIDatePicker()
    let yeardatePicker = UIDatePicker()
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    
    
    override func viewDidLoad() {
        
        dateOfCompilition.delegate = self
        dateOfNonConf.delegate = self
        dateOfVerification.delegate = self
        dateOfNCTextField.delegate = self
        
        self.empNameTextField.isUserInteractionEnabled = false
        
        self.empIdNOTextField.isUserInteractionEnabled = false
        
        self.empIdNOTextField.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        
        self.empNameTextField.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.Employe_Name)
        
        self.showDatePicker()
        self.showYearPicker()
        self.StartDatePicker()
        self.EndDatePicker()
        
        activitiyViewController = ActivityViewController(message: "Loading...")
   
    }
    
    
    func showDatePicker(){
        //Formate Date
        ADEventdatePicker.datePickerMode = .date
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dateOfNCTextField.inputAccessoryView = toolbar
        dateOfNCTextField.inputView = ADEventdatePicker
    }
    
    @objc func donedatePicker(){
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = "yyyy-MM-dd"
        
        let strDate = Formatter.string(from: ADEventdatePicker.date)
        dateOfNCTextField.text = strDate
        
        self.view.endEditing(true)
        
    }
    
    func showYearPicker(){
        //Formate Date
        yeardatePicker.datePickerMode = .date
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneYearPicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dateOfNonConf.inputAccessoryView = toolbar
        dateOfNonConf.inputView = yeardatePicker
    }
    
    @objc func doneYearPicker(){
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = "yyyy-MM-dd"
        
        let strDate = Formatter.string(from: yeardatePicker.date)
        dateOfNonConf.text = strDate
        
        self.view.endEditing(true)
    }
    
    func StartDatePicker(){
        //Formate Date
        startDatePicker.datePickerMode = .date
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneStartPicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dateOfCompilition.inputAccessoryView = toolbar
        dateOfCompilition.inputView = startDatePicker
    }
    
    @objc func doneStartPicker(){
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = "yyyy-MM-dd"
        
        let strDate = Formatter.string(from: startDatePicker.date)
        dateOfCompilition.text = strDate
        
        self.view.endEditing(true)
    }
    
    func EndDatePicker(){
        //Formate Date
        endDatePicker.datePickerMode = .date
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneEndPicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dateOfVerification.inputAccessoryView = toolbar
        dateOfVerification.inputView = endDatePicker
    }
    
    @objc func doneEndPicker(){
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = "yyyy-MM-dd"
        
        let strDate = Formatter.string(from: endDatePicker.date)
        dateOfVerification.text = strDate
        
        self.view.endEditing(true)
    }
    
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
   
    @IBAction func onBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveClicked(_ sender: Any) {
        
        let empId = empIdNOTextField.text
        let empName = empNameTextField.text
        let empdesignation = designationTextField.text
        let BaseTown = BaseTToextField.text
        let referenceNo = referenceNoNCTextField.text
        let categoryNC = categoryNCTextField.text
        let dateOfCompilition = dateOfCompilition.text
        let dateOfNonConf = dateOfNonConf.text
        let dateOfVerfication = dateOfVerification.text
        let nonConf = nonConfTextField.text
        let correctiveAction = correctiveActionTextField.text
        let verificationOfCorrective = verificationOfCorrective.text
        let DateOfNCTextField = dateOfNCTextField.text




        if empdesignation == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if BaseTown == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if referenceNo == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }

        if categoryNC == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if dateOfCompilition == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if dateOfNonConf == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if dateOfVerfication == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if nonConf == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if correctiveAction == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if verificationOfCorrective == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
       


        activitiyViewController.show(existingUiViewController: self)
        var params = Dictionary<String, String>()

        params["EmployeeExternalId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);
        params["ReferenceNo"] = referenceNo;
        params["Category"] = categoryNC;
        params["Description"] = nonConf;
        params["DateOfOccurrence"] = dateOfNonConf;
        params["DateOfCompletion"] = dateOfCompilition;
        params["CorrectiveActions"] = correctiveAction;
        params["Verification"] = verificationOfCorrective;
        params["VerificationDate"] = dateOfVerfication;
        params["Reported"] = "Reported";
        params["ReportedDate"] = DateOfNCTextField;

        Alamofire.request(Constants.EDUAdverseEventApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: true, completion: {() in

                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please check your internet connection")
                        return
                    }

                    let eDUAdverseEventModel = Mapper<EDUAdverseEventModel>().map(JSONString: response.value!) //JSON to model

                    if eDUAdverseEventModel != nil {

                        if eDUAdverseEventModel?.result == 1 {

                            CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Form successfully submitted", onOkClicked: {()

                                self.performSegue(withIdentifier: "MenuController", sender: self)
                            })

                        }else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Invalid")
                        }

                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                })
            })
        
        
        
       
    }
    
}



