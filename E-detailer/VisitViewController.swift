//
//  VisitViewController.swift
//  E-detailer
//
//  Created by Macbook Air on 10/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import Cosmos
import Photos

class VisitViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var currentNNProductTextField: UITextField!
    @IBOutlet weak var currentNNProductTextField2: UITextField!
    @IBOutlet weak var currentNNProduct3Textfield: UITextField!
    @IBOutlet weak var deviceDemo1TextField: UITextField!
    @IBOutlet weak var deviceDemo2TextField: UITextField!
    @IBOutlet weak var deviceDemo3TextField: UITextField!
    @IBOutlet weak var doseTextField1: UITextField!
    @IBOutlet weak var doseTextField2: UITextField!
    @IBOutlet weak var doseTextField3: UITextField!
    @IBOutlet weak var frequencyTextField1: UITextField!
    @IBOutlet weak var frequencyTextField2: UITextField!
    @IBOutlet weak var frequencyTextField3: UITextField!
    @IBOutlet weak var eDoseTextField1: UITextField!
    @IBOutlet weak var eDoseTextField2: UITextField!
    @IBOutlet weak var eDoseTextField3: UITextField!
    @IBOutlet weak var patientConsentTextfield: UITextField!
    @IBOutlet weak var prescriptionTextfield: UITextField!
    @IBOutlet weak var visitObjectiveTextView: UITextView!
    @IBOutlet weak var productNN1textfield: UITextField!
    //    @IBOutlet weak var BP2Label: UITextField!
    @IBOutlet weak var productNN2Textfield: UITextField!
    @IBOutlet weak var productNN3Textfield: UITextField!
    @IBOutlet weak var productConcomitant1Textfield: UITextField!
    @IBOutlet weak var productConcomitant2Textfield: UITextField!
    @IBOutlet weak var productConcomitant3Textfield: UITextField!
    @IBOutlet weak var previousNN1Textfield: UITextField!
    @IBOutlet weak var previousNN2Textfield: UITextField!
    @IBOutlet weak var previousNN3TextField: UITextField!
    @IBOutlet weak var previousOtherProductTextfield: UITextField!
    @IBOutlet weak var previousOtherProduct2TextField: UITextField!
    @IBOutlet weak var previousOtherProduct3TextField: UITextField!
    @IBOutlet weak var infoNNProductTextfield: UITextField!
    @IBOutlet weak var deviceDemostrationTextfield: UITextField!
    @IBOutlet weak var readingBGSTextfield: UITextField!
    @IBOutlet weak var readingWeightTextfield: UITextField!
    @IBOutlet weak var readingBPTextfield: UITextField!
    @IBOutlet weak var educationProvideLayout: UIView!
    @IBOutlet weak var educationProvideCollectionView: UICollectionView!
    @IBOutlet weak var patientConstantView: UIView!
    @IBOutlet weak var prescriptionMainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var patientConstantImageView: UIImageView!
    @IBOutlet weak var prescribtionImageView: UIImageView!
    @IBOutlet weak var saftyFeildView: UIView!
    @IBOutlet weak var drugEventTextField: UITextField!
    @IBOutlet weak var tecnicalIssueField: UITextField!
    @IBOutlet weak var gDMTextField: UITextField!
    @IBOutlet weak var overDoseAndMisuseTextField: UITextField!
    @IBOutlet weak var hospitilaizationTextField: UITextField!
    @IBOutlet weak var reasonTextField: UITextField!
    @IBOutlet weak var offLabelTextfield: UITextField!
    @IBOutlet var mainViewOutlet: UIView!
    
    @IBOutlet weak var whiteViewOutlet: UIView!
    
    @IBOutlet weak var lastView: UIButton!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var HbA1cTextField: UITextField!
    @IBOutlet weak var cosmosFullView: CosmosView!
    
    //    var dropDownInfo : PatientResult?
    
    //    var homeCurrentCall: HomeCallModel? = nil
    
    var selectedTopicApi : [EducationalActivityDiscussionTopic] = [];
    var safetyEvent : Bool?
    var drugEvents : Bool?
    var technicalIssueEvent : Bool?
    var gDMEvent : Bool?
    var currentNNId: Int?
    var currentNNId2: Int?
    var currentNNId3: Int?
    var overDoseEvent : Bool?
    var hospitilaizationEvent : Bool?
    var reasonEvent : Bool?
    var offLabelEvent : Bool?
    var homeActivityDiscussionTopic: Dictionary<String, Any> = [:]
    var dropDownInfo: PatientResult?
    weak var pickerView: UIPickerView?
    var previousNN: [String] = ["", "" , ""]
    var previousNNOther: [String] = ["", "" , ""]
    var productConcomitant: [String] = ["", "" , ""]
    var productNN: [String] = ["", "" , ""]
    var doseNN: [Int] = [ 0, 0 , 0 , 0, 0 , 0, 0, 0 , 0]
    var patientConsent = ["No", "Yes"]
    var visitObject = ["Device Demo", "Injecting Techniques"]
    var sampleArray = ["a","b","c"]
    var info = true
    var demo = true
    var selectedTab: String = "0"
    
    var Homeprescribtion: String = "False"
    var educationProvideDataSource: HomeEducationListCell!
    var selectedPatient: PlannedPatients? = nil
    var startTime: String?
    var selectedNNId: [Int] = [];
    var selectedNNName: [String] = [];
    var selectedNNName2: [String] = [];
    var selectedNNName3: [String] = [];
    var activitiyViewController: ActivityViewController!
    
    var imagePicker = UIImagePickerController()

    
    var selectedImageData: Data?
    var fileName: String? = ""
    var filePathWithName: URL?
    
    var selectedImageDataPre: Data?
    var fileNamePre: String? = ""
    var filePathWithNamePre: URL?
    
    var imagePickerRequestFor: String? = ""
    var patientConsentUrl: String? = ""
    var prescribtionUrl: String? = ""
    var maxLength : Int?
    var ratingScale:Int?
    var dosId: Int?
    var dosId2: Int?
    var dosId3: Int?
    var dosId4: Int?
    var dosId5: Int?
    var dosId6: Int?
    var dosId7: Int?
    var dosId8: Int?
    var dosId9: Int?
    var deviceDemoId: Int?
    var deviceDemoId2: Int?
    var deviceDemoId3: Int?
    
    
    override func viewDidLoad() {
        
        
        let getStartTime = String(CommonUtils.getCurrentTime())
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.GetTime, withJson: getStartTime)
        
        let Uuid = UUID().uuidString
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.homePatientUuid, withJson: Uuid)
        
        
        let Objective = CommonUtils.getJsonFromUserDefaults(forKey: Constants.Objective)
        if Objective == "" {
            visitObjectiveTextView.text = "No Objective"
        }else {
            visitObjectiveTextView.text = Objective
        }
        
        self.doseTextField1.isUserInteractionEnabled = false
        self.doseTextField2.isUserInteractionEnabled = false
        self.doseTextField3.isUserInteractionEnabled = false
        self.currentNNProductTextField2.isUserInteractionEnabled = false
        self.currentNNProduct3Textfield.isUserInteractionEnabled = false
        
        self.eDoseTextField1.isUserInteractionEnabled = false
        self.eDoseTextField2.isUserInteractionEnabled = false
        self.eDoseTextField3.isUserInteractionEnabled = false
        
        self.frequencyTextField1.isUserInteractionEnabled = false
        self.frequencyTextField2.isUserInteractionEnabled = false
        self.frequencyTextField3.isUserInteractionEnabled = false
        
        cosmosFullView.didTouchCosmos = {rating in
            self.ratingScale = Int(rating)
            
        }
        
        readingBPTextfield.delegate = self
        readingWeightTextfield.delegate = self
        readingBGSTextfield.delegate = self
        HbA1cTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarddisAppear), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        //        loadImagePicker()
        startTime = String(CommonUtils.getCurrentTime())
        
        //!--- Get dropdown data
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //            self.callProductApi()
        //        }
        
        self.scrollView.isScrollEnabled = false
        
        
        //        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        educationProvideDataSource = HomeEducationListCell()
        educationProvideDataSource.onSelect =
        {(type: EducationalActivityDiscussionTopic, isExplainedSelected: Bool, isHardCopySelected:Bool) in
            if let a = self.selectedTopicApi.firstIndex(where: { $0.name == type.name}){
                self.selectedTopicApi.remove(at: a)
                self.selectedTopicApi.append(type)
            }else{
                self.selectedTopicApi.append(type)
            }
            
            if let a = self.selectedTopicApi.firstIndex(where: { $0.name == type.name}){
                self.selectedTopicApi[a].isExplained = isExplainedSelected
                self.selectedTopicApi[a].isHardcopy = isHardCopySelected
            }
            
            
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.ishardCopy, withJson: String(isHardCopySelected))
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.isexplained, withJson: String(isExplainedSelected))
            
        }
        
        educationProvideCollectionView.dataSource = educationProvideDataSource
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        patientConsentTextfield.delegate = self
        patientConsentTextfield.inputView = pickerView
        
        drugEventTextField.delegate = self
        drugEventTextField.inputView = pickerView
        
        currentNNProductTextField.delegate = self
        currentNNProductTextField.inputView = pickerView
        
        currentNNProductTextField2.delegate = self
        currentNNProductTextField2.inputView = pickerView
        
        currentNNProduct3Textfield.delegate = self
        currentNNProduct3Textfield.inputView = pickerView
        
        deviceDemo1TextField.delegate = self
        deviceDemo1TextField.inputView = pickerView
        
        deviceDemo2TextField.delegate = self
        deviceDemo2TextField.inputView = pickerView
        
        deviceDemo3TextField.delegate = self
        deviceDemo3TextField.inputView = pickerView
        
        doseTextField1.delegate = self
        doseTextField1.inputView = pickerView
        
        doseTextField2.delegate = self
        doseTextField2.inputView = pickerView
        
        doseTextField3.delegate = self
        doseTextField3.inputView = pickerView
        
        frequencyTextField1.delegate = self
        frequencyTextField1.inputView = pickerView
        
        frequencyTextField2.delegate = self
        frequencyTextField2.inputView = pickerView
        
        frequencyTextField3.delegate = self
        frequencyTextField3.inputView = pickerView
        
        eDoseTextField1.delegate = self
        eDoseTextField1.inputView = pickerView
        
        eDoseTextField2.delegate = self
        eDoseTextField2.inputView = pickerView
        
        eDoseTextField3.delegate = self
        eDoseTextField3.inputView = pickerView
        
        tecnicalIssueField.delegate = self
        tecnicalIssueField.inputView = pickerView
        
        gDMTextField.delegate = self
        gDMTextField.inputView = pickerView
        
        overDoseAndMisuseTextField.delegate = self
        overDoseAndMisuseTextField.inputView = pickerView
        
        hospitilaizationTextField.delegate = self
        hospitilaizationTextField.inputView = pickerView
        
        reasonTextField.delegate = self
        reasonTextField.inputView = pickerView
        
        offLabelTextfield.delegate = self
        offLabelTextfield.inputView = pickerView
        
        //        safetyEventLabelView.delegate = self
        //        safetyEventLabelView.inputView = pickerView
        
        prescriptionTextfield.delegate = self
        prescriptionTextfield.inputView = pickerView
        
        infoNNProductTextfield.delegate = self
        infoNNProductTextfield.inputView = pickerView
        
        deviceDemostrationTextfield.delegate = self
        deviceDemostrationTextfield.inputView = pickerView
        
        
        previousNN1Textfield.delegate = self
        previousNN1Textfield.inputView = pickerView
        
        previousNN2Textfield.delegate = self
        previousNN2Textfield.inputView = pickerView
        
        previousNN3TextField.delegate = self
        previousNN3TextField.inputView = pickerView
        
        previousOtherProductTextfield.delegate = self
        previousOtherProductTextfield.inputView = pickerView
        
        previousOtherProduct2TextField.delegate = self
        previousOtherProduct2TextField.inputView = pickerView
        
        previousOtherProduct3TextField.delegate = self
        previousOtherProduct3TextField.inputView = pickerView
        
        productNN1textfield.delegate = self
        productNN1textfield.inputView = pickerView
        
        productNN2Textfield.delegate = self
        productNN2Textfield.inputView = pickerView
        
        productNN3Textfield.delegate = self
        productNN3Textfield.inputView = pickerView
        
        productConcomitant1Textfield.delegate = self
        productConcomitant1Textfield.inputView = pickerView
        
        productConcomitant2Textfield.delegate = self
        productConcomitant2Textfield.inputView = pickerView
        
        productConcomitant3Textfield.delegate = self
        productConcomitant3Textfield.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        drugEventTextField.inputAccessoryView = toolBar
        tecnicalIssueField.inputAccessoryView = toolBar
        gDMTextField.inputAccessoryView = toolBar
        overDoseAndMisuseTextField.inputAccessoryView = toolBar
        hospitilaizationTextField.inputAccessoryView = toolBar
        reasonTextField.inputAccessoryView = toolBar
        offLabelTextfield.inputAccessoryView = toolBar
        patientConsentTextfield.inputAccessoryView = toolBar
        //        safetyEventLabelView.inputAccessoryView = toolBar
        prescriptionTextfield.inputAccessoryView = toolBar
        infoNNProductTextfield.inputAccessoryView = toolBar
        deviceDemostrationTextfield.inputAccessoryView = toolBar
        previousNN1Textfield.inputAccessoryView = toolBar
        previousNN2Textfield.inputAccessoryView = toolBar
        previousNN3TextField.inputAccessoryView = toolBar
        previousOtherProductTextfield.inputAccessoryView = toolBar
        previousOtherProduct2TextField.inputAccessoryView = toolBar
        previousOtherProduct3TextField.inputAccessoryView = toolBar
        productNN1textfield.inputAccessoryView = toolBar
        productNN2Textfield.inputAccessoryView = toolBar
        productNN3Textfield.inputAccessoryView = toolBar
        productConcomitant1Textfield.inputAccessoryView = toolBar
        productConcomitant2Textfield.inputAccessoryView = toolBar
        productConcomitant3Textfield.inputAccessoryView = toolBar
        currentNNProductTextField.inputAccessoryView = toolBar
        currentNNProductTextField2.inputAccessoryView = toolBar
        currentNNProduct3Textfield.inputAccessoryView = toolBar
        deviceDemo1TextField.inputAccessoryView = toolBar
        deviceDemo2TextField.inputAccessoryView = toolBar
        deviceDemo3TextField.inputAccessoryView = toolBar
        doseTextField1.inputAccessoryView = toolBar
        doseTextField2.inputAccessoryView = toolBar
        doseTextField3.inputAccessoryView = toolBar
        frequencyTextField1.inputAccessoryView = toolBar
        frequencyTextField2.inputAccessoryView = toolBar
        frequencyTextField3.inputAccessoryView = toolBar
        eDoseTextField1.inputAccessoryView = toolBar
        eDoseTextField2.inputAccessoryView = toolBar
        eDoseTextField3.inputAccessoryView = toolBar
        
        self.pickerView = pickerView
        
        //        if safetyEventLabelView.text == "NO" || safetyEventLabelView.text == "" {
        //            saftyFeildView.isHidden = true
        //        }
        imagePicker.delegate = self
        
        let callApi = CallApi()
        callApi.getAllPatient(url: Constants.GetPatientDataApi, completionHandler: {(getPatientDataModel: GetPatientDataModel?, error: String?) in
            
            if (error != nil) {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: error!)
                return
            }
            // On Response
            
            //temp variable
            let getPatientDataModelCopy =  getPatientDataModel
            
            //On Dialog Close
            if getPatientDataModelCopy != nil {
                
                if (getPatientDataModelCopy?.success)! {
                    
                    self.educationProvideDataSource.setItems(items: getPatientDataModelCopy?.result?.educationalActivityViewModel?.educationalActivityDiscussionTopic)
                    self.educationProvideCollectionView.reloadData()
                    self.dropDownInfo = getPatientDataModelCopy?.result
                    
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (getPatientDataModel?.error!)!)
                }
            } else {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
            }
        })
        
        
        let ammad = self.dropDownInfo
        
        if ammad != nil {
            self.educationProvideDataSource.setItems(items: dropDownInfo?.educationalActivityViewModel?.educationalActivityDiscussionTopic)
            self.educationProvideCollectionView.reloadData()
        }else {
            return
        }
        
    }
    
    
    @IBAction func webViewBtn(_ sender: Any) {
        
        if let url = URL(string: "https://www.novonordisk.com.au/contact-us/safety-information-report.html") {
            UIApplication.shared.open(url)
            
        }
    }
    
    
    var isExpand : Bool = false
    
    @objc func keyboardAppear() {
        if !isExpand {
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 3550 )
            isExpand = true
        }
        
    }
    
    @objc func keyboarddisAppear() {
        
        if !isExpand {
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 3550 )
            isExpand = false
        }
        
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == readingBGSTextfield{
            maxLength = 8
        }else if textField == readingBPTextfield{
            maxLength = 8
        } else if textField == readingWeightTextfield{
            maxLength = 8
        }else if textField == HbA1cTextField{
            maxLength = 8
        }
        
        let currentString: NSString = textField.text! as NSString
        
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength ?? 0
    }
    
    //    func callProductApi() {
    //        activitiyViewController.show(existingUiViewController: self)
    //        CallApi().getAllPatient(url: Constants.GetPatientDataApi, completionHandler: {(getPatientDataModel: GetPatientDataModel?, error: String?) in
    //            self.activitiyViewController.dismiss(animated: false, completion: {
    //                if (error != nil) {
    //                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: error!)
    //                    return
    //                }
    //
    //                //temp variable
    //                let getPatientDataModelCopy =  getPatientDataModel
    //
    //                //On Dialog Close
    //                if getPatientDataModelCopy != nil {
    //                    if (getPatientDataModelCopy?.success)! {
    //                        self.dropDownInfo = getPatientDataModel?.result
    //                        self.educationProvideDataSource.setItems(items: getPatientDataModel?.result?.educationalActivityViewModel?.educationalActivityDiscussionTopic)
    //                        self.educationProvideCollectionView.reloadData()
    //                    } else {
    //                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (getPatientDataModel?.error!)!)
    //                    }
    //                } else {
    //                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "The Internet connection appers to be offline.")
    //                }
    //            })
    //        })
    //    }
    
    @objc func donePicker(){
        
        self.drugEventTextField.resignFirstResponder()
        self.tecnicalIssueField.resignFirstResponder()
        self.gDMTextField.resignFirstResponder()
        self.overDoseAndMisuseTextField.resignFirstResponder()
        self.hospitilaizationTextField.resignFirstResponder()
        self.reasonTextField.resignFirstResponder()
        self.offLabelTextfield.resignFirstResponder()
        self.patientConsentTextfield.resignFirstResponder()
        //        self.safetyEventLabelView.resignFirstResponder()
        self.infoNNProductTextfield.resignFirstResponder()
        self.prescriptionTextfield.resignFirstResponder()
        self.deviceDemostrationTextfield.resignFirstResponder()
        self.previousNN1Textfield.resignFirstResponder()
        self.previousNN2Textfield.resignFirstResponder()
        self.previousNN3TextField.resignFirstResponder()
        self.previousOtherProductTextfield.resignFirstResponder()
        self.previousOtherProduct2TextField.resignFirstResponder()
        self.previousOtherProduct3TextField.resignFirstResponder()
        self.productNN1textfield.resignFirstResponder()
        self.productNN2Textfield.resignFirstResponder()
        self.productNN3Textfield.resignFirstResponder()
        self.productConcomitant1Textfield.resignFirstResponder()
        self.productConcomitant2Textfield.resignFirstResponder()
        self.productConcomitant3Textfield.resignFirstResponder()
        self.currentNNProductTextField.resignFirstResponder()
        self.currentNNProductTextField2.resignFirstResponder()
        self.currentNNProduct3Textfield.resignFirstResponder()
        self.deviceDemo1TextField.resignFirstResponder()
        self.deviceDemo2TextField.resignFirstResponder()
        self.deviceDemo3TextField.resignFirstResponder()
        self.doseTextField1.resignFirstResponder()
        self.doseTextField2.resignFirstResponder()
        self.doseTextField3.resignFirstResponder()
        self.frequencyTextField1.resignFirstResponder()
        self.frequencyTextField2.resignFirstResponder()
        self.frequencyTextField3.resignFirstResponder()
        self.eDoseTextField1.resignFirstResponder()
        self.eDoseTextField2.resignFirstResponder()
        self.eDoseTextField3.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
        self.pickerView?.selectedRow(inComponent: 0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if patientConsentTextfield.isFirstResponder{
            return (self.patientConsent.count)
        }else if drugEventTextField.isFirstResponder{
            return (self.patientConsent.count)
        } else if tecnicalIssueField.isFirstResponder{
            return (self.patientConsent.count)
        } else if gDMTextField.isFirstResponder{
            return (self.patientConsent.count)
        } else if overDoseAndMisuseTextField.isFirstResponder{
            return (self.patientConsent.count)
        } else if hospitilaizationTextField.isFirstResponder{
            return (self.patientConsent.count)
        } else if reasonTextField.isFirstResponder{
            return (self.patientConsent.count)
        } else if offLabelTextfield.isFirstResponder{
            return (self.patientConsent.count)
        }  else if prescriptionTextfield.isFirstResponder{
            return (self.patientConsent.count)
        }else if infoNNProductTextfield.isFirstResponder{
            return (self.patientConsent.count)
        }else if doseTextField1.isFirstResponder{
            return (self.selectedNNName.count)
        }else if doseTextField2.isFirstResponder{
            return (self.selectedNNName2.count)
        }else if doseTextField3.isFirstResponder{
            return (self.selectedNNName3.count)
        }else if eDoseTextField1.isFirstResponder{
            return (self.selectedNNName.count)
        }else if eDoseTextField2.isFirstResponder{
            return (self.selectedNNName2.count)
        }else if eDoseTextField3.isFirstResponder{
            return (self.selectedNNName3.count)
        }else if frequencyTextField1.isFirstResponder{
            return (self.selectedNNName.count)
        }else if frequencyTextField2.isFirstResponder{
            return (self.selectedNNName2.count)
        }else if frequencyTextField3.isFirstResponder{
            return (self.selectedNNName3.count)
        }else if deviceDemo1TextField.isFirstResponder{
            return (self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDevice?.count ?? 0)!
        }else if deviceDemo2TextField.isFirstResponder{
            return (self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDevice?.count ?? 0)!
        }else if deviceDemo3TextField.isFirstResponder{
            return (self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDevice?.count ?? 0)!
        }else if deviceDemostrationTextfield.isFirstResponder{
            return (self.patientConsent.count)
        }else if previousOtherProductTextfield.isFirstResponder{
            return (self.dropDownInfo?.educationalActivityViewModel?.educationalActivityOtherProduct?.count ?? 0)
        }else if previousOtherProduct2TextField.isFirstResponder{
            return (self.dropDownInfo?.educationalActivityViewModel?.educationalActivityOtherProduct?.count ?? 0)
        }else if previousOtherProduct3TextField.isFirstResponder{
            return (self.dropDownInfo?.educationalActivityViewModel?.educationalActivityOtherProduct?.count ?? 0)
        }else if productNN1textfield.isFirstResponder || productNN2Textfield.isFirstResponder || productNN3Textfield.isFirstResponder || productConcomitant1Textfield.isFirstResponder || productConcomitant2Textfield.isFirstResponder || productConcomitant3Textfield.isFirstResponder || previousNN2Textfield.isFirstResponder ||
                    previousNN3TextField.isFirstResponder ||
                    previousNN1Textfield.isFirstResponder ||
                    currentNNProductTextField.isFirstResponder ||
                    currentNNProductTextField2.isFirstResponder ||
                    currentNNProduct3Textfield.isFirstResponder{
            return (self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?.count ?? 0)
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if patientConsentTextfield.isFirstResponder{
            return self.patientConsent[row]
        }
        else if drugEventTextField.isFirstResponder{
            return self.patientConsent[row]
        }
        else if tecnicalIssueField.isFirstResponder{
            return self.patientConsent[row]
        }
        else if gDMTextField.isFirstResponder{
            return self.patientConsent[row]
        }
        else if overDoseAndMisuseTextField.isFirstResponder{
            return self.patientConsent[row]
        }
        else if hospitilaizationTextField.isFirstResponder{
            return self.patientConsent[row]
        }
        else if reasonTextField.isFirstResponder{
            return self.patientConsent[row]
        }else if offLabelTextfield.isFirstResponder{
            return self.patientConsent[row]
        }else if prescriptionTextfield.isFirstResponder{
            return self.patientConsent[row]
        }else if infoNNProductTextfield.isFirstResponder{
            return self.patientConsent[row]
        }else if doseTextField1.isFirstResponder{
            return self.selectedNNName[row]
        }else if doseTextField2.isFirstResponder{
            return self.selectedNNName2[row]
        }else if doseTextField3.isFirstResponder{
            return self.selectedNNName3[row]
        }else if eDoseTextField1.isFirstResponder{
            return self.selectedNNName[row]
        }else if eDoseTextField2.isFirstResponder{
            return self.selectedNNName2[row]
        }else if eDoseTextField3.isFirstResponder{
            return self.selectedNNName3[row]
        }else if frequencyTextField1.isFirstResponder{
            return self.selectedNNName[row]
        }else if frequencyTextField2.isFirstResponder{
            return self.selectedNNName2[row]
        }else if frequencyTextField3.isFirstResponder{
            return self.selectedNNName3[row]
        }else if deviceDemostrationTextfield.isFirstResponder{
            return self.patientConsent[row]
        }else if deviceDemo1TextField.isFirstResponder{
            return self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDevice?[row].name
        }else if deviceDemo2TextField.isFirstResponder{
            return self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDevice?[row].name
        }else if deviceDemo3TextField.isFirstResponder{
            return self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDevice?[row].name
        } else if previousOtherProductTextfield.isFirstResponder{
            return self.dropDownInfo?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name ?? ""
        } else if previousOtherProduct2TextField.isFirstResponder{
            return self.dropDownInfo?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name ?? ""
        } else if previousOtherProduct3TextField.isFirstResponder{
            return self.dropDownInfo?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name ?? ""
        } else if productNN1textfield.isFirstResponder || productNN2Textfield.isFirstResponder || productNN3Textfield.isFirstResponder || productConcomitant1Textfield.isFirstResponder || productConcomitant2Textfield.isFirstResponder || productConcomitant3Textfield.isFirstResponder || previousNN1Textfield.isFirstResponder || previousNN2Textfield.isFirstResponder ||
                    previousNN3TextField.isFirstResponder ||
                    currentNNProductTextField.isFirstResponder ||
                    currentNNProductTextField2.isFirstResponder ||
                    currentNNProduct3Textfield.isFirstResponder{
            return self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row].name ?? ""
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if patientConsentTextfield.isFirstResponder{
            let itemselected = self.patientConsent[row]
            patientConsentTextfield.text = itemselected
            
            if (itemselected.lowercased().elementsEqual("yes")) {
                patientConstantView.isHidden = false
                self.scrollView.isScrollEnabled = true
                
                self.whiteViewOutlet.isHidden = true
            } else {
                patientConstantView.isHidden = true
                self.scrollView.isScrollEnabled = false
                
                self.whiteViewOutlet.isHidden = false
            }
        }else if prescriptionTextfield.isFirstResponder{
            let itemselected = self.patientConsent[row]
            prescriptionTextfield.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                prescriptionMainView.isHidden = false
            } else {
                prescriptionMainView.isHidden = true
            }
        }
        
        
        //    var safetyEvent : Bool?
        //    var drugEvent : Bool?
        //    var technicalIssueEvent : Bool?
        //    var gDMEvent : Bool?
        //    var overDoseEvent : Bool?
        //    var hospitilaizationEvent : Bool?
        //    var reasonEvent : Bool?
        //    var offLabelEvent : Bool?
        else if drugEventTextField.isFirstResponder{
            let itemselected = self.patientConsent[row]
            drugEventTextField.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                self.drugEvents = true
            } else {
                self.drugEvents = false
            }
        }else if tecnicalIssueField.isFirstResponder{
            let itemselected = self.patientConsent[row]
            tecnicalIssueField.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                self.technicalIssueEvent = true
            } else {
                self.technicalIssueEvent = false
            }
        }else if gDMTextField.isFirstResponder{
            let itemselected = self.patientConsent[row]
            gDMTextField.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                self.gDMEvent = true
            } else {
                self.gDMEvent = false
            }
        }else if overDoseAndMisuseTextField.isFirstResponder{
            let itemselected = self.patientConsent[row]
            overDoseAndMisuseTextField.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                self.overDoseEvent = true
            } else {
                self.overDoseEvent = false
            }
        }else if hospitilaizationTextField.isFirstResponder{
            let itemselected = self.patientConsent[row]
            hospitilaizationTextField.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                self.hospitilaizationEvent = true
            } else {
                self.hospitilaizationEvent = false
            }
        }else if reasonTextField.isFirstResponder{
            let itemselected = self.patientConsent[row]
            reasonTextField.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                self.reasonEvent = true
            } else {
                self.reasonEvent = false
            }
        }else if offLabelTextfield.isFirstResponder{
            let itemselected = self.patientConsent[row]
            offLabelTextfield.text = itemselected
            if (itemselected.lowercased().elementsEqual("yes")) {
                self.offLabelEvent = true
            } else {
                self.offLabelEvent = false
            }
        }else if infoNNProductTextfield.isFirstResponder{
            let itemselected = self.patientConsent[row]
            infoNNProductTextfield.text = itemselected
        }else if deviceDemostrationTextfield.isFirstResponder{
            let itemselected = self.patientConsent[row]
            deviceDemostrationTextfield.text = itemselected
        }else if previousNN1Textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            previousNN1Textfield.text = n?.name
            previousNN[0] = String(describing: n?.id ?? 0)
        }else if previousNN2Textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            previousNN2Textfield.text = n?.name
            previousNN[1] = String(describing: n?.id ?? 0)
        }else if previousNN3TextField.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            previousNN3TextField.text = n?.name
            previousNN[2] = String(describing: n?.id ?? 0)
        }else if currentNNProductTextField.isFirstResponder{
            let itemselected = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            currentNNProductTextField.text = itemselected
            self.doseTextField1.isUserInteractionEnabled = true
            self.frequencyTextField1.isUserInteractionEnabled = true
            self.eDoseTextField1.isUserInteractionEnabled = true
            self.doseTextField1.text = ""
            self.frequencyTextField1.text = ""
            self.eDoseTextField1.text = ""
            self.currentNNId = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row].id
            self.productNN[0] = "\(String(describing: self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row].id ?? 0))"
            
            let CurrentId = self.currentNNId
            let getProductId = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDoseProductWise
            
            self.selectedNNId = []
            self.selectedNNName = []
            
            for value in getProductId! {
                if CurrentId == value.productId {
                    self.selectedNNId.append(value.doseId ?? 0)
                    self.selectedNNName.append(value.doseName ?? "")
                }
            }
        }else if currentNNProductTextField2.isFirstResponder{
            let itemselected = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            currentNNProductTextField2.text = itemselected
            self.doseTextField2.isUserInteractionEnabled = true
            self.frequencyTextField2.isUserInteractionEnabled = true
            self.eDoseTextField2.isUserInteractionEnabled = true
            self.doseTextField2.text = ""
            self.frequencyTextField2.text = ""
            self.eDoseTextField2.text = ""
            self.currentNNId2 = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row].id
            self.productNN[1] = "\(String(describing: self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row].id ?? 0))"
            
            let CurrentId2 = self.currentNNId2
            let getProductId = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDoseProductWise
            
            self.selectedNNId = []
            self.selectedNNName2 = []
            
            for value in getProductId! {
                if CurrentId2 == value.productId {
                    self.selectedNNId.append(value.doseId ?? 0)
                    self.selectedNNName2.append(value.doseName ?? "")
                }
            }
        }else if currentNNProduct3Textfield.isFirstResponder{
            let itemselected = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            currentNNProduct3Textfield.text = itemselected
            self.doseTextField3.isUserInteractionEnabled = true
            self.frequencyTextField3.isUserInteractionEnabled = true
            self.eDoseTextField3.isUserInteractionEnabled = true
            self.doseTextField3.text = ""
            self.frequencyTextField3.text = ""
            self.eDoseTextField3.text = ""
            self.currentNNId3 = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row].id
            self.productNN[2] = "\(String(describing: self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row].id ?? 0))"
            let CurrentId3 = self.currentNNId3
            let getProductId = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDoseProductWise
            
            self.selectedNNId = []
            self.selectedNNName3 = []
            
            for value in getProductId! {
                if CurrentId3 == value.productId {
                    self.selectedNNId.append(value.doseId ?? 0)
                    self.selectedNNName3.append(value.doseName ?? "")
                }
            }
        }else if deviceDemo1TextField.isFirstResponder{
            let itemselected = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDevice?[row].name
            deviceDemo1TextField.text = itemselected
            self.deviceDemoId = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDevice?[row].id
        }else if deviceDemo2TextField.isFirstResponder{
            let itemselected = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDevice?[row].name
            deviceDemo2TextField.text = itemselected
            self.deviceDemoId2 = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDevice?[row].id
        }else if deviceDemo3TextField.isFirstResponder{
            let itemselected = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDevice?[row].name
            deviceDemo3TextField.text = itemselected
            self.deviceDemoId3 = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityDevice?[row].id
        }else if doseTextField1.isFirstResponder{
            let itemselected = self.selectedNNName[row]
            doseTextField1.text = itemselected
            self.dosId = self.selectedNNId[row]
            self.doseNN[0] = self.selectedNNId[row]
            if self.frequencyTextField1.text != "" && eDoseTextField1.text != ""{
                self.currentNNProductTextField2.isUserInteractionEnabled = true
            }
            //ammad
        }else if doseTextField2.isFirstResponder{
            let itemselected = self.selectedNNName2[row]
            doseTextField2.text = itemselected
            self.dosId4 = self.selectedNNId[row]
            self.doseNN[3] = self.selectedNNId[row]
            if self.frequencyTextField2.text != "" && eDoseTextField2.text != ""{
                self.currentNNProduct3Textfield.isUserInteractionEnabled = true
            }
        }else if doseTextField3.isFirstResponder{
            let itemselected = self.selectedNNName3[row]
            doseTextField3.text = itemselected
            self.dosId7 = self.selectedNNId[row]
            self.doseNN[6] = self.selectedNNId[row]
        }else if eDoseTextField1.isFirstResponder{
            let itemselected = self.selectedNNName[row]
            eDoseTextField1.text = itemselected
            self.dosId3 = self.selectedNNId[row]
            self.doseNN[2] = self.selectedNNId[row]
            if self.doseTextField1.text != "" && frequencyTextField1.text != ""{
                self.currentNNProductTextField2.isUserInteractionEnabled = true
            }
        }else if eDoseTextField2.isFirstResponder{
            let itemselected = self.selectedNNName2[row]
            eDoseTextField2.text = itemselected
            self.dosId6 = self.selectedNNId[row]
            self.doseNN[5] = self.selectedNNId[row]
            if self.doseTextField2.text != "" && frequencyTextField2.text != ""{
                self.currentNNProduct3Textfield.isUserInteractionEnabled = true
            }
        }else if eDoseTextField3.isFirstResponder{
            let itemselected = self.selectedNNName3[row]
            eDoseTextField3.text = itemselected
            self.dosId9 = self.selectedNNId[row]
            self.doseNN[8] = self.selectedNNId[row]
        }else if frequencyTextField1.isFirstResponder{
            let itemselected = self.selectedNNName[row]
            frequencyTextField1.text = itemselected
            self.dosId2 = self.selectedNNId[row]
            self.doseNN[1] = self.selectedNNId[row]
            if self.doseTextField1.text != "" && eDoseTextField1.text != ""{
                self.currentNNProductTextField2.isUserInteractionEnabled = true
            }
        }else if frequencyTextField2.isFirstResponder{
            let itemselected = self.selectedNNName2[row]
            frequencyTextField2.text = itemselected
            self.dosId5 = self.selectedNNId[row]
            self.doseNN[4] = self.selectedNNId[row]
            if self.doseTextField2.text != "" && eDoseTextField2.text != ""{
                self.currentNNProduct3Textfield.isUserInteractionEnabled = true
            }
        }else if frequencyTextField3.isFirstResponder{
            let itemselected = self.selectedNNName3[row]
            frequencyTextField3.text = itemselected
            self.dosId8 = self.selectedNNId[row]
            self.doseNN[7] = self.selectedNNId[row]
        }else if previousOtherProductTextfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityOtherProduct?[row]
            previousOtherProductTextfield.text = n?.name
            previousNNOther[0] = String(describing: n?.id ?? 0)
        }else if previousOtherProduct2TextField.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityOtherProduct?[row]
            previousOtherProduct2TextField.text = n?.name
            previousNNOther[1] = String(describing: n?.id ?? 0)
        }else if previousOtherProduct3TextField.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityOtherProduct?[row]
            previousOtherProduct3TextField.text = n?.name
            previousNNOther[2] = String(describing: n?.id ?? 0)
        }else if productNN1textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            productNN1textfield.text = n?.name
            //            productNN[0] = String(describing: n?.id ?? 0)
        }else if productNN2Textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            productNN2Textfield.text = n?.name
            //            productNN[1] = String(describing: n?.id ?? 0)
        }else if productNN3Textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            productNN3Textfield.text = n?.name
            //            productNN[2] = String(describing: n?.id ?? 0)
        }else if productConcomitant1Textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            productConcomitant1Textfield.text = n?.name
            productConcomitant[0] = String(describing: n?.id ?? 0)
        }else if productConcomitant2Textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            productConcomitant2Textfield.text = n?.name
            productConcomitant[1] = String(describing: n?.id ?? 0)
        }else if productConcomitant3Textfield.isFirstResponder{
            let n = self.dropDownInfo?.educationalActivityViewModel?.educationalActivityProduct?[row]
            productConcomitant3Textfield.text = n?.name
            productConcomitant[2] = String(describing: n?.id ?? 0)
        }
    }
    @IBAction func onPrescribtionTaken(_ sender: Any) {
        selectedTab = "1"
        PHPhotoLibrary.requestAuthorization({
            (newStatus) in
            DispatchQueue.main.async(execute: { () -> Void in
                if newStatus ==  PHAuthorizationStatus.authorized {
                    UIImagePickerController.isSourceTypeAvailable(.camera)
                    print("Button capture")
#if targetEnvironment(simulator)
                    self.imagePicker.sourceType = .photoLibrary
#else
                    self.imagePicker.sourceType = .camera
#endif
                    self.imagePicker.allowsEditing = true
                    
                    self.present(self.imagePicker, animated: true, completion: nil)
                    
                }
            })
        })
    }
    
    @IBAction func onPatientImageRequested(_ sender: Any) {
        selectedTab = "0"
        PHPhotoLibrary.requestAuthorization({
            (newStatus) in
            DispatchQueue.main.async(execute: { () -> Void in
                if newStatus ==  PHAuthorizationStatus.authorized {
                    UIImagePickerController.isSourceTypeAvailable(.camera)
                    print("Button capture")
#if targetEnvironment(simulator)
                    self.imagePicker.sourceType = .photoLibrary
#else
                    self.imagePicker.sourceType = .camera
#endif
                    self.imagePicker.allowsEditing = true
                    
                    self.present(self.imagePicker, animated: true, completion: nil)
                    
                }
            })
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if selectedTab == "0" {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                
                self.patientConstantImageView.image = image
                
                
                self.selectedImageData = image.jpegData(compressionQuality: 0.7)
                
                
                guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
                    return
                }
                
                do {
                    
                    self.fileName = "\(String(NSDate().timeIntervalSince1970)).jpg"
                    self.filePathWithName = directory.appendingPathComponent(self.fileName!)
                    try self.selectedImageData!.write(to: self.filePathWithName!)
                    
                } catch {
                    print(error.localizedDescription)
                    return
                }
            }
            
        }else {
            
            if let imagePre = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                
                
                self.prescribtionImageView.image = imagePre
                
                self.selectedImageDataPre = imagePre.jpegData(compressionQuality: 0.7)
                
                
                guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
                    return
                }
                
                do {
                    
                    self.fileNamePre = "\(String(NSDate().timeIntervalSince1970)).jpg"
                    self.filePathWithNamePre = directory.appendingPathComponent(self.fileNamePre!)
                    try self.selectedImageDataPre!.write(to: self.filePathWithNamePre!)
                    
                } catch {
                    print(error.localizedDescription)
                    return
                }
            }
        }
        
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        print("picker cancel.")
        
    }
    
    @IBAction func onSave(_ sender: Any) {
        
        CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Do you want to submit this form", controller: self, onYesClicked: {()
            self.callVisitApi()
            
        }, onNoClicked: {()
            
            return
            
        })
        
    }
    
    func callVisitApi() {
        
        
        let objective = visitObjectiveTextView.text
        let patientConseut = patientConsentTextfield.text
        let prescription = prescriptionTextfield.text
        let productNN1 = productNN1textfield.text
        let productNN2 = productNN2Textfield.text
        let productNN3 = productNN3Textfield.text
        let currentPro1 = currentNNProductTextField.text
        let doseText = doseTextField1.text
        let freqText = frequencyTextField1.text
        let eDose = eDoseTextField1.text
        let productConcomitant1 = productConcomitant1Textfield.text
        let productConcomitant2 = productConcomitant2Textfield.text
        let productConcomitant3 = productConcomitant3Textfield.text
        let previousNN1 = previousNN1Textfield.text
        let previousNN2 = previousNN2Textfield.text
        let previousOtherProduct = previousOtherProductTextfield.text
        let previousOtherProduct2 = previousOtherProduct2TextField.text
        let previousOtherProduct3 = previousOtherProduct3TextField.text
        let infoNNProduct = infoNNProductTextfield.text
        let deviceDemostration = deviceDemostrationTextfield.text
        let readingBGS = readingBGSTextfield.text
        let readingWeight = readingWeightTextfield.text
        let readingBP = readingBPTextfield.text
        let isHardCopy = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ishardCopy)
        let isExplained = CommonUtils.getJsonFromUserDefaults(forKey: Constants.isexplained)
        let drugEvent = drugEventTextField.text
        let technicalIssue = tecnicalIssueField.text
        let prvideGDM = gDMTextField.text
        let overDose = overDoseAndMisuseTextField.text
        let hospitilaization = hospitilaizationTextField.text
        let reason = reasonTextField.text
        let offLabel = offLabelTextfield.text
        let rating = self.ratingScale
        
        if patientConseut == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select the Patient Consent")
            return
        }
        if patientConseut == "Yes" {
            if self.fileName == "" {
                
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Patient Consent Image")
                return
            }
            
        }
        
        if prescription == "" {
            self.Homeprescribtion = "False"
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select the Prescription")
            return
        }
        if prescription == "Yes" {
            
            self.Homeprescribtion = "True"
            if self.fileNamePre == "" {
                
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Prescription Image")
                return
            }
            
        }
        if objective == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select Visit Objective")
            return
        }
        if currentPro1 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select Current NN Product 1")
            return
        }
        
        //        if currentNNProductTextField2.text == "" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select Current NN Product 2")
        //            return
        //        }
        //        if currentNNProduct3Textfield.text == "" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select Current NN Product 3")
        //            return
        //        }
        if doseText == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select MDose 1")
            return
        }
        //        if doseTextField2.text == "" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select MDose 2")
        //            return
        //        }
        //
        //        if doseTextField3.text == "" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select MDose 3")
        //            return
        //        }
        
        if freqText == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select ADose 1")
            return
        }
        //        if frequencyTextField2.text == "" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select ADose 2")
        //            return
        //        }
        //        if frequencyTextField2.text == "" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select ADose 3")
        //            return
        //        }
        
        if eDose == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select EDose 1")
            return
        }
        //        if eDoseTextField2.text == "" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select EDose 2")
        //            return
        //        }
        //        if eDoseTextField3.text == "" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select EDose 3")
        //            return
        //        }
        //        if productNN1 == "" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the NN Product 1")
        //            return
        //        }
        //        if productNN2 == "" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the NN Product 2")
        //            return
        //        }
        //        if productNN3 == "" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the NN Product 3")
        //            return
        //        }
        if productConcomitant1 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the Concomitant Product 1")
            return
        }
        //        if productConcomitant2 == "" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the Concomitant Product 2")
        //            return
        //        }
        //        if productConcomitant3 == "" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the Concomitant Product 3")
        //            return
        //        }
        if previousNN1 == ""  {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the Previous NN Product 1")
            return
        }
        //        if previousNN2 == ""  {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the Previous NN2 Product")
        //            return
        //        }
        if previousOtherProduct == ""  {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the PreviousOther Product")
            return
        }
        //        if previousOtherProduct2 == ""  {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the PreviousOther Product 2")
        //            return
        //        }
        //        if previousOtherProduct3 == ""  {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the PreviousOther Product 3")
        //            return
        //        }
        if infoNNProduct == ""  {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the infoNN Product")
            return
        }
        if deviceDemostration == ""  {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the Device Demostration")
            return
        }
        //        if isHardCopy == "false" && isExplained == "false" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Provide Type Of Education")
        //            return
        //        }
        if readingBGS == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the Blood Sugar Screen")
            return
        }
        if readingWeight == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter Weight Screening")
            return
        }
        if readingBP == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter Blood Pressure Screening")
            return
        }
        //        if BP2Label.text == "" {
        //            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the Reading BP")
        //            return
        //        }
        
        if infoNNProductTextfield.text == "Yes" {
            self.info = true
        }else {
            self.info = false
        }
        
        if deviceDemostrationTextfield.text == "Yes" {
            self.demo = true
        }else {
            self.demo = false
        }
        
        
        if rating == nil {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Rating Stars")
            return
        }
        
        
        
        
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        
        //        var params = Dictionary<String, Any>()
        //        params["PatientId"] = self.selectedPatient?.patientId
        //
        //        params["Lat"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        //        params["Lng"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        //        params["EmployeeUserId"] = userId
        ////        let startTym = startTime
        ////        if startTym == ""{
        ////            params["StartTime"] = 0.0
        ////        }else{
        ////            params["StartTime"] = Double(startTime ?? "")
        ////        }
        //
        //        params["EndTime"] = CommonUtils.getCurrentTime()
        //        params["ActivityObjective"] = objective
        //        params["PatinetConsent"] = patientConseut?.elementsEqual("Yes")
        //        params["ActivityType"] = "Visit"
        //        params["PatinetConsentAttachmentUrl"] = self.patientConsentUrl
        //        params["PrescriptionAvailable"] = prescription?.elementsEqual("Yes")
        //        params["PrescriptionAttachmentUrl"] = self.prescribtionUrl
        //        params["InformationAboutProductGiven"] = self.info
        //        params["DeviceDemonstrationGiven"] = self.demo
        //        params["BloodGlucose"] = readingBGS
        //        params["BloodPressure"] = readingBP
        //        params["HbA1c"] = HbA1cTextField.text
        //        params["Weight"] = readingWeight
        //        params["FeedbackStars"] = "\(rating ?? 0)"
        //        params["SafetyEventReportByPatient"] = false
        //        params["AdverseDrugEvent"] = false
        //        params["TechnicalIssue"] = false
        //        params["GDM"] = false
        //        params["OffLabel"] = false
        //        params["MedicationErrorOverdoseOrMisuse"] = false
        //        params["Hospitalization"] = false
        //        params["Discontinuation"] = false
        //
        
        var calls = CommonUtils.getJsonFromUserDefaults(forKey: Constants.HomeUploadKey)
        if calls == "" {
            calls = "[]"
        }
        
        var callsArray:[HomeActivity] = Mapper<HomeActivity>().mapArray(JSONString: calls)!
        
        var homeCurrentCall = HomeActivity(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        homeCurrentCall?.patientId =  "\(self.selectedPatient?.patientId ?? 0)"
        homeCurrentCall?.lat = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        homeCurrentCall?.HomeActivityGuid = CommonUtils.getJsonFromUserDefaults(forKey: Constants.homePatientUuid)
        homeCurrentCall?.lng = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        homeCurrentCall?.employeeUserId = userId
        //        homeCurrentCall?.endTime = "\(CommonUtils.getCurrentTime())"
        
        homeCurrentCall?.endTime = String(CommonUtils.getCurrentTime())
        
        if let endTime = homeCurrentCall?.endTime {
            if endTime.contains(".") {
                homeCurrentCall?.endTime = String(endTime.split(separator: ".")[0])
            }
        }
        
        homeCurrentCall?.activityObjective = objective
        
        let postTime = CommonUtils.getJsonFromUserDefaults(forKey: Constants.GetTime)
        
        homeCurrentCall?.startTime = postTime
        if let startTime = homeCurrentCall?.startTime {
            if startTime.contains(".") {
                homeCurrentCall?.startTime = String(startTime.split(separator: ".")[0])
            }
        }
        //                let startTym = startTime
        //                if startTym == ""{
        //                    homeCurrentCall?.startTime = "0.0"
        //                }else{
        //                    homeCurrentCall?.startTime = startTime
        //                }
        homeCurrentCall?.patinetConsent = "True"
        homeCurrentCall?.activityType = "Visit"
        homeCurrentCall?.patinetConsentAttachmentUrl = self.patientConsentUrl
        homeCurrentCall?.prescriptionAvailable = self.Homeprescribtion
        homeCurrentCall?.prescriptionAttachmentUrl = self.prescribtionUrl
        homeCurrentCall?.informationAboutProductGiven = "\(self.info)"
        homeCurrentCall?.deviceDemonstrationGiven = "\(self.demo)"
        homeCurrentCall?.bloodPressure = readingBP
        homeCurrentCall?.bloodGlucose = readingBGS
        homeCurrentCall?.hbA1c = HbA1cTextField.text
        homeCurrentCall?.weight = readingWeight
        homeCurrentCall?.feedbackStars = "\(rating ?? 2)"
        
        
        //        params["HomeActivityConcomitantProduct"] = productConcomitant.map({ id -> Dictionary<String, Any> in
        //            return ["ProductId": id]
        //        })
        
        
        homeCurrentCall?.homeActivityConcomitantProduct = []
        
        homeCurrentCall?.homeActivityConcomitantProduct!.append(HomeActivityConcomitantProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        homeCurrentCall?.homeActivityConcomitantProduct![0].productId = self.productConcomitant[0]
        
        
        let ali = productConcomitant[1]
        
        if self.productConcomitant[1] != "" {
            
            homeCurrentCall?.homeActivityConcomitantProduct!.append(HomeActivityConcomitantProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
            
            homeCurrentCall?.homeActivityConcomitantProduct![1].productId = self.productConcomitant[1]
            
        }
        
        if self.productConcomitant[2] != "" {
            
            homeCurrentCall?.homeActivityConcomitantProduct!.append(HomeActivityConcomitantProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
            
            homeCurrentCall?.homeActivityConcomitantProduct![2].productId = self.productConcomitant[2]
            
        }
        
        
        homeCurrentCall?.homeActivityCurrentProduct = []
        
        homeCurrentCall?.homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        homeCurrentCall?.homeActivityCurrentProduct![0].productId = productNN[0]
        homeCurrentCall?.homeActivityCurrentProduct![0].deviceId = self.deviceDemoId
        homeCurrentCall?.homeActivityCurrentProduct![0].dose = doseNN[0]
        homeCurrentCall?.homeActivityCurrentProduct![0].deviceDemo = true
        
        homeCurrentCall?.homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        homeCurrentCall?.homeActivityCurrentProduct![1].productId = productNN[0]
        homeCurrentCall?.homeActivityCurrentProduct![1].deviceId = self.deviceDemoId
        homeCurrentCall?.homeActivityCurrentProduct![1].dose = doseNN[1]
        homeCurrentCall?.homeActivityCurrentProduct![1].deviceDemo = true
        
        homeCurrentCall?.homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        homeCurrentCall?.homeActivityCurrentProduct![2].productId = productNN[0]
        homeCurrentCall?.homeActivityCurrentProduct![2].deviceId = self.deviceDemoId
        homeCurrentCall?.homeActivityCurrentProduct![2].dose = doseNN[2]
        homeCurrentCall?.homeActivityCurrentProduct![2].deviceDemo = true
        
        
        if self.productNN[1] != "" {
            
            
            homeCurrentCall?.homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
            
            homeCurrentCall?.homeActivityCurrentProduct![3].productId = productNN[1]
            homeCurrentCall?.homeActivityCurrentProduct![3].deviceId = self.deviceDemoId2
            homeCurrentCall?.homeActivityCurrentProduct![3].dose = doseNN[3]
            homeCurrentCall?.homeActivityCurrentProduct![3].deviceDemo = true
            
            
            homeCurrentCall?.homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
            
            homeCurrentCall?.homeActivityCurrentProduct![4].productId = productNN[1]
            homeCurrentCall?.homeActivityCurrentProduct![4].deviceId = self.deviceDemoId2
            homeCurrentCall?.homeActivityCurrentProduct![4].dose = doseNN[4]
            homeCurrentCall?.homeActivityCurrentProduct![4].deviceDemo = true
            
            homeCurrentCall?.homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
            
            homeCurrentCall?.homeActivityCurrentProduct![5].productId = productNN[1]
            homeCurrentCall?.homeActivityCurrentProduct![5].deviceId = self.deviceDemoId2
            homeCurrentCall?.homeActivityCurrentProduct![5].dose = doseNN[5]
            homeCurrentCall?.homeActivityCurrentProduct![5].deviceDemo = true
            
            
            
        }
        
        if self.productNN[2] != "" {
            
            
            homeCurrentCall?.homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
            
            homeCurrentCall?.homeActivityCurrentProduct![6].productId = productNN[2]
            homeCurrentCall?.homeActivityCurrentProduct![6].deviceId = self.deviceDemoId3
            homeCurrentCall?.homeActivityCurrentProduct![6].dose = doseNN[6]
            homeCurrentCall?.homeActivityCurrentProduct![6].deviceDemo = true
            
            homeCurrentCall?.homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
            
            homeCurrentCall?.homeActivityCurrentProduct![7].productId = productNN[2]
            homeCurrentCall?.homeActivityCurrentProduct![7].deviceId = self.deviceDemoId3
            homeCurrentCall?.homeActivityCurrentProduct![7].dose = doseNN[7]
            homeCurrentCall?.homeActivityCurrentProduct![7].deviceDemo = true
            
            homeCurrentCall?.homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
            
            homeCurrentCall?.homeActivityCurrentProduct![8].productId = productNN[2]
            homeCurrentCall?.homeActivityCurrentProduct![8].deviceId = self.deviceDemoId3
            homeCurrentCall?.homeActivityCurrentProduct![8].dose = doseNN[8]
            homeCurrentCall?.homeActivityCurrentProduct![8].deviceDemo = true
            
            
            
        }
        
        
        homeCurrentCall?.homeActivityPreviousProduct = []
        
        homeCurrentCall?.homeActivityPreviousProduct!.append(HomeActivityPreviousProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        homeCurrentCall?.homeActivityPreviousProduct![0].productId = previousNN[0]
        
        if self.previousNN[1] != "" {
            
            homeCurrentCall?.homeActivityPreviousProduct!.append(HomeActivityPreviousProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
            
            homeCurrentCall?.homeActivityPreviousProduct![1].productId = previousNN[1]
            
            
        }
        
        if self.previousNN[2] != "" {
            
            homeCurrentCall?.homeActivityPreviousProduct!.append(HomeActivityPreviousProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
            
            homeCurrentCall?.homeActivityPreviousProduct![2].productId = previousNN[2]
            
        }
        
        homeCurrentCall?.homeActivityPreviousOtherProduct = []
        
        homeCurrentCall?.homeActivityPreviousOtherProduct!.append(HomeActivityPreviousOtherProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        homeCurrentCall?.homeActivityPreviousOtherProduct![0].otherProductId = previousNNOther[0]
        
        if self.previousNNOther[1] != "" {
            
            homeCurrentCall?.homeActivityPreviousOtherProduct!.append(HomeActivityPreviousOtherProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
            
            homeCurrentCall?.homeActivityPreviousOtherProduct![1].otherProductId = previousNNOther[1]
            
            
        }
        
        if self.previousNNOther[2] != "" {
            
            homeCurrentCall?.homeActivityPreviousOtherProduct!.append(HomeActivityPreviousOtherProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
            
            homeCurrentCall?.homeActivityPreviousOtherProduct![2].otherProductId = previousNNOther[2]
            
            
        }
        
        
        homeCurrentCall?.homeActivityDiscussionTopic = []
        for i in 0..<self.selectedTopicApi.count{
            
            homeCurrentCall?.homeActivityDiscussionTopic!.append(HomeActivityDiscussionTopic(map: Map(mappingType: .fromJSON, JSON: [:]))!)
            
            homeCurrentCall?.homeActivityDiscussionTopic![i].discussionTopicId = "\( self.selectedTopicApi[i].id ?? 0)"
            homeCurrentCall?.homeActivityDiscussionTopic![i].explained = self.selectedTopicApi[i].isExplained == true ? "True" : "False"
            homeCurrentCall?.homeActivityDiscussionTopic![i].hardCopyProvided = "\(self.selectedTopicApi[i].isHardcopy ?? true)"
        }
        
        
        let ammad =  homeCurrentCall
        
        
        callsArray.append(homeCurrentCall!)
        
        let callsJson = Mapper().toJSONString(callsArray)
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.HomeUploadKey, withJson: callsJson!)
        
        
        var data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.homeImgPostData)
        if (data == "") {data = "[]"}
        
        var callImages:[HomeImageCallModel] = Mapper<HomeImageCallModel>().mapArray(JSONString: data)!
        
        var callImage = HomeImageCallModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        callImage?.Guid = CommonUtils.getJsonFromUserDefaults(forKey: Constants.homePatientUuid)
        callImage?.PatinetConsentAttachmentUrl = self.filePathWithName?.absoluteString
        callImage?.PrescriptionConsentAttachmentUrl = self.filePathWithNamePre?.absoluteString
        
        callImages.append(callImage!)
        
        let imageJsonString = Mapper().toJSONString(callImages)!
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.homeImgPostData, withJson: imageJsonString)
        
        
        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "successfully submitted", onOkClicked: {()
            self.dismiss(animated: true, completion: nil)
            
        })
        
        
        
        
        
        
        
        //        if (self.homeCurrentCall?.homeActivity == nil) { self.homeCurrentCall?.homeActivity = [] }
        //
        //        self.homeCurrentCall?.homeActivity?.append(HomeActivity(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //        let index = (homeCurrentCall?.homeActivity?.count ?? 0) - 1
        //
        //
        //
        //        homeCurrentCall?.homeActivity![index].patientId = "\(String(describing: self.selectedPatient?.patientId))"
        //        homeCurrentCall?.homeActivity![index].lat = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        //        homeCurrentCall?.homeActivity![index].lng = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        //        homeCurrentCall?.homeActivity![index].employeeUserId = userId
        //        homeCurrentCall?.homeActivity![index].endTime = "\(CommonUtils.getCurrentTime())"
        //        homeCurrentCall?.homeActivity![index].activityObjective = objective
        //
        //        let startTym = startTime
        //        if startTym == ""{
        //            homeCurrentCall?.homeActivity![index].startTime = "0.0"
        //        }else{
        //            homeCurrentCall?.homeActivity![index].startTime = startTime
        //        }
        //        homeCurrentCall?.homeActivity![index].patinetConsent = patientConseut
        //
        //        homeCurrentCall?.homeActivity![index].activityType = "Visit"
        //        homeCurrentCall?.homeActivity![index].patinetConsentAttachmentUrl = self.patientConsentUrl
        //        homeCurrentCall?.homeActivity![index].prescriptionAvailable = prescription
        //        homeCurrentCall?.homeActivity![index].prescriptionAttachmentUrl = self.prescribtionUrl
        //        homeCurrentCall?.homeActivity![index].informationAboutProductGiven = "\(self.info)"
        //        homeCurrentCall?.homeActivity![index].deviceDemonstrationGiven = "\(self.demo)"
        //        homeCurrentCall?.homeActivity![index].bloodPressure = readingBP
        //        homeCurrentCall?.homeActivity![index].hbA1c = HbA1cTextField.text
        //        homeCurrentCall?.homeActivity![index].weight = readingWeight
        //        homeCurrentCall?.homeActivity![index].feedbackStars = "\(rating)"
        //
        //
        ////        params["HomeActivityConcomitantProduct"] = productConcomitant.map({ id -> Dictionary<String, Any> in
        ////            return ["ProductId": id]
        ////        })
        //
        //
        //        self.homeCurrentCall?.homeActivity![index].homeActivityConcomitantProduct = []
        //
        //        self.homeCurrentCall?.homeActivity![index].homeActivityConcomitantProduct!.append(HomeActivityConcomitantProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //        homeCurrentCall?.homeActivity![index].homeActivityConcomitantProduct![0].productId = self.productConcomitant[0]
        //
        //
        //        let ali = productConcomitant[1]
        //
        //        if self.productConcomitant[1] != "" {
        //
        //        self.homeCurrentCall?.homeActivity![index].homeActivityConcomitantProduct!.append(HomeActivityConcomitantProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //            homeCurrentCall?.homeActivity![index].homeActivityConcomitantProduct![1].productId = self.productConcomitant[1]
        //
        //        }
        //
        //        if self.productConcomitant[2] != "" {
        //
        //        self.homeCurrentCall?.homeActivity![index].homeActivityConcomitantProduct!.append(HomeActivityConcomitantProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //            homeCurrentCall?.homeActivity![index].homeActivityConcomitantProduct![2].productId = self.productConcomitant[2]
        //
        //        }
        //
        //
        //        self.homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct = []
        //
        //        self.homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //        homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![0].productId = productNN[0]
        //        homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![0].deviceId = self.deviceDemoId
        //        homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![0].dose = doseNN[0]
        //        homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![0].deviceDemo = true
        //
        //        self.homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //        homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![1].productId = productNN[0]
        //        homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![1].deviceId = self.deviceDemoId
        //        homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![1].dose = doseNN[1]
        //        homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![1].deviceDemo = true
        //
        //        self.homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //        homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![2].productId = productNN[0]
        //        homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![2].deviceId = self.deviceDemoId
        //        homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![2].dose = doseNN[2]
        //        homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![2].deviceDemo = true
        //
        //
        //        if self.productNN[1] != "" {
        //
        //
        //            self.homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![3].productId = productNN[1]
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![3].deviceId = self.deviceDemoId2
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![3].dose = doseNN[3]
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![3].deviceDemo = true
        //
        //
        //            self.homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![4].productId = productNN[1]
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![4].deviceId = self.deviceDemoId2
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![4].dose = doseNN[4]
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![4].deviceDemo = true
        //
        //            self.homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![5].productId = productNN[1]
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![5].deviceId = self.deviceDemoId2
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![5].dose = doseNN[5]
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![5].deviceDemo = true
        //
        //
        //
        //        }
        //
        //        if self.productNN[2] != "" {
        //
        //
        //            self.homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![6].productId = productNN[2]
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![6].deviceId = self.deviceDemoId3
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![6].dose = doseNN[6]
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![6].deviceDemo = true
        //
        //            self.homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![7].productId = productNN[2]
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![7].deviceId = self.deviceDemoId3
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![7].dose = doseNN[7]
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![7].deviceDemo = true
        //
        //            self.homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct!.append(HomeActivityCurrentProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![8].productId = productNN[2]
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![8].deviceId = self.deviceDemoId3
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![8].dose = doseNN[8]
        //            homeCurrentCall?.homeActivity![index].homeActivityCurrentProduct![8].deviceDemo = true
        //
        //
        //
        //        }
        //
        //
        //        self.homeCurrentCall?.homeActivity![index].homeActivityPreviousProduct = []
        //
        //        self.homeCurrentCall?.homeActivity![index].homeActivityPreviousProduct!.append(HomeActivityPreviousProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //        homeCurrentCall?.homeActivity![index].homeActivityPreviousProduct![0].productId = previousNN[0]
        //
        //        if self.previousNN[1] != "" {
        //
        //            self.homeCurrentCall?.homeActivity![index].homeActivityPreviousProduct!.append(HomeActivityPreviousProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //            homeCurrentCall?.homeActivity![index].homeActivityPreviousProduct![1].productId = previousNN[1]
        //
        //
        //        }
        //
        //        if self.previousNN[2] != "" {
        //
        //            self.homeCurrentCall?.homeActivity![index].homeActivityPreviousProduct!.append(HomeActivityPreviousProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //            homeCurrentCall?.homeActivity![index].homeActivityPreviousProduct![2].productId = previousNN[2]
        //
        //        }
        //
        //        self.homeCurrentCall?.homeActivity![index].homeActivityPreviousOtherProduct = []
        //
        //        self.homeCurrentCall?.homeActivity![index].homeActivityPreviousOtherProduct!.append(HomeActivityPreviousOtherProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //        homeCurrentCall?.homeActivity![index].homeActivityPreviousOtherProduct![0].otherProductId = previousNNOther[0]
        //
        //        if self.previousNNOther[1] != "" {
        //
        //            self.homeCurrentCall?.homeActivity![index].homeActivityPreviousOtherProduct!.append(HomeActivityPreviousOtherProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //            homeCurrentCall?.homeActivity![index].homeActivityPreviousOtherProduct![1].otherProductId = previousNNOther[1]
        //
        //
        //        }
        //
        //        if self.previousNNOther[2] != "" {
        //
        //            self.homeCurrentCall?.homeActivity![index].homeActivityPreviousOtherProduct!.append(HomeActivityPreviousOtherProduct(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //
        //            homeCurrentCall?.homeActivity![index].homeActivityPreviousOtherProduct![2].otherProductId = previousNNOther[2]
        //
        //
        //        }
        //
        //
        //        self.homeCurrentCall?.homeActivity![index].homeActivityDiscussionTopic = []
        //        for i in 0..<self.selectedTopicApi.count{
        //
        //            self.homeCurrentCall?.homeActivity![index].homeActivityDiscussionTopic!.append(HomeActivityDiscussionTopic(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        //    //
        //            homeCurrentCall?.homeActivity![index].homeActivityDiscussionTopic![i].discussionTopicId = "\(String(describing: self.selectedTopicApi[i].id))"
        //            homeCurrentCall?.homeActivity![index].homeActivityDiscussionTopic![i].explained = "\(self.selectedTopicApi[i].isExplained)"
        //            homeCurrentCall?.homeActivity![index].homeActivityDiscussionTopic![i].hardCopyProvided = "\(self.selectedTopicApi[i].isHardcopy)"
        //        }
        
        
        
        
        
        
        
        
        //        var HomeActivityDiscussionTopic: [Dictionary<String, Any>] = []
        //        for (_, value) in self.homeActivityDiscussionTopic {
        //            HomeActivityDiscussionTopic.append(value as! Dictionary<String, Any>)
        //        }
        //
        //        params["HomeActivityDiscussionTopic"] = HomeActivityDiscussionTopic
        //
        //        var HomeActivity: [Dictionary<String, Any>] = []
        //        HomeActivity.append(params)
        //
        //        Alamofire.request(Constants.SyncHomeActivity, method: .post, parameters: ["HomeActivity": HomeActivity], encoding: JSONEncoding.default, headers: nil)
        //            .responseString(completionHandler: {(response) in
        //                // On Response
        //                self.activitiyViewController.dismiss(animated: true, completion: {() in
        //
        //                    //On Dialog Close
        //                    if (response.error != nil) {
        //                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
        //                        return
        //                    }
        //
        //                    if (response.value == "1") {
        //
        //                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.isexplained, withJson: "false")
        //                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ishardCopy, withJson: "false")
        //
        //                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.LastTimeOfUpload, withJson: String(CommonUtils.getCurrentTime()))
        //
        //
        //                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.CallToUploadKey, withJson: "[]")
        //                        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Form Sumit Successfully", onOkClicked: {()in
        //                            self.dismiss(animated: false, completion: {
        //                                self.dismiss(animated: true, completion: nil)
        //                            })
        //                        })
        //                    } else {
        //                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: response.value!)
        //                    }
        //                })
        //            })
    }
    
    
    func callVisit() {
        
        
        let objective = visitObjectiveTextView.text
        let patientConseut = patientConsentTextfield.text
        let prescription = prescriptionTextfield.text
        let productNN1 = productNN1textfield.text
        let productNN2 = productNN2Textfield.text
        let productNN3 = productNN3Textfield.text
        let productConcomitant1 = productConcomitant1Textfield.text
        let productConcomitant2 = productConcomitant2Textfield.text
        let productConcomitant3 = productConcomitant3Textfield.text
        let previousNN1 = previousNN1Textfield.text
        let previousNN2 = previousNN2Textfield.text
        let previousOtherProduct = previousOtherProductTextfield.text
        let infoNNProduct = infoNNProductTextfield.text
        let deviceDemostration = deviceDemostrationTextfield.text
        let readingBGS = readingBGSTextfield.text
        let readingWeight = readingWeightTextfield.text
        let readingBP = readingBPTextfield.text
        let isHardCopy = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ishardCopy)
        let isExplained = CommonUtils.getJsonFromUserDefaults(forKey: Constants.isexplained)
        let drugEvent = drugEventTextField.text
        let technicalIssue = tecnicalIssueField.text
        let prvideGDM = gDMTextField.text
        let overDose = overDoseAndMisuseTextField.text
        let hospitilaization = hospitilaizationTextField.text
        let reason = reasonTextField.text
        let offLabel = offLabelTextfield.text
        
        
        if patientConseut == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Select the Patient Consent")
            return
        }
        
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        
        var calls = CommonUtils.getJsonFromUserDefaults(forKey: Constants.HomeUploadKey)
        if calls == "" {
            calls = "[]"
        }
        
        var callsArray:[HomeActivity] = Mapper<HomeActivity>().mapArray(JSONString: calls)!
        
        var homeCurrentCall = HomeActivity(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        homeCurrentCall?.patientId =  "\(self.selectedPatient?.patientId ?? 0)"
        homeCurrentCall?.lat = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        homeCurrentCall?.HomeActivityGuid = CommonUtils.getJsonFromUserDefaults(forKey: Constants.homePatientUuid)
        homeCurrentCall?.lng = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        homeCurrentCall?.employeeUserId = userId
        //        homeCurrentCall?.endTime = "\(CommonUtils.getCurrentTime())"
        
        homeCurrentCall?.endTime = String(CommonUtils.getCurrentTime())
        
        if let endTime = homeCurrentCall?.endTime {
            if endTime.contains(".") {
                homeCurrentCall?.endTime = String(endTime.split(separator: ".")[0])
            }
        }
        
        homeCurrentCall?.activityObjective = ""
        
        let formTime = CommonUtils.getJsonFromUserDefaults(forKey: Constants.GetTime)
        
        homeCurrentCall?.startTime = formTime
        if let startTime = homeCurrentCall?.startTime {
            if startTime.contains(".") {
                homeCurrentCall?.startTime = String(startTime.split(separator: ".")[0])
            }
        }
        //                let startTym = startTime
        //                if startTym == ""{
        //                    homeCurrentCall?.startTime = "0.0"
        //                }else{
        //                    homeCurrentCall?.startTime = startTime
        //                }
        homeCurrentCall?.patinetConsent = "False"
        
        homeCurrentCall?.activityType = "Visit"
        homeCurrentCall?.patinetConsentAttachmentUrl = ""
        homeCurrentCall?.prescriptionAvailable = ""
        homeCurrentCall?.prescriptionAttachmentUrl = ""
        homeCurrentCall?.informationAboutProductGiven = ""
        homeCurrentCall?.deviceDemonstrationGiven = ""
        homeCurrentCall?.bloodPressure = ""
        homeCurrentCall?.hbA1c = ""
        homeCurrentCall?.weight = ""
        homeCurrentCall?.feedbackStars = ""
        
        
        //        params["HomeActivityConcomitantProduct"] = productConcomitant.map({ id -> Dictionary<String, Any> in
        //            return ["ProductId": id]
        //        })
        
        
        homeCurrentCall?.homeActivityConcomitantProduct = []
        
        
        
        
        homeCurrentCall?.homeActivityCurrentProduct = []
        
        
        
        
        homeCurrentCall?.homeActivityPreviousProduct = []
        
        
        
        homeCurrentCall?.homeActivityPreviousOtherProduct = []
        
        
        
        homeCurrentCall?.homeActivityDiscussionTopic = []
        
        
        let ammad =  homeCurrentCall
        
        
        callsArray.append(homeCurrentCall!)
        
        let callsJson = Mapper().toJSONString(callsArray)
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.HomeUploadKey, withJson: callsJson!)
        
        
        
        var data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.homeImgPostData)
        if (data == "") {data = "[]"}
        
        var callImages:[HomeImageCallModel] = Mapper<HomeImageCallModel>().mapArray(JSONString: data)!
        
        var callImage = HomeImageCallModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        callImage?.Guid = CommonUtils.getJsonFromUserDefaults(forKey: Constants.homePatientUuid)
        callImage?.PatinetConsentAttachmentUrl = self.filePathWithName?.absoluteString
        callImage?.PrescriptionConsentAttachmentUrl = self.filePathWithNamePre?.absoluteString
        
        callImages.append(callImage!)
        
        let imageJsonString = Mapper().toJSONString(callImages)!
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.homeImgPostData, withJson: imageJsonString)
        
        
        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "successfully submitted", onOkClicked: {()
            self.dismiss(animated: true, completion: nil)
            
        })
        
        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Form Submit Successfully", onOkClicked: {()
            
            
            self.dismiss(animated: true, completion: nil)
            
        })
        
        
        
        
        
        //        activitiyViewController.show(existingUiViewController: self)
        //
        //        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        //
        //        var params = Dictionary<String, Any>()
        //        params["PatientId"] = self.selectedPatient?.patientId
        //
        //        params["Lat"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        //        params["Lng"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        //        params["EmployeeUserId"] = userId
        //        let startTym = startTime
        //        if startTym == ""{
        //            params["StartTime"] = 0.0
        //        }else{
        //            params["StartTime"] = Double(startTime ?? "")
        //        }
        //
        //        params["EndTime"] = CommonUtils.getCurrentTime()
        //        params["ActivityObjective"] = nil
        //        params["PatinetConsent"] = "No"
        //        params["ActivityType"] = "Visit"
        //        params["PatinetConsentAttachmentUrl"] = nil
        //        params["PrescriptionAvailable"] = prescription?.elementsEqual("No")
        //        params["PrescriptionAttachmentUrl"] = nil
        //        params["InformationAboutProductGiven"] = ""
        //        params["DeviceDemonstrationGiven"] = ""
        //        params["BloodGlucose"] = ""
        //        params["BloodPressure"] = ""
        //        params["Weight"] = ""
        //        params["FeedbackStars"] = "5"
        //        params["SafetyEventReportByPatient"] = false
        //        params["AdverseDrugEvent"] = false
        //        params["TechnicalIssue"] = false
        //        params["GDM"] = false
        //        params["OffLabel"] = false
        //        params["MedicationErrorOverdoseOrMisuse"] = false
        //        params["Hospitalization"] = false
        //
        //        params["HomeActivityConcomitantProduct"] = []
        //        params["HomeActivityCurrentProduct"] = []
        //        params["HomeActivityPreviousProduct"] = []
        //        params["HomeActivityPreviousOtherProduct"] = []
        //        params["HomeActivityDiscussionTopic"] = []
        //
        //        var HomeActivity: [Dictionary<String, Any>] = []
        //        HomeActivity.append(params)
        //
        //        Alamofire.request(Constants.SyncHomeActivity, method: .post, parameters: ["HomeActivity": HomeActivity], encoding: JSONEncoding.default, headers: nil)
        //            .responseString(completionHandler: {(response) in
        //                // On Response
        //                self.activitiyViewController.dismiss(animated: true, completion: {() in
        //
        //                    //On Dialog Close
        //                    if (response.error != nil) {
        //                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
        //                        return
        //                    }
        //
        //                    if (response.value == "1") {
        //
        //                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.isexplained, withJson: "false")
        //                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ishardCopy, withJson: "false")
        //
        //                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.LastTimeOfUpload, withJson: String(CommonUtils.getCurrentTime()))
        //
        //
        //                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.CallToUploadKey, withJson: "[]")
        //
        //                        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Form Sumit Successfully", onOkClicked: {()in
        //                            self.dismiss(animated: false, completion: {
        //                                self.dismiss(animated: true, completion: nil)
        //                            })
        //                        })
        //
        //
        //                    } else {
        //                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: response.value!)
        //                    }
        //                })
        //            })
        
    }
    
    @IBAction func onSaveClicked(_ sender: Any) {
        
        CommonUtils.showQuesBoxWithButtons(title: "Warning", message: "Do you want to submit this form", controller: self, onYesClicked: {()
            self.callVisit()
            
        }, onNoClicked: {()
            
            return
            
        })
        
    }
    @IBAction func onBackClick(_ sender: Any) {
        
        CommonUtils.showQuesBoxWithButtons(title: "Warning", message: "Do you want to end this Visit", controller: self, onYesClicked: {()
            self.dismiss(animated: true, completion: nil)
            
        }, onNoClicked: {()
            
            return
            
        })
        
    }
}
//
//extension VisitViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    func loadImagePicker()  {
//        imagePicker =  UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.allowsEditing = true
//#if targetEnvironment(simulator)
//        imagePicker.sourceType = .photoLibrary
//#else
//        imagePicker.sourceType = .camera
//#endif
//    }
//    
//    //MARK: - Add image to Library
//    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        if let error = error {
//            // we got back an error!
//            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            present(ac, animated: true)
//        }
//    }
//    
//    func showImagePicker() {
//        present(imagePicker, animated: true, completion: nil)
//    }
//    
//    //MARK: - Done image capture here
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        imagePicker.dismiss(animated: true, completion: {
//            let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//            if (self.imagePickerRequestFor == "PatientImage") {
//                self.patientConstantImageView.image = image
//            } else {
//                self.prescribtionImageView.image = image
//            }
//            self.uploadImage(image: image)
//        })
//    }
//    
//    func uploadImage(image: UIImage?) {
//        activitiyViewController.show(existingUiViewController: self)
//        
//        let imageData = image!.jpegData(compressionQuality: 0.2)!
//        Alamofire.upload(multipartFormData: { (form) in
//            let uuid = UUID().uuidString
//            form.append(imageData, withName: "file", fileName: "\(uuid).jpg", mimeType: "image/jpg")
//        }, to: Constants.FileUploadApi, encodingCompletion: { result in
//            switch result {
//            case .success(let upload, _, _):
//                upload.responseString { response in
//                    self.activitiyViewController.dismiss()
//                    if (response.error != nil) {
//                        return
//                    }
//                    //On Dialog Close
//                    let imageUploadModel = Mapper<ImageUploadModel>().map(JSONString: response.value!) //JSON to model
//                    if (imageUploadModel?.success!)! && (imageUploadModel?.result!.count)! > 0 {
//                        if (self.imagePickerRequestFor == "PatientImage") {
//                            self.patientConsentUrl = imageUploadModel?.result![0]
//                        } else {
//                            self.prescribtionUrl = imageUploadModel?.result![0]
//                        }
//                    } else {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "The Internet connection appers to be offline.")
//                    }
//                }
//            case .failure(let encodingError):
//                print(encodingError)
//            }
//        })
//        
//    }
//}
