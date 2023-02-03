//
//  AEReportingViewController.swift
//  E-detailer
//
//  Created by macbook on 23/02/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//
//Not reported/not requested from reporter
import Foundation
import UIKit
import Alamofire
import ObjectMapper
import BEMCheckBox

class AEReportingViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate,BEMCheckBoxDelegate {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var DBrowIdTextfield: UITextField!
    @IBOutlet weak var programTitleTextField: UITextField!
    @IBOutlet weak var detailAdverseEventField: UITextField!
    @IBOutlet weak var dateAdverseEventField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var yearOfBirthTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var relaentTextField: UITextField!
    @IBOutlet weak var NameProductTextField: UITextField!
    @IBOutlet weak var productTakinTextField: UITextField!
    @IBOutlet weak var DosageTextField: UITextField!
    @IBOutlet weak var batchNoTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var StopDateTextField: UITextField!
    @IBOutlet weak var reName: UITextField!
    @IBOutlet weak var addressName: UITextField!
    @IBOutlet weak var reportNameTextField: UITextField!
    @IBOutlet weak var addressReportTextField: UITextField!
    @IBOutlet weak var contactDetailTextField: UITextField!
    @IBOutlet weak var empNameTextField: UITextField!
    @IBOutlet weak var dateOfReciveTextField: UITextField!
    @IBOutlet weak var severityOtherCheckBox: BEMCheckBox!
    @IBOutlet weak var severityOtherTextField: UITextField!
    @IBOutlet weak var severityMidCheckBox: BEMCheckBox!
    @IBOutlet weak var admittedHospitalCheckBox: BEMCheckBox!
    @IBOutlet weak var outComeRecoverdCheckBox: BEMCheckBox!
    @IBOutlet weak var recoveringOutComeCheckBox: BEMCheckBox!
    @IBOutlet weak var notRecoveredOutComeCheckBox: BEMCheckBox!
    @IBOutlet weak var diedOutComeCheckBox: BEMCheckBox!
    @IBOutlet weak var unKnownOutcomeCheckBox: BEMCheckBox!
    @IBOutlet weak var reciveTretmentYesTextField: UITextField!
    @IBOutlet weak var reciveTretmentYesLabel: UILabel!
    @IBOutlet weak var yesReciveTretmentCheckBox: BEMCheckBox!
    @IBOutlet weak var noReciveTretmentCheckBox: BEMCheckBox!
    @IBOutlet weak var maleCheckBox: BEMCheckBox!
    @IBOutlet weak var femaleCheckBox: BEMCheckBox!
    @IBOutlet weak var infantCheckBox: BEMCheckBox!
    @IBOutlet weak var childCheckBox: BEMCheckBox!
    @IBOutlet weak var adolescentCheckBox: BEMCheckBox!
    @IBOutlet weak var adultCheckBox: BEMCheckBox!
    @IBOutlet weak var elderlyCheckBox: BEMCheckBox!
    @IBOutlet weak var productStoppedYesCheckBox: BEMCheckBox!
    @IBOutlet weak var productStoppedNoCheckBox: BEMCheckBox!
    @IBOutlet weak var reporterYesProductCheckBox: BEMCheckBox!
    @IBOutlet weak var reporterNoProductCheckBox: BEMCheckBox!
    @IBOutlet weak var reporterNotRequestProductCheckBox: BEMCheckBox!
    @IBOutlet weak var reporterUnknowProductCheckBox: BEMCheckBox!
    @IBOutlet weak var reporterYesOtherProductLabel: UILabel!
    @IBOutlet weak var reporterYesOtherProductTextField: UITextField!
    @IBOutlet weak var reporterYesOtherProductCheckBox: BEMCheckBox!
    @IBOutlet weak var reporterNoOtherProductCheckBox: BEMCheckBox!
    @IBOutlet weak var reporterUnknownOtherProductCheckBox: BEMCheckBox!
    @IBOutlet weak var reporterNotRequestedOtherProductCheckBox: BEMCheckBox!
    @IBOutlet weak var reportDetailYesCheckBox: BEMCheckBox!
    @IBOutlet weak var reportDetailNoCheckBox: BEMCheckBox!
    @IBOutlet weak var reporterConsentYesCheckBox: BEMCheckBox!
    @IBOutlet weak var reporterConsentNoCheckBox: BEMCheckBox!
    @IBOutlet weak var preferedContactPhoneCheckBox: BEMCheckBox!
    @IBOutlet weak var preferedContactEmailCheckBox: BEMCheckBox!
    @IBOutlet weak var typeOfReportOtherTextField: UITextField!
    @IBOutlet weak var typeOfReportDoctorCheckBox: BEMCheckBox!
    @IBOutlet weak var typeOfReportNurseCheckBox: BEMCheckBox!
    @IBOutlet weak var typeOfReportPharmaCheckBox: BEMCheckBox!
    @IBOutlet weak var typeOfReportPatientCheckBox: BEMCheckBox!
    @IBOutlet weak var typeOfReportOtherCheckBox: BEMCheckBox!
    
    let ADEventdatePicker = UIDatePicker()
    let yeardatePicker = UIDatePicker()
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var lblPlaceHolder : UILabel!
    var severtiText: String?
    var OutComeText: String?
    var TretmentText: String?
    var sexseText: String?
    var ageText: String?
    var productStoppedText: String?
    var productContributed: String?
    var Otherproduct: String?
    var permissionDoctor: String?
    var reporterConsent: String?
    var phoneText: String?
    var reportType: String?
    var maxLength : Int?
    
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceHolder.isHidden = !textView.text.isEmpty
    }
    
    override func viewDidLoad() {
        descriptionTextView.delegate = self
        productStoppedYesCheckBox.delegate = self
        productStoppedNoCheckBox.delegate = self
        typeOfReportOtherCheckBox.delegate = self
        typeOfReportNurseCheckBox.delegate = self
        typeOfReportPharmaCheckBox.delegate = self
        typeOfReportPatientCheckBox.delegate = self
        typeOfReportDoctorCheckBox.delegate = self
        typeOfReportOtherTextField.isHidden = true
        preferedContactPhoneCheckBox.delegate = self
        preferedContactEmailCheckBox.delegate = self
        reporterConsentYesCheckBox.delegate = self
        reporterConsentNoCheckBox.delegate = self
        reportDetailYesCheckBox.delegate = self
        reportDetailNoCheckBox.delegate = self
        reporterNotRequestedOtherProductCheckBox.delegate = self
        reporterUnknownOtherProductCheckBox.delegate = self
        reporterNoOtherProductCheckBox.delegate = self
        reporterYesOtherProductCheckBox.delegate = self
        reporterYesOtherProductLabel.isHidden = true
        reporterYesOtherProductTextField.isHidden = true
        reporterYesProductCheckBox.delegate = self
        reporterNoProductCheckBox.delegate = self
        reporterUnknowProductCheckBox.delegate = self
        reporterNotRequestProductCheckBox.delegate = self
        elderlyCheckBox.delegate = self
        adultCheckBox.delegate = self
        adolescentCheckBox.delegate = self
        childCheckBox.delegate = self
        infantCheckBox.delegate = self
        maleCheckBox.delegate = self
        femaleCheckBox.delegate = self
        yesReciveTretmentCheckBox.delegate = self
        noReciveTretmentCheckBox.delegate = self
        reciveTretmentYesLabel.isHidden = true
        reciveTretmentYesTextField.isHidden = true
        unKnownOutcomeCheckBox.delegate = self
        diedOutComeCheckBox.delegate = self
        notRecoveredOutComeCheckBox.delegate = self
        recoveringOutComeCheckBox.delegate = self
        outComeRecoverdCheckBox.delegate = self
        self.severityOtherTextField.isHidden = true
        severityOtherCheckBox.delegate = self
        severityMidCheckBox.delegate = self
        admittedHospitalCheckBox.delegate = self
        dateAdverseEventField.delegate = self
        dateOfReciveTextField.delegate = self
        descriptionTextView.delegate = self
        yearOfBirthTextField.delegate = self
        startDateTextField.delegate = self
        StopDateTextField.delegate = self
        lblPlaceHolder = UILabel()
        lblPlaceHolder.text = "Enter your Descriptions"
        lblPlaceHolder.font = UIFont.systemFont(ofSize: descriptionTextView.font!.pointSize)
        lblPlaceHolder.sizeToFit()
        descriptionTextView.addSubview(lblPlaceHolder)
        lblPlaceHolder.frame.origin = CGPoint(x: 5, y: (descriptionTextView.font?.pointSize)! / 2)
        lblPlaceHolder.textColor = UIColor.lightGray
        lblPlaceHolder.isHidden = !descriptionTextView.text.isEmpty
        self.showDatePicker()
        self.showYearPicker()
        self.StartDatePicker()
        self.EndDatePicker()
        self.showRecivePicker()
        self.descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.descriptionTextView.layer.borderWidth = 1.0
        self.descriptionTextView.layer.cornerRadius = 8
        self.empNameTextField.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.Employe_Name)
        self.empNameTextField.isUserInteractionEnabled = false
        
        activitiyViewController = ActivityViewController(message: "Loading...")
    }
    
    
    
    func textView(_ tsextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (descriptionTextView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 250    // 10 Limit Value
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        if checkBox == severityOtherCheckBox{
            if checkBox.on == true{
                self.severityOtherTextField.isHidden = false
                self.severityMidCheckBox.on = false
                self.admittedHospitalCheckBox.on = false
                self.severtiText = severityOtherTextField.text
            }else{
                self.severityOtherTextField.isHidden = true
            }
            
        }else if checkBox == severityMidCheckBox {
            if checkBox.on == true{
                severityOtherCheckBox.on = false
                admittedHospitalCheckBox.on = false
                self.severityOtherTextField.isHidden = true
                self.severtiText = "Mild-did not affect everyday activities"
            }
            
        }else if checkBox == admittedHospitalCheckBox {
            if checkBox.on == true{
                severityOtherCheckBox.on = false
                severityMidCheckBox.on = false
                self.severityOtherTextField.isHidden = true
                self.severtiText = "Was admitted to hospital"
            }
            
        }else if checkBox == unKnownOutcomeCheckBox {
            if checkBox.on == true{
                diedOutComeCheckBox.on = false
                notRecoveredOutComeCheckBox.on = false
                recoveringOutComeCheckBox.on = false
                outComeRecoverdCheckBox.on = false
                OutComeText = "Unknown"
            }
            
        }else if checkBox == diedOutComeCheckBox {
            if checkBox.on == true{
                unKnownOutcomeCheckBox.on = false
                notRecoveredOutComeCheckBox.on = false
                recoveringOutComeCheckBox.on = false
                outComeRecoverdCheckBox.on = false
                OutComeText = "Died"
            }
            
        }else if checkBox == notRecoveredOutComeCheckBox {
            if checkBox.on == true{
                unKnownOutcomeCheckBox.on = false
                diedOutComeCheckBox.on = false
                recoveringOutComeCheckBox.on = false
                outComeRecoverdCheckBox.on = false
                OutComeText = "Not recovered (no change in symptoms)"
            }
            
        }
        else if checkBox == recoveringOutComeCheckBox {
            if checkBox.on == true{
                unKnownOutcomeCheckBox.on = false
                diedOutComeCheckBox.on = false
                notRecoveredOutComeCheckBox.on = false
                outComeRecoverdCheckBox.on = false
                OutComeText = "Recovering (getting better, but still symptoms)"
            }
            
        }else if checkBox == outComeRecoverdCheckBox {
            if checkBox.on == true{
                unKnownOutcomeCheckBox.on = false
                diedOutComeCheckBox.on = false
                notRecoveredOutComeCheckBox.on = false
                recoveringOutComeCheckBox.on = false
                OutComeText = "Recovered (no more symptoms)"
            }
            
        }else if checkBox == yesReciveTretmentCheckBox {
            if checkBox.on == true{
                noReciveTretmentCheckBox.on = false
                reciveTretmentYesTextField.isHidden = false
                reciveTretmentYesLabel.isHidden = false
                TretmentText = "Yes"
                TretmentText = reciveTretmentYesTextField.text
            }else {
                reciveTretmentYesTextField.isHidden = true
                reciveTretmentYesLabel.isHidden = true
                
                
            }
            
        }else if checkBox == noReciveTretmentCheckBox {
            if checkBox.on == true{
                yesReciveTretmentCheckBox.on = false
                reciveTretmentYesTextField.isHidden = true
                reciveTretmentYesLabel.isHidden = true
                TretmentText = "No"
            }
            
        }else if checkBox == maleCheckBox {
            if checkBox.on == true{
                femaleCheckBox.on = false
                sexseText = "Male"
            }
            
        }else if checkBox == femaleCheckBox {
            if checkBox.on == true{
                maleCheckBox.on = false
                sexseText = "Female"
            }
        }else if checkBox == elderlyCheckBox {
            if checkBox.on == true{
                adultCheckBox.on = false
                adolescentCheckBox.on = false
                childCheckBox.on = false
                infantCheckBox.on = false
                ageText = "elderly"
            }
        }else if checkBox == adultCheckBox {
            if checkBox.on == true{
                elderlyCheckBox.on = false
                adolescentCheckBox.on = false
                childCheckBox.on = false
                infantCheckBox.on = false
                ageText = "adultCheckBox"
            }
        }else if checkBox == adolescentCheckBox {
            if checkBox.on == true{
                elderlyCheckBox.on = false
                adultCheckBox.on = false
                childCheckBox.on = false
                infantCheckBox.on = false
                ageText = "Adolescent"
            }
        }else if checkBox == childCheckBox {
            if checkBox.on == true{
                elderlyCheckBox.on = false
                adultCheckBox.on = false
                adolescentCheckBox.on = false
                infantCheckBox.on = false
                ageText = "Child"
            }
        }else if checkBox == infantCheckBox {
            if checkBox.on == true{
                elderlyCheckBox.on = false
                adultCheckBox.on = false
                adolescentCheckBox.on = false
                childCheckBox.on = false
                ageText = "infant"
            }
        }else if checkBox == productStoppedYesCheckBox {
            if checkBox.on == true{
                productStoppedNoCheckBox.on = false
                productStoppedText = "Yes"
            }
        }else if checkBox == productStoppedNoCheckBox {
            if checkBox.on == true{
                productStoppedYesCheckBox.on = false
                productStoppedText = "No"
            }
        }else if checkBox == reporterYesProductCheckBox {
            if checkBox.on == true{
                reporterNoProductCheckBox.on = false
                reporterUnknowProductCheckBox.on = false
                reporterNotRequestProductCheckBox.on = false
                productContributed = "Yes (possible)"
            }
        }else if checkBox == reporterNoProductCheckBox {
            if checkBox.on == true{
                reporterYesProductCheckBox.on = false
                reporterUnknowProductCheckBox.on = false
                reporterNotRequestProductCheckBox.on = false
                productContributed = "No (Unlikely)"
            }
        }else if checkBox == reporterUnknowProductCheckBox {
            if checkBox.on == true{
                reporterYesProductCheckBox.on = false
                reporterNoProductCheckBox.on = false
                reporterNotRequestProductCheckBox.on = false
                productContributed = "Unknown (reporter does not know)"
            }
        }else if checkBox == reporterNotRequestProductCheckBox {
            if checkBox.on == true{
                reporterYesProductCheckBox.on = false
                reporterNoProductCheckBox.on = false
                reporterUnknowProductCheckBox.on = false
                productContributed = "Not reported/not requested from reporter"
            }
        }else if checkBox == reporterYesOtherProductCheckBox {
            if checkBox.on == true{
                reporterNotRequestedOtherProductCheckBox.on = false
                reporterUnknownOtherProductCheckBox.on = false
                reporterNoOtherProductCheckBox.on = false
                reporterYesOtherProductLabel.isHidden = false
                reporterYesOtherProductTextField.isHidden = false
                self.Otherproduct = "Yes (possible)"
                
            } else {
                reporterYesOtherProductLabel.isHidden = true
                reporterYesOtherProductTextField.isHidden = true
                
            }
        }else if checkBox == reporterNotRequestedOtherProductCheckBox {
            if checkBox.on == true{
                reporterYesOtherProductCheckBox.on = false
                reporterUnknownOtherProductCheckBox.on = false
                reporterNoOtherProductCheckBox.on = false
                reporterYesOtherProductLabel.isHidden = true
                reporterYesOtherProductTextField.isHidden = true
                self.Otherproduct = "Not reported/not requested from reporter"
            }
        }else if checkBox == reporterUnknownOtherProductCheckBox {
            if checkBox.on == true{
                reporterYesOtherProductCheckBox.on = false
                reporterNotRequestedOtherProductCheckBox.on = false
                reporterNoOtherProductCheckBox.on = false
                reporterYesOtherProductLabel.isHidden = true
                reporterYesOtherProductTextField.isHidden = true
                self.Otherproduct = "Unknown (reporter does not know)"
            }
        }else if checkBox == reporterNoOtherProductCheckBox {
            if checkBox.on == true{
                reporterYesOtherProductCheckBox.on = false
                reporterNotRequestedOtherProductCheckBox.on = false
                reporterUnknownOtherProductCheckBox.on = false
                reporterYesOtherProductLabel.isHidden = true
                reporterYesOtherProductTextField.isHidden = true
                self.Otherproduct = "No (Unlikely)"
            }
        }else if checkBox == reportDetailYesCheckBox {
            if checkBox.on == true{
                reportDetailNoCheckBox.on = false
                self.permissionDoctor = "Yes"
            }
        }else if checkBox == reportDetailNoCheckBox {
            if checkBox.on == true{
                reportDetailYesCheckBox.on = false
                self.permissionDoctor = "No"
                
            }
        }else if checkBox == reporterConsentYesCheckBox {
            if checkBox.on == true{
                reporterConsentNoCheckBox.on = false
                reporterConsent = "Yes"
                
            }
        }else if checkBox == reporterConsentNoCheckBox {
            if checkBox.on == true{
                reporterConsentYesCheckBox.on = false
                self.reporterConsent = "No"
                
            }
        }else if checkBox == preferedContactPhoneCheckBox {
            if checkBox.on == true{
                preferedContactEmailCheckBox.on = false
                self.phoneText = "Phone"
                
            }
        }else if checkBox == preferedContactEmailCheckBox {
            if checkBox.on == true{
                preferedContactPhoneCheckBox.on = false
                self.phoneText = "Email"
                
            }
        }else if checkBox == typeOfReportOtherCheckBox {
            if checkBox.on == true{
                typeOfReportOtherTextField.isHidden = false
                typeOfReportNurseCheckBox.on = false
                typeOfReportPharmaCheckBox.on = false
                typeOfReportPatientCheckBox.on = false
                typeOfReportDoctorCheckBox.on = false
                reportType = typeOfReportOtherTextField.text
                
            }else{
                typeOfReportOtherTextField.isHidden = true
                
            }
        }else if checkBox == typeOfReportNurseCheckBox {
            if checkBox.on == true{
                typeOfReportOtherTextField.isHidden = true
                typeOfReportOtherCheckBox.on = false
                typeOfReportPharmaCheckBox.on = false
                typeOfReportPatientCheckBox.on = false
                typeOfReportDoctorCheckBox.on = false
                reportType = "Nurse"
                
            }
        }else if checkBox == typeOfReportPharmaCheckBox {
            if checkBox.on == true{
                typeOfReportOtherTextField.isHidden = true
                typeOfReportOtherCheckBox.on = false
                typeOfReportNurseCheckBox.on = false
                typeOfReportPatientCheckBox.on = false
                typeOfReportDoctorCheckBox.on = false
                reportType = "Pharmacist"
                
            }
        }else if checkBox == typeOfReportPatientCheckBox {
            if checkBox.on == true{
                typeOfReportOtherTextField.isHidden = true
                typeOfReportOtherCheckBox.on = false
                typeOfReportNurseCheckBox.on = false
                typeOfReportPharmaCheckBox.on = false
                typeOfReportDoctorCheckBox.on = false
                reportType = "Patient"
                
            }
        }else if checkBox == typeOfReportDoctorCheckBox {
            if checkBox.on == true{
                typeOfReportOtherTextField.isHidden = true
                typeOfReportOtherCheckBox.on = false
                typeOfReportNurseCheckBox.on = false
                typeOfReportPharmaCheckBox.on = false
                typeOfReportPatientCheckBox.on = false
                reportType = "Doctor"
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
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
        dateAdverseEventField.inputAccessoryView = toolbar
        dateAdverseEventField.inputView = ADEventdatePicker
    }
    
    func showRecivePicker(){
        //Formate Date
        ADEventdatePicker.datePickerMode = .date
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donerecivePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dateOfReciveTextField.inputAccessoryView = toolbar
        dateOfReciveTextField.inputView = ADEventdatePicker
    }
    
    @objc func donerecivePicker(){
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = "yyyy-MM-dd"
        let strDate = Formatter.string(from: ADEventdatePicker.date)
        dateOfReciveTextField.text = strDate
        self.view.endEditing(true)
    }
    
    
    @objc func donedatePicker(){
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = "yyyy-MM-dd"
        let strDate = Formatter.string(from: ADEventdatePicker.date)
        dateAdverseEventField.text = strDate
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
        yearOfBirthTextField.inputAccessoryView = toolbar
        yearOfBirthTextField.inputView = yeardatePicker
    }
    
    @objc func doneYearPicker(){
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = "yyyy"
        let strDate = Formatter.string(from: yeardatePicker.date)
        yearOfBirthTextField.text = strDate
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
        startDateTextField.inputAccessoryView = toolbar
        startDateTextField.inputView = startDatePicker
    }
    
    @objc func doneStartPicker(){
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = "yyyy-MM-dd"
        let strDate = Formatter.string(from: startDatePicker.date)
        startDateTextField.text = strDate
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
        StopDateTextField.inputAccessoryView = toolbar
        StopDateTextField.inputView = endDatePicker
    }
    
    @objc func doneEndPicker(){
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = "yyyy-MM-dd"
        let strDate = Formatter.string(from: endDatePicker.date)
        StopDateTextField.text = strDate
        self.view.endEditing(true)
    }
    
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveClicked(_ sender: Any) {
        
        let provideddDescription = descriptionTextView.text
        let providedDBrownId = DBrowIdTextfield.text
        let provideTitle = programTitleTextField.text
        let providedetailAdverseEvent = detailAdverseEventField.text
        let ProvideDateAdverse = dateAdverseEventField.text
        let provideCountry = countryTextField.text
        let provideYear = yearOfBirthTextField.text
        let provideWeight = weightTextField.text
        let provideHeight = heightTextField.text
        let provideRelevent = relaentTextField.text
        let provideNameProduct = NameProductTextField.text
        let provideProductTakin = productTakinTextField.text
        let provideDose = DosageTextField.text
        let provideBatchNo = batchNoTextField.text
        let provideStartDate = startDateTextField.text
        let provideStopDate = StopDateTextField.text
        let provideRepName = reName.text
        let provideRepAddress = addressName.text
        let provideReportName = reportNameTextField.text
        let provideAddressReport = addressReportTextField.text
        let provideContactDetail = contactDetailTextField.text
        let provideEmpName = empNameTextField.text
        let provideDateOfRevice = dateOfReciveTextField.text
        
        if provideddDescription == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if providedDBrownId == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideTitle == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if providedetailAdverseEvent == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if ProvideDateAdverse == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideCountry == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideYear == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideWeight == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideHeight == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideRelevent == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideNameProduct == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideProductTakin == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideDose == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideBatchNo == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideStartDate == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideStopDate == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideRepName == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideRepAddress == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideAddressReport == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideContactDetail == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideEmpName == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        if provideDateOfRevice == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please fill all required fields")
            return
        }
        let severtyText = self.severityOtherTextField.text
        
        var email = self.typeOfReportOtherTextField.text
        
        if email == "" {
            email = "Doctor"
        }else {
            email = ""
        }
        
        activitiyViewController.show(existingUiViewController: self)
        var params = Dictionary<String, String>()
        
        params["EmployeeExternalId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);
        params["ProgrammeUniqueIdentifier"] = providedDBrownId;
        params["ProgrammeTitle"] = provideTitle;
        params["Details"] = providedetailAdverseEvent;
        params["Description"] = provideddDescription;
        params["Severity"] = self.severtiText;
        params["SeverityOther"] = self.severtiText;
        params["StartDate"] = provideStartDate;
        params["Outcome"] = self.OutComeText;
        params["TreatmentTaken"] = self.TretmentText;
        params["Treatment"] = self.TretmentText;
        params["Gender"] = self.sexseText;
        params["Country"] = provideCountry;
        params["YearOfBirth"] = provideYear;
        params["AgeGroup"] = self.ageText;
        params["Weight"] = provideWeight;
        params["WeightUnit"] = "7";
        params["Height"] = provideHeight;
        params["HeightUnit"] = "6";
        params["OtherRelevantInfo"] = provideRelevent;
        params["ProductId"] = "\(2)" ;
        params["ProductTakenFor"] = provideProductTakin;
        params["ProductDose"] = provideDose;
        params["ProductBatchNo"] = provideBatchNo;
        params["ProductStartDate"] = provideStartDate;
        params["ProductStopDate"] = provideStopDate;
        params["ProductStoppedBecauseOfAdverseEvents"] = self.productStoppedText;
        params["ProductContributedToAdverseEvents"] = self.productContributed;
        params["OtherProductContributedToAdverseEvents"] = self.Otherproduct;
        params["OtherProductId"] = "\(2)" ;
        params["PermissionToContactTheDoctor"] = self.permissionDoctor;
        params["DoctorName"] = provideRepName;
        params["DoctorAddress"] = provideRepAddress;
        params["ReporterConsentToDisclosePersonalDetails"] = self.reporterConsent;
        params["ReporterName"] = provideReportName;
        params["ReporterAddress"] = provideAddressReport;
        params["ReporterPreferredMethodOfContact"] = self.phoneText;
        params["ReporterContactDetails"] = provideContactDetail;
        params["ReporterType"] = self.reportType;
        params["ReporterTypeOther"] = self.reportType;
        
        Alamofire.request(Constants.AdverseReportingApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: true, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please check your internet connection")
                        return
                    }
                    
                    let aEReportingModel = Mapper<AEReportingModel>().map(JSONString: response.value!) //JSON to model
                    
                    if aEReportingModel != nil {
                        
                        if aEReportingModel?.result == 1 {
                            
                            CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Form successfully submitted", onOkClicked: {()
                                
                                let screen = CommonUtils.getJsonFromUserDefaults(forKey: Constants.screen1)
                                
                                if screen == "1" {
                                    
                                    self.dismiss(animated: true, completion: nil)
                                }else {
                                    
                                    self.performSegue(withIdentifier: "SendNonConformityScreen", sender: self)
                                    
                                }
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

