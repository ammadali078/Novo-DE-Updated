//
//  AddPatientViewController.swift
//  E-detailer
//
//  Created by Macbook Air on 07/10/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import BEMCheckBox
import Photos
import Cosmos

class AddPatientViewController: UIViewController,BEMCheckBoxDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var namefeild: UITextField!
    @IBOutlet weak var contactNumTextField: UITextField!
    @IBOutlet weak var contactNum2TextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!
    @IBOutlet weak var iNovoIdTextField: UITextField!
    @IBOutlet weak var educationProvideLayOut: UIView!
    @IBOutlet weak var educationProvideCollectionView: UICollectionView!
    @IBOutlet weak var typePatientTextField: UITextField!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var CurrentNNProTextField: UITextField!
    @IBOutlet weak var CurrentNNProTextField2: UITextField!
    @IBOutlet weak var CurrentNNPro3TextField: UITextField!
    @IBOutlet weak var deviceDemoTextField: UITextField!
    @IBOutlet weak var deviceDemo2TextFeild: UITextField!
    @IBOutlet weak var deviceDemoTextFeild3: UITextField!
    @IBOutlet weak var concomitantNNproTextFeild: UITextField!
    @IBOutlet weak var concomitantNNPro2TextFeild: UITextField!
    @IBOutlet weak var concomitantNNPro3TextFeild: UITextField!
    @IBOutlet weak var previousNNProTextfeild: UITextField!
    @IBOutlet weak var previousNNPro2Textfeild: UITextField!
    @IBOutlet weak var previousNNPro3Textfeild: UITextField!
    @IBOutlet weak var concomitantOtherproTextFeild: UITextField!
    @IBOutlet weak var concomitantOther2proTextFeild: UITextField!
    @IBOutlet weak var concomitantOther3proTextFeild: UITextField!
    @IBOutlet weak var othersProductTextField: UITextField!
    @IBOutlet weak var otherProduct2TextField: UITextField!
    @IBOutlet weak var otherProduct3textField: UITextField!
    @IBOutlet weak var previousOtherProTextfeild: UITextField!
    @IBOutlet weak var previousOtherPro2Textfeild: UITextField!
    @IBOutlet weak var previousOtherPro3Textfeild: UITextField!
    @IBOutlet weak var BGSreadingTextField: UITextField!
    @IBOutlet weak var BPreadingTextField: UITextField!
    @IBOutlet weak var weightReadingTextField: UITextField!
    @IBOutlet weak var doseTextField1: UITextField!
    @IBOutlet weak var doseTextField2: UITextField!
    @IBOutlet weak var doseTextField3: UITextField!
    @IBOutlet weak var saveBtnOutlet: UIButton!
    @IBOutlet weak var attachmentTextField: UITextField!
    @IBOutlet weak var viewImageOutlet: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var frequencyTextField1: UITextField!
    @IBOutlet weak var frequencyTextField2: UITextField!
    @IBOutlet weak var frequencyTextField3: UITextField!
    @IBOutlet weak var whiteViewOutlet: UIView!
    @IBOutlet weak var safetyEventYexyField: UITextField!
    @IBOutlet weak var safetyEventView: UIView!
    @IBOutlet weak var drugEventTextfield: UITextField!
    @IBOutlet weak var technicalIssuetextField: UITextField!
    @IBOutlet weak var gdmTextfield: UITextField!
    @IBOutlet weak var hospitalizationTextField: UITextField!
    @IBOutlet weak var discontinuationTextField: UITextField!
    @IBOutlet weak var offLabelTextField: UITextField!
    @IBOutlet weak var overDoseTextField: UITextField!
    @IBOutlet weak var Hba1cLabel: UITextField!
    @IBOutlet weak var eDoseTextField: UITextField!
    @IBOutlet weak var eDoseTextField2: UITextField!
    @IBOutlet weak var eDoseTextField3: UITextField!
    @IBOutlet weak var cosmosFullView: CosmosView!
    
    var patientResult : PatientResult?
    var selectedImageData: Data?
    var productNN: [Int] = [0 , 0 , 0]
    var educationProvideDataSource: EducationProvideCell!
    var imagePicker = UIImagePickerController()
    var filePathWithName: URL?
    var patientConsentUrl: String? = ""
    var fileName: String? = ""
    var currentNNId: Int?
    var ratingScale:Int?
    var currentNNId2: Int?
    var currentNNId3: Int?
    var freqId: Int?
    var Count = "0"
    var Count2 = "0"
    var concomitantOtherproId: Int?
    var concomitantOtherproId2: Int?
    var concomitantOtherproId3: Int?
    var dosId: Int?
    var dosId2: Int?
    var dosId3: Int?
    var dosId4: Int?
    var dosId5: Int?
    var dosId6: Int?
    var dosId7: Int?
    var dosId8: Int?
    var dosId9: Int?
    var previousNNId: Int?
    var previousNNId2: Int?
    var previousNNId3: Int?
    var previousOtherId: Int?
    var previousOtherId2: Int?
    var previousOtherId3: Int?
    var othersProduct: Int?
    var othersProduct2: Int?
    var othersProduct3: Int?
    var concomitantProId: Int?
    var concomitantProId2: Int?
    var concomitantProId3: Int?
    var deviceDemoId: Int?
    var deviceDemoId2: Int?
    var deviceDemoId3: Int?
    var emtyArray: [Int] = [];
    var emtyArray2: [Bool] = [];
    var emtyArray3: [Bool] = [];
    var PatientType = ["New", "Repeat"]
    var Attachment = ["Yes", "No"]
    var freq = ["1", "2", "3", "4", "5"]
    var educational: [EducationalActivityDiscussionTopic] = [];
    var selectedNNId: [Int] = [];
    var selectedNNName: [String] = [];
    var selectedNNName2: [String] = [];
    var selectedNNName3: [String] = [];
    var selectedTopic : EducationalActivityDiscussionTopic?
    var selectedTopicApi : [EducationalActivityDiscussionTopic] = [];
    weak var pickerView: UIPickerView?
    var currentCall: CallModel? = nil
    var onPatientAdded: ((CallModel?) -> Void)? = nil
    var maxLength : Int?
    var groupbx:BEMCheckBoxGroup!
    var safetyEvent: Bool?
    var drugEvent: Bool?
    var technicalIssueEvent: Bool?
    var GDMEvent: Bool?
    var discontinuationEvent: Bool?
    var hospitalizationEvent: Bool?
    var offLabelEvent: Bool?
    var overDoseEvent: Bool?
    var device: Bool?
    var device2: Bool?
    var imagePickerRequestFor: String? = ""
    var activitiyViewController: ActivityViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Uuid = UUID().uuidString
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.patientUuid, withJson: Uuid)
        
        cosmosFullView.didTouchCosmos = {rating in
            self.ratingScale = Int(rating)
        }
        
        self.doseTextField1.isUserInteractionEnabled = false
        self.doseTextField2.isUserInteractionEnabled = false
        self.doseTextField3.isUserInteractionEnabled = false
        
        self.CurrentNNProTextField2.isUserInteractionEnabled = false
        self.CurrentNNPro3TextField.isUserInteractionEnabled = false
        
        self.deviceDemo2TextFeild.isUserInteractionEnabled = false
        self.deviceDemoTextFeild3.isUserInteractionEnabled = false
        
        
        
        self.previousOtherPro2Textfeild.isUserInteractionEnabled = false
        self.previousOtherPro3Textfeild.isUserInteractionEnabled = false
        
       
        
        self.concomitantOther2proTextFeild.isUserInteractionEnabled = false
        self.concomitantOther3proTextFeild.isUserInteractionEnabled = false
        
        
        
        self.otherProduct2TextField.isUserInteractionEnabled = false
        self.otherProduct3textField.isUserInteractionEnabled = false
        
        self.previousNNPro2Textfeild.isUserInteractionEnabled = false
        self.previousNNPro3Textfeild.isUserInteractionEnabled = false
        
        
        self.concomitantNNPro2TextFeild.isUserInteractionEnabled = false
        self.concomitantNNPro3TextFeild.isUserInteractionEnabled = false
        
        self.eDoseTextField.isUserInteractionEnabled = false
        self.eDoseTextField2.isUserInteractionEnabled = false
        self.eDoseTextField3.isUserInteractionEnabled = false
        
        self.frequencyTextField1.isUserInteractionEnabled = false
        self.frequencyTextField2.isUserInteractionEnabled = false
        self.frequencyTextField3.isUserInteractionEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarddisAppear), name: UIResponder.keyboardWillHideNotification, object: nil)
        educationProvideDataSource = EducationProvideCell()
        
        self.scrollView.isScrollEnabled = false
        
        safetyEventView.isHidden = true
//        loadImagePicker()
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
            

            CommonUtils.saveJsonToUserDefaults(forKey: Constants.ishardselect, withJson: String(isHardCopySelected))
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.isexplainedselect, withJson: String(isExplainedSelected))

        }
        activitiyViewController = ActivityViewController(message: "Loading...")
        
        
        weightReadingTextField.delegate = self
        BGSreadingTextField.delegate = self
        BPreadingTextField.delegate = self
        Hba1cLabel.delegate = self
        //self.selectedPlan = planner
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        saveBtnOutlet.layer.cornerRadius = 10.0
        
        educationProvideCollectionView.dataSource = educationProvideDataSource
        imagePicker.delegate = self
        //UIPICKER
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        CurrentNNProTextField.delegate = self
        CurrentNNProTextField2.delegate = self
        CurrentNNPro3TextField.delegate = self
        frequencyTextField1.delegate = self
        frequencyTextField2.delegate = self
        frequencyTextField3.delegate = self
        cityTextField.delegate = self
        doseTextField1.delegate = self
        doseTextField2.delegate = self
        doseTextField3.delegate = self
        eDoseTextField.delegate = self
        eDoseTextField2.delegate = self
        eDoseTextField3.delegate = self
        
        typePatientTextField.delegate = self
        
        attachmentTextField.delegate = self
        
        safetyEventYexyField.delegate = self
        drugEventTextfield.delegate = self
        technicalIssuetextField.delegate = self
        gdmTextfield.delegate = self
        hospitalizationTextField.delegate = self
        discontinuationTextField.delegate = self
        offLabelTextField.delegate = self
        overDoseTextField.delegate = self
        contactNumTextField.delegate = self
        contactNum2TextField.delegate = self
        cityTextField.delegate = self
        addressTextField.delegate = self
        address2TextField.delegate = self
        iNovoIdTextField.delegate = self
        
        concomitantNNproTextFeild.delegate = self
        concomitantNNPro2TextFeild.delegate = self
        concomitantNNPro3TextFeild.delegate = self
        
        previousNNProTextfeild.delegate = self
        previousNNPro2Textfeild.delegate = self
        previousNNPro3Textfeild.delegate = self
        
        concomitantOtherproTextFeild.delegate = self
        concomitantOther2proTextFeild.delegate = self
        concomitantOther3proTextFeild.delegate = self
        
        previousOtherProTextfeild.delegate = self
        previousOtherPro2Textfeild.delegate = self
        previousOtherPro3Textfeild.delegate = self
        
        othersProductTextField.delegate = self
        otherProduct2TextField.delegate = self
        otherProduct3textField.delegate = self
        
        deviceDemoTextField.delegate = self
        deviceDemo2TextFeild.delegate = self
        deviceDemoTextFeild3.delegate = self
        
        CurrentNNProTextField.inputView = pickerView
        CurrentNNProTextField2.inputView = pickerView
        CurrentNNPro3TextField.inputView = pickerView
        
        typePatientTextField.inputView = pickerView
        attachmentTextField.inputView = pickerView
        safetyEventYexyField.inputView = pickerView
        frequencyTextField1.inputView = pickerView
        frequencyTextField2.inputView = pickerView
        frequencyTextField3.inputView = pickerView
        cityTextField.inputView = pickerView
        
        doseTextField1.inputView = pickerView
        doseTextField2.inputView = pickerView
        doseTextField3.inputView = pickerView
        
        eDoseTextField.inputView = pickerView
        eDoseTextField2.inputView = pickerView
        eDoseTextField3.inputView = pickerView
        
        drugEventTextfield.inputView = pickerView
        technicalIssuetextField.inputView = pickerView
        gdmTextfield.inputView = pickerView
        hospitalizationTextField.inputView = pickerView
        discontinuationTextField.inputView = pickerView
        offLabelTextField.inputView = pickerView
        overDoseTextField.inputView = pickerView
        
        concomitantNNproTextFeild.inputView = pickerView
        concomitantNNPro2TextFeild.inputView = pickerView
        concomitantNNPro3TextFeild.inputView = pickerView
        
        previousNNProTextfeild.inputView = pickerView
        previousNNPro2Textfeild.inputView = pickerView
        previousNNPro3Textfeild.inputView = pickerView
        
        concomitantOtherproTextFeild.inputView = pickerView
        concomitantOther2proTextFeild.inputView = pickerView
        concomitantOther3proTextFeild.inputView = pickerView
        
        previousOtherProTextfeild.inputView = pickerView
        previousOtherPro2Textfeild.inputView = pickerView
        previousOtherPro3Textfeild.inputView = pickerView
        
        othersProductTextField.inputView = pickerView
        otherProduct2TextField.inputView = pickerView
        otherProduct3textField.inputView = pickerView
        
        deviceDemoTextField.inputView = pickerView
        deviceDemo2TextFeild.inputView = pickerView
        deviceDemoTextFeild3.inputView = pickerView
        
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
        
        CurrentNNProTextField.inputAccessoryView = toolBar
        CurrentNNProTextField2.inputAccessoryView = toolBar
        CurrentNNPro3TextField.inputAccessoryView = toolBar
        
        safetyEventYexyField.inputAccessoryView = toolBar
        drugEventTextfield.inputAccessoryView = toolBar
        technicalIssuetextField.inputAccessoryView = toolBar
        gdmTextfield.inputAccessoryView = toolBar
        hospitalizationTextField.inputAccessoryView = toolBar
        discontinuationTextField.inputAccessoryView = toolBar
        offLabelTextField.inputAccessoryView = toolBar
        overDoseTextField.inputAccessoryView = toolBar
        
        concomitantNNproTextFeild.inputAccessoryView = toolBar
        concomitantNNPro2TextFeild.inputAccessoryView = toolBar
        concomitantNNPro3TextFeild.inputAccessoryView = toolBar
        
        previousNNProTextfeild.inputAccessoryView = toolBar
        previousNNPro2Textfeild.inputAccessoryView = toolBar
        previousNNPro3Textfeild.inputAccessoryView = toolBar
        
        concomitantOtherproTextFeild.inputAccessoryView = toolBar
        concomitantOther2proTextFeild.inputAccessoryView = toolBar
        concomitantOther3proTextFeild.inputAccessoryView = toolBar
        
        previousOtherProTextfeild.inputAccessoryView = toolBar
        previousOtherPro2Textfeild.inputAccessoryView = toolBar
        previousOtherPro3Textfeild.inputAccessoryView = toolBar
        
        othersProductTextField.inputAccessoryView = toolBar
        otherProduct2TextField.inputAccessoryView = toolBar
        otherProduct3textField.inputAccessoryView = toolBar
        
        deviceDemoTextField.inputAccessoryView = toolBar
        deviceDemo2TextFeild.inputAccessoryView = toolBar
        deviceDemoTextFeild3.inputAccessoryView = toolBar
        
        typePatientTextField.inputAccessoryView = toolBar
        attachmentTextField.inputAccessoryView = toolBar
        frequencyTextField1.inputAccessoryView = toolBar
        frequencyTextField2.inputAccessoryView = toolBar
        frequencyTextField3.inputAccessoryView = toolBar
        cityTextField.inputAccessoryView = toolBar
        
        doseTextField1.inputAccessoryView = toolBar
        doseTextField2.inputAccessoryView = toolBar
        doseTextField3.inputAccessoryView = toolBar
        
        eDoseTextField.inputAccessoryView = toolBar
        eDoseTextField2.inputAccessoryView = toolBar
        eDoseTextField3.inputAccessoryView = toolBar
        
        //It is important that goes after de inputView assignation
        self.pickerView = pickerView
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
                    self.patientResult = getPatientDataModelCopy?.result

                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (getPatientDataModel?.error!)!)
                }
            } else {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
            }
        })
        
        
        let ammad = self.patientResult
            
        if ammad != nil {
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.key, withJson: "1")
            self.educationProvideDataSource.setItems(items: patientResult?.educationalActivityViewModel?.educationalActivityDiscussionTopic)
            self.educationProvideCollectionView.reloadData()
        }else {
            return
        }
        
       
        
    }
    
    var isExpand : Bool = false
    
    @objc func keyboardAppear() {
        if !isExpand {
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 4300 )
            isExpand = true
        }
        
    }
    
//    func callProductApi() {
//        activitiyViewController.show(existingUiViewController: self)
//        let callApi = CallApi()
//        callApi.getAllPatient(url: Constants.GetPatientDataApi, completionHandler: {(getPatientDataModel: GetPatientDataModel?, error: String?) in
//            self.activitiyViewController.dismiss(animated: false, completion: {
//            if (error != nil) {
//                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: error!)
//                return
//            }
//            // On Response
//
//            //temp variable
//            let getPatientDataModelCopy =  getPatientDataModel
//
//            //On Dialog Close
//            if getPatientDataModelCopy != nil {
//
//                if (getPatientDataModelCopy?.success)! {
//
//                    self.educationProvideDataSource.setItems(items: getPatientDataModelCopy?.result?.educationalActivityViewModel?.educationalActivityDiscussionTopic)
//                    self.educationProvideCollectionView.reloadData()
//                    self.patientResult = getPatientDataModelCopy?.result
//
//                } else {
//                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (getPatientDataModel?.error!)!)
//                }
//            } else {
//                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
//            }
//            })
//        })
//
//    }
    
    @objc func keyboarddisAppear() {
        
        if !isExpand {
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 4300 )
            isExpand = false
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == namefeild{
            maxLength = 25
        }else if textField == cityTextField{
            maxLength = 25
        }else if textField == addressTextField{
            maxLength = 150
        }else if textField == address2TextField{
            maxLength = 150
        }else if textField == weightReadingTextField{
            maxLength = 8
        }else if textField == iNovoIdTextField{
            maxLength = 50
        }else if textField == BGSreadingTextField{
            maxLength = 8
        } else if textField == BPreadingTextField{
            maxLength = 8
        }else if textField == Hba1cLabel{
            maxLength = 8
        }else if textField == contactNumTextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }else  if textField == contactNum2TextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        //        else if textField == contactNumTextField{
        //            maxLength = 25
        //        }
        
        let currentString: NSString = textField.text! as NSString
        
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength ?? 0
        
    }
    
    @IBAction func onPictureClicked(_ sender: Any) {
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
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            self.imageViewOutlet.image = image
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
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        print("picker cancel.")
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
    }
    
    @objc func donePicker(){
        self.CurrentNNProTextField.resignFirstResponder()
        self.CurrentNNProTextField2.resignFirstResponder()
        self.CurrentNNPro3TextField.resignFirstResponder()
        
        self.concomitantNNproTextFeild.resignFirstResponder()
        self.concomitantNNPro2TextFeild.resignFirstResponder()
        self.concomitantNNPro3TextFeild.resignFirstResponder()
        
        self.previousNNProTextfeild.resignFirstResponder()
        self.previousNNPro2Textfeild.resignFirstResponder()
        self.previousNNPro3Textfeild.resignFirstResponder()
        
        self.safetyEventYexyField.resignFirstResponder()
        self.drugEventTextfield.resignFirstResponder()
        self.technicalIssuetextField.resignFirstResponder()
        self.gdmTextfield.resignFirstResponder()
        self.hospitalizationTextField.resignFirstResponder()
        self.discontinuationTextField.resignFirstResponder()
        self.offLabelTextField.resignFirstResponder()
        self.overDoseTextField.resignFirstResponder()
        
        self.concomitantOtherproTextFeild.resignFirstResponder()
        self.concomitantOther2proTextFeild.resignFirstResponder()
        self.concomitantOther3proTextFeild.resignFirstResponder()
        
        self.previousOtherProTextfeild.resignFirstResponder()
        self.previousOtherPro2Textfeild.resignFirstResponder()
        self.previousOtherPro3Textfeild.resignFirstResponder()
        
        self.othersProductTextField.resignFirstResponder()
        self.otherProduct2TextField.resignFirstResponder()
        self.otherProduct3textField.resignFirstResponder()
        
        self.deviceDemoTextField.resignFirstResponder()
        self.deviceDemo2TextFeild.resignFirstResponder()
        self.deviceDemoTextFeild3.resignFirstResponder()
        
        self.typePatientTextField.resignFirstResponder()
        self.attachmentTextField.resignFirstResponder()
        self.frequencyTextField1.resignFirstResponder()
        self.cityTextField.resignFirstResponder()
        self.frequencyTextField2.resignFirstResponder()
        self.frequencyTextField3.resignFirstResponder()
        
        self.doseTextField1.resignFirstResponder()
        self.doseTextField2.resignFirstResponder()
        self.doseTextField3.resignFirstResponder()
        
        self.eDoseTextField.resignFirstResponder()
        self.eDoseTextField2.resignFirstResponder()
        self.eDoseTextField3.resignFirstResponder()
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if CurrentNNProTextField.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count ?? 0)!
        }else if CurrentNNProTextField2.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count ?? 0)!
        }else if CurrentNNPro3TextField.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count ?? 0)!
        }
        else if concomitantNNproTextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count ?? 0)!
        }
        else if concomitantNNPro2TextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count ?? 0)!
        }
        else if concomitantNNPro3TextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count ?? 0)!
        }else if previousNNProTextfeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count ?? 0)!
        }
        else if previousNNPro2Textfeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count ?? 0)!
        }
        else if previousNNPro3Textfeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?.count ?? 0)!
        }else if concomitantOtherproTextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count ?? 0)!
        }
        else if concomitantOther2proTextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count ?? 0)!
        }else if concomitantOther3proTextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count ?? 0)!
        }else if previousOtherProTextfeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count ?? 0)!
        }
        else if previousOtherPro2Textfeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count ?? 0)!
        }
        else if previousOtherPro3Textfeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count ?? 0)!
        }else if othersProductTextField.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count ?? 0)!
        }
        else if otherProduct2TextField.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count ?? 0)!
        }
        else if otherProduct3textField.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?.count ?? 0)!
        }else if deviceDemoTextField.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?.count ?? 0)!
        }
        else if deviceDemo2TextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?.count ?? 0)!
        }
        else if deviceDemoTextFeild3.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?.count ?? 0)!
        }else if typePatientTextField.isFirstResponder{
            return (self.PatientType.count)
        }else if frequencyTextField1.isFirstResponder{
            return (self.selectedNNName.count)
        }else if cityTextField.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityCity?.count ?? 0)!
        }else if frequencyTextField2.isFirstResponder{
            return (self.selectedNNName2.count ?? 0)
        }else if frequencyTextField3.isFirstResponder{
            return (self.selectedNNName3.count ?? 0)
        }else if doseTextField1.isFirstResponder{
            return (self.selectedNNName.count ?? 0)
        }else if doseTextField2.isFirstResponder{
            return (self.selectedNNName2.count ?? 0)
        }else if doseTextField3.isFirstResponder{
            return (self.selectedNNName3.count ?? 0)
        }else if eDoseTextField.isFirstResponder{
            return (self.selectedNNName.count ?? 0)
        }else if eDoseTextField2.isFirstResponder{
            return (self.selectedNNName2.count ?? 0)
        }else if eDoseTextField3.isFirstResponder{
            return (self.selectedNNName3.count ?? 0)
        }else if attachmentTextField.isFirstResponder{
            return (self.Attachment.count)
        }else if safetyEventYexyField.isFirstResponder{
            return (self.Attachment.count)
        }else if drugEventTextfield.isFirstResponder{
            return (self.Attachment.count)
        }else if technicalIssuetextField.isFirstResponder{
            return (self.Attachment.count)
        }else if gdmTextfield.isFirstResponder{
            return (self.Attachment.count)
        }else if hospitalizationTextField.isFirstResponder{
            return (self.Attachment.count)
        }else if discontinuationTextField.isFirstResponder{
            return (self.Attachment.count)
        }else if offLabelTextField.isFirstResponder{
            return (self.Attachment.count)
        }else if overDoseTextField.isFirstResponder{
            return (self.Attachment.count)
        }
        
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if CurrentNNProTextField.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if CurrentNNProTextField2.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if CurrentNNPro3TextField.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if concomitantNNproTextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if concomitantNNPro2TextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if concomitantNNPro3TextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if previousNNProTextfeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if previousNNPro2Textfeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if previousNNPro3Textfeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
        }else if concomitantOtherproTextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if concomitantOther2proTextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if concomitantOther3proTextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if concomitantOtherproTextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if concomitantOther2proTextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if concomitantOther3proTextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if previousOtherProTextfeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if previousOtherPro2Textfeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if previousOtherPro3Textfeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if othersProductTextField.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if otherProduct2TextField.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if otherProduct3textField.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
        }else if deviceDemoTextField.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
        }else if deviceDemo2TextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
        }else if deviceDemoTextFeild3.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
        }else if typePatientTextField.isFirstResponder{
            return self.PatientType[row]
        }else if frequencyTextField1.isFirstResponder{
            return self.selectedNNName[row]
        }else if cityTextField.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityCity?[row].name
        }else if frequencyTextField2.isFirstResponder{
            return self.selectedNNName2[row]
        }else if frequencyTextField3.isFirstResponder{
            return self.selectedNNName3[row]
        }else if doseTextField1.isFirstResponder{
            return self.selectedNNName[row]
        }else if doseTextField2.isFirstResponder{
            return self.selectedNNName2[row]
        }else if doseTextField3.isFirstResponder{
            return self.selectedNNName3[row]
        }else if eDoseTextField.isFirstResponder{
            return self.selectedNNName[row]
        }else if eDoseTextField2.isFirstResponder{
            return self.selectedNNName2[row]
        }else if eDoseTextField3.isFirstResponder{
            return self.selectedNNName3[row]
        }else if attachmentTextField.isFirstResponder{
            return self.Attachment[row]
        }else if safetyEventYexyField.isFirstResponder{
            return self.Attachment[row]
        }else if drugEventTextfield.isFirstResponder{
            return self.Attachment[row]
        }else if technicalIssuetextField.isFirstResponder{
            return self.Attachment[row]
        }else if gdmTextfield.isFirstResponder{
            return self.Attachment[row]
        }else if hospitalizationTextField.isFirstResponder{
            return self.Attachment[row]
        }else if discontinuationTextField.isFirstResponder{
            return self.Attachment[row]
        }else if offLabelTextField.isFirstResponder{
            return self.Attachment[row]
        }else if overDoseTextField.isFirstResponder{
            return self.Attachment[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if CurrentNNProTextField.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            CurrentNNProTextField.text = itemselected
            self.doseTextField1.isUserInteractionEnabled = true
            self.frequencyTextField1.isUserInteractionEnabled = true
            self.eDoseTextField.isUserInteractionEnabled = true
            self.doseTextField1.text = ""
            self.frequencyTextField1.text = ""
            self.eDoseTextField.text = ""
            self.currentNNId = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id
            self.productNN[0] = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id ?? 0
            
            let CurrentId = self.currentNNId
            let getProductId = self.patientResult?.educationalActivityViewModel?.educationalActivityDoseProductWise
            
            self.selectedNNId = []
            self.selectedNNName = []
            
            for value in getProductId! {
                if CurrentId == value.productId {
                    self.selectedNNId.append(value.doseId ?? 0)
                    self.selectedNNName.append(value.doseName ?? "")
                }
            }
            
        }else if CurrentNNProTextField2.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            CurrentNNProTextField2.text = itemselected
            self.doseTextField2.isUserInteractionEnabled = true
            self.eDoseTextField2.isUserInteractionEnabled = true
            self.frequencyTextField2.isUserInteractionEnabled = true
            
            self.doseTextField2.text = ""
            self.frequencyTextField2.text = ""
            self.eDoseTextField2.text = ""
            
            self.currentNNId2 = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id
            self.productNN[1] = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id ?? 0
            let CurrentId2 = self.currentNNId2
            let getProductId = self.patientResult?.educationalActivityViewModel?.educationalActivityDoseProductWise
            
            self.selectedNNId = []
            self.selectedNNName2 = []
            
            for value in getProductId! {
                if CurrentId2 == value.productId {
                    self.selectedNNId.append(value.doseId ?? 0)
                    self.selectedNNName2.append(value.doseName ?? "")
                }
            }
        }else if CurrentNNPro3TextField.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            CurrentNNPro3TextField.text = itemselected
            self.currentNNId3 = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id
            self.productNN[2] = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id ?? 0
            self.doseTextField3.isUserInteractionEnabled = true
            self.eDoseTextField3.isUserInteractionEnabled = true
            self.frequencyTextField3.isUserInteractionEnabled = true
            
            self.doseTextField3.text = ""
            self.eDoseTextField3.text = ""
            self.frequencyTextField3.text = ""
            
            let CurrentId3 = self.currentNNId3
            let getProductId = self.patientResult?.educationalActivityViewModel?.educationalActivityDoseProductWise
            
            self.selectedNNId = []
            self.selectedNNName3 = []
            
            for value in getProductId! {
                if CurrentId3 == value.productId {
                    self.selectedNNId.append(value.doseId ?? 0)
                    self.selectedNNName3.append(value.doseName ?? "")
                }
            }
        }else if concomitantNNproTextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            concomitantNNproTextFeild.text = itemselected
            self.concomitantProId = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id
            if concomitantNNproTextFeild.text != "" {
                concomitantNNPro2TextFeild.isUserInteractionEnabled = true
            }
            
        }else if concomitantNNPro2TextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            concomitantNNPro2TextFeild.text = itemselected
            self.concomitantProId2 = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id
            if concomitantNNPro2TextFeild.text != "" {
                concomitantNNPro3TextFeild.isUserInteractionEnabled = true
            }
        }else if concomitantNNPro3TextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            concomitantNNPro3TextFeild.text = itemselected
            self.concomitantProId3 = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id
        }else if previousNNProTextfeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            previousNNProTextfeild.text = itemselected
            self.previousNNId = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id
            
            if previousNNProTextfeild.text != "" {
                previousNNPro2Textfeild.isUserInteractionEnabled = true
            }
        }else if previousNNPro2Textfeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            previousNNPro2Textfeild.text = itemselected
            self.previousNNId2 = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id
            if previousNNPro2Textfeild.text != "" {
                previousNNPro3Textfeild.isUserInteractionEnabled = true
            }
        }else if previousNNPro3Textfeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].name
            previousNNPro3Textfeild.text = itemselected
            self.previousNNId3 = self.patientResult?.educationalActivityViewModel?.educationalActivityProduct?[row].id
        }else if concomitantOtherproTextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            concomitantOtherproTextFeild.text = itemselected
            self.concomitantOtherproId = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].id
            
            if concomitantOtherproTextFeild.text != "" {
                concomitantOther2proTextFeild.isUserInteractionEnabled = true
            }
            
        }else if concomitantOther2proTextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            concomitantOther2proTextFeild.text = itemselected
            self.concomitantOtherproId2 = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].id
            if concomitantOther2proTextFeild.text != "" {
                concomitantOther3proTextFeild.isUserInteractionEnabled = true
            }
            
        }else if concomitantOther3proTextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            concomitantOther3proTextFeild.text = itemselected
            self.concomitantOtherproId3 = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].id
        }else if previousOtherProTextfeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            previousOtherProTextfeild.text = itemselected
            self.previousOtherId = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].id
            
            if previousOtherProTextfeild.text != "" {
                previousOtherPro2Textfeild.isUserInteractionEnabled = true
            }
            
        }else if previousOtherPro2Textfeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            previousOtherPro2Textfeild.text = itemselected
            self.previousOtherId2 = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].id
            if previousOtherPro2Textfeild.text != "" {
                previousOtherPro3Textfeild.isUserInteractionEnabled = true
            }
        }else if previousOtherPro3Textfeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            previousOtherPro3Textfeild.text = itemselected
            self.previousOtherId3 = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].id
        }else if othersProductTextField.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            othersProductTextField.text = itemselected
            self.othersProduct = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].id
            if othersProductTextField.text != "" {
                otherProduct2TextField.isUserInteractionEnabled = true
            }
            
        }else if otherProduct2TextField.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            otherProduct2TextField.text = itemselected
            self.othersProduct2 = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].id
            if otherProduct2TextField.text != "" {
                otherProduct3textField.isUserInteractionEnabled = true
            }
        }else if otherProduct3textField.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].name
            otherProduct3textField.text = itemselected
            //ammadali
            self.othersProduct3 = self.patientResult?.educationalActivityViewModel?.educationalActivityOtherProduct?[row].id
        }else if deviceDemoTextField.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
            deviceDemoTextField.text = itemselected
            self.deviceDemoId = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].id
            if deviceDemoTextField.text != "" {
                
                deviceDemo2TextFeild.isUserInteractionEnabled = true
            }
            
        }else if deviceDemo2TextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
            deviceDemo2TextFeild.text = itemselected
            self.deviceDemoId2 = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].id
            if deviceDemo2TextFeild.text != "" {
                
                deviceDemoTextFeild3.isUserInteractionEnabled = true
            }
            
        }else if deviceDemoTextFeild3.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
            deviceDemoTextFeild3.text = itemselected
            self.deviceDemoId3 = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].id
        }else if typePatientTextField.isFirstResponder{
            let itemselected = self.PatientType[row]
            typePatientTextField.text = itemselected
        }else if frequencyTextField1.isFirstResponder{
            let itemselected = self.selectedNNName[row]
            frequencyTextField1.text = itemselected
            self.dosId2 = self.selectedNNId[row]
            if self.doseTextField1.text != "" && eDoseTextField.text != ""{
                self.CurrentNNProTextField2.isUserInteractionEnabled = true
            }
            
        }else if cityTextField.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityCity?[row].name
            cityTextField.text = itemselected
        }else if frequencyTextField2.isFirstResponder{
            let itemselected = self.selectedNNName2[row]
            frequencyTextField2.text = itemselected
            self.dosId5 = self.selectedNNId[row]
            if self.doseTextField2.text != "" && eDoseTextField2.text != ""{
                self.CurrentNNPro3TextField.isUserInteractionEnabled = true
            }
        }else if doseTextField1.isFirstResponder{
            let itemselected = self.selectedNNName[row]
            doseTextField1.text = itemselected
            self.dosId = self.selectedNNId[row]
            if self.frequencyTextField1.text != "" && eDoseTextField.text != ""{
                self.CurrentNNProTextField2.isUserInteractionEnabled = true
            }
            //ammad
        }else if doseTextField2.isFirstResponder{
            let itemselected = self.selectedNNName2[row]
            doseTextField2.text = itemselected
            self.dosId4 = self.selectedNNId[row]
            if self.frequencyTextField2.text != "" && eDoseTextField2.text != ""{
                self.CurrentNNPro3TextField.isUserInteractionEnabled = true
            }
        }else if doseTextField3.isFirstResponder{
            let itemselected = self.selectedNNName3[row]
            doseTextField3.text = itemselected
            self.dosId7 = self.selectedNNId[row]
        }else if eDoseTextField.isFirstResponder{
            let itemselected = self.selectedNNName[row]
            eDoseTextField.text = itemselected
            self.dosId3 = self.selectedNNId[row]
            if self.frequencyTextField1.text != "" && doseTextField1.text != ""{
                self.CurrentNNProTextField2.isUserInteractionEnabled = true
            }
        }else if eDoseTextField2.isFirstResponder{
            let itemselected = self.selectedNNName2[row]
            eDoseTextField2.text = itemselected
            self.dosId6 = self.selectedNNId[row]
            if self.frequencyTextField2.text != "" && doseTextField2.text != ""{
                self.CurrentNNPro3TextField.isUserInteractionEnabled = true
            }
        }else if eDoseTextField3.isFirstResponder{
            let itemselected = self.selectedNNName3[row]
            eDoseTextField3.text = itemselected
            self.dosId9 = self.selectedNNId[row]
        }else if frequencyTextField3.isFirstResponder{
            let itemselected = self.selectedNNName3[row]
            frequencyTextField3.text = itemselected
            self.dosId8 = self.selectedNNId[row]
        }else if attachmentTextField.isFirstResponder{
            let itemselected = self.Attachment[row]
            attachmentTextField.text = itemselected
        }else if safetyEventYexyField.isFirstResponder{
            let itemselected = self.Attachment[row]
            safetyEventYexyField.text = itemselected
        }else if drugEventTextfield.isFirstResponder{
            let itemselected = self.Attachment[row]
            drugEventTextfield.text = itemselected
        }else if technicalIssuetextField.isFirstResponder{
            let itemselected = self.Attachment[row]
            technicalIssuetextField.text = itemselected
        }else if gdmTextfield.isFirstResponder{
            let itemselected = self.Attachment[row]
            gdmTextfield.text = itemselected
        }else if hospitalizationTextField.isFirstResponder{
            let itemselected = self.Attachment[row]
            hospitalizationTextField.text = itemselected
        }else if discontinuationTextField.isFirstResponder{
            let itemselected = self.Attachment[row]
            discontinuationTextField.text = itemselected
        }else if offLabelTextField.isFirstResponder{
            let itemselected = self.Attachment[row]
            offLabelTextField.text = itemselected
        }else if overDoseTextField.isFirstResponder{
            let itemselected = self.Attachment[row]
            overDoseTextField.text = itemselected
        }
        
        if drugEventTextfield.text == "Yes" {
            self.drugEvent = true
        } else if drugEventTextfield.text == "No" {
            self.drugEvent = false
        }
        if technicalIssuetextField.text == "Yes" {
            self.technicalIssueEvent = true
        } else if technicalIssuetextField.text == "No" {
            self.technicalIssueEvent = false
        }
        if gdmTextfield.text == "Yes" {
            self.GDMEvent = true
        } else if gdmTextfield.text == "No" {
            self.GDMEvent = false
        }
        if hospitalizationTextField.text == "Yes" {
            self.hospitalizationEvent = true
        } else if hospitalizationTextField.text == "No" {
            self.hospitalizationEvent = false
        }
        if offLabelTextField.text == "Yes" {
            self.offLabelEvent = true
        } else if offLabelTextField.text == "No" {
            self.offLabelEvent = false
        }
        if discontinuationTextField.text == "Yes" {
            self.discontinuationEvent = true
        } else if discontinuationTextField.text == "No" {
            self.discontinuationEvent = false
        }
        if overDoseTextField.text == "Yes" {
            self.overDoseEvent = true
        } else if overDoseTextField.text == "No" {
            self.overDoseEvent = false
        }
        if safetyEventYexyField.text == "Yes" {
            self.safetyEvent = true
            safetyEventView.isHidden = false
        } else if safetyEventYexyField.text == "No" {
            self.safetyEvent = false
            safetyEventView.isHidden = true
            
        }
        
        if attachmentTextField.text == "Yes" {
            viewImageOutlet.isHidden = false
            whiteViewOutlet.isHidden = true
            self.scrollView.isScrollEnabled = true
            let keyData = CommonUtils.getJsonFromUserDefaults(forKey: Constants.key)
            
            if keyData == "0" || keyData == "" {
                
                CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Please sync your App data", onOkClicked: {()
                    self.dismiss(animated: true, completion: nil)
                })
            }
        } else if attachmentTextField.text == "No" {
            viewImageOutlet.isHidden = true
            self.scrollView.isScrollEnabled = false
            whiteViewOutlet.isHidden = false
        }
        
    }
    
    @IBAction func webButton(_ sender: Any) {
        
        if let url = URL(string: "https://www.novonordisk.com.au/contact-us/safety-information-report.html") {
            UIApplication.shared.open(url)
            
        }
        
    }
    
    
    func addPatientActivity() {
        
        let providedPatientName = namefeild.text
        let providedContact = contactNumTextField.text
        let providedContact2 = contactNum2TextField.text
        let providedCity = cityTextField.text
        let providedAddress = addressTextField.text
        let providedAddress2 = address2TextField.text
        let providediNovoId = iNovoIdTextField.text
        let providedPatientType = typePatientTextField.text
        let providedCurrentNN = CurrentNNProTextField.text
        let providedCurrentNN2 = CurrentNNProTextField2.text
        let providedCurrentNN3 = CurrentNNPro3TextField.text
        let providedDeviceDemo = deviceDemoTextField.text
        let providedDeviceDemo2 = deviceDemo2TextFeild.text
        let providedDeviceDemo3 = deviceDemoTextFeild3.text
        let providedConcomitantNN = concomitantNNproTextFeild.text
        let providedConcomitantNN2 = concomitantNNPro2TextFeild.text
        let providedConcomitantNN3 = concomitantNNPro3TextFeild.text
        let providedPreviousNN = previousNNProTextfeild.text
        let providedPreviousNN2 = previousNNPro2Textfeild.text
        let providedPreviousNN3 = previousNNPro3Textfeild.text
        let providedPreviousOther = previousOtherProTextfeild.text
        let providedPreviousOther2 = previousOtherPro2Textfeild.text
        let providedPreviousOther3 = previousOtherPro3Textfeild.text
        let providedBGSReading = BGSreadingTextField.text
        let providedBPReading = BPreadingTextField.text
        let providedHba1c = Hba1cLabel.text
        let providedWeight = weightReadingTextField.text
        let providedConcomitantOther =  concomitantOtherproTextFeild.text
        let providedConcomitantOther2 =  concomitantOther2proTextFeild.text
        let providedConcomitantOther3 =  concomitantOther3proTextFeild.text
        let providedDose = doseTextField1.text
        let providedDose2 = doseTextField2.text
        let providedDose3 = doseTextField3.text
        let provideAttachment = attachmentTextField.text
        let isHardCopy = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ishardselect)
        let isExplained = CommonUtils.getJsonFromUserDefaults(forKey: Constants.isexplainedselect)
        let frequencyProvide1 = frequencyTextField1.text
        let frequencyProvide2 = frequencyTextField2.text
        let frequencyProvide3 = frequencyTextField3.text
        let drugs = drugEventTextfield.text
        let technicalIssue = technicalIssuetextField.text
        let gdm = gdmTextfield.text
        let hospitalization = hospitalizationTextField.text
        let discontinuation = discontinuationTextField.text
        let offLabel = offLabelTextField.text
        let overDose = overDoseTextField.text
        let Safety = safetyEventYexyField.text
        let eDose = eDoseTextField.text
        let eDose2 = eDoseTextField2.text
        let eDose3 = eDoseTextField3.text
        let rating = self.ratingScale
        
        if provideAttachment == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Patient Consent")
            return
        }
        if provideAttachment == "Yes" {
            if self.fileName == "" {

                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Patient Consent Image")
                return
            }

        }
        
        if provideAttachment == "Yes" {
            
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.ConstantNO, withJson: "1")
            
        }else {
            
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.ConstantNO, withJson: "0")
        }
        
        if providedPatientName == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Patient Name")
            return
        }
        if contactNumTextField.text!.count < 11 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the Complete Contact Number 1")
            return
        }
        if contactNumTextField.text!.count > 19 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the less than 20 Number in Contact Number 1")
            return
        }
        
        if contactNum2TextField.text!.count < 11 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the Complete Contact Number 2")
            return
        }
        
        if contactNum2TextField.text!.count > 19 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the less than 20 Number in Contact Number 2")
            return
        }
        if providedContact == nil || providedContact == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Contact Number 1")
            return
        }
        if providedContact2 == nil || providedContact2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Contact Number 2")
            return
        }
        if providedCity == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the City")
            return
        }
        if providedAddress == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Address 1")
            return
        }
        if providedAddress2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Address 2")
            return
        }
//        if providediNovoId == "" || providediNovoId == nil {
//            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the iNovo ID")
//            return
//        }
        if providedPatientType == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Patient Type")
            return
        }
        if providedCurrentNN == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the CurrentNN 1")
            return
        }
        
        if providedDose == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the M Dose 1")
            return
        }
        if frequencyProvide1 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the A Dose 1")
            return
        }
        if eDose == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the E Dose 1")
            return
        }
        
        if providedDeviceDemo == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Device Demo 1")
            return
        }
        
        if providedConcomitantNN == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the ConcomitantNN Product 1")
            return
        }
        
        if providedPreviousNN == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the PreviousNN Product 1")
            return
        }
        
        if othersProductTextField.text == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Other main Product")
            return
        }
        
        if providedConcomitantOther == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Concomitant Other Product 1")
            return
        }
        
        if providedPreviousOther == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Previous Other Product 1")
            return
        }
        
        if providedBGSReading == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Blood Sugar Screening")
            return
        }
        if providedWeight == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter Weight Screening")
            return
        }
        if providedBPReading == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter Blood Pressure Screening")
            return
        }
        
        if rating == nil {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Rating Stars")
            return
        }
        
        let patientfield = providedPatientName
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.validate, withJson: patientfield ?? "")
        
        let imagePath = self.patientConsentUrl
        
        if (self.currentCall?.clinicActivity == nil) { self.currentCall?.clinicActivity = [] }
        
        self.currentCall?.clinicActivity?.append(ClinicActivity(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        let index = (self.currentCall?.clinicActivity?.count ?? 0) - 1
        
        
        let abcdef = deviceDemoId2
        
        if deviceDemoId2 == nil {
            
            self.device = false
        }else {
            
            self.device = true
        }
        
        if deviceDemoId3 == nil {
            
            self.device2 = false
        }else {
            self.device2 = true
        }
        
        
        
        currentCall?.clinicActivity![index].patientName = providedPatientName
        currentCall?.clinicActivity![index].patientType = providedPatientType
        currentCall?.clinicActivity![index].address1 = providedAddress
        currentCall?.clinicActivity![index].address2 = providedAddress2
        currentCall?.clinicActivity![index].contactNumber1 = providedContact
        currentCall?.clinicActivity![index].contactNumber2 = providedContact2
//        currentCall?.clinicActivity![index].patientConsentAttachmentUrl = imagePath
        currentCall?.clinicActivity![index].patientConsent = true
        currentCall?.clinicActivity![index].bloodGlucose = providedBGSReading
        currentCall?.clinicActivity![index].bloodPressure = providedBPReading ?? ""
        currentCall?.clinicActivity![index].ClinicActivityGuid = CommonUtils.getJsonFromUserDefaults(forKey: Constants.patientUuid)
        currentCall?.clinicActivity![index].hbA1c = providedHba1c
        currentCall?.clinicActivity![index].feedbackStars = "\(rating ?? 0)"
        currentCall?.clinicActivity![index].weight = providedWeight
        currentCall?.clinicActivity![index].city = providedCity
        currentCall?.clinicActivity![index].iNovoId = providediNovoId
        currentCall?.clinicActivity![index].SafetyEventReportByPatient = false
        
        currentCall?.clinicActivity![index].AdverseDrugEvent = false
        currentCall?.clinicActivity![index].TechnicalIssue = false
        currentCall?.clinicActivity![index].GDM = false
        currentCall?.clinicActivity![index].Hospitalization = false
        currentCall?.clinicActivity![index].OffLabel = false
        
        let ammad = overDoseEvent
        currentCall?.clinicActivity![index].MedicationErrorOverdoseOrMisuse = false
        currentCall?.clinicActivity![index].Discontinuation = false
        //        var arrayName:Array<yourclassname> = Array()
        
        self.currentCall?.clinicActivity![index].currentProductList = []
        
        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].currentProductList![0].productId = self.currentNNId
        currentCall?.clinicActivity![index].currentProductList![0].deviceId = self.deviceDemoId
        currentCall?.clinicActivity![index].currentProductList![0].dose = self.dosId
        currentCall?.clinicActivity![index].currentProductList![0].deviceDemo = true
        currentCall?.clinicActivity![index].currentProductList![0].Frequency = 1
        
        
        
        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].currentProductList![1].productId = self.currentNNId
        currentCall?.clinicActivity![index].currentProductList![1].deviceId = self.deviceDemoId
        currentCall?.clinicActivity![index].currentProductList![1].dose = self.dosId2
        currentCall?.clinicActivity![index].currentProductList![1].deviceDemo = true
        currentCall?.clinicActivity![index].currentProductList![1].Frequency = 2
        
        
        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].currentProductList![2].productId = self.currentNNId
        currentCall?.clinicActivity![index].currentProductList![2].deviceId = self.deviceDemoId
        currentCall?.clinicActivity![index].currentProductList![2].dose = self.dosId3
        currentCall?.clinicActivity![index].currentProductList![2].deviceDemo = true
        currentCall?.clinicActivity![index].currentProductList![2].Frequency = 3
        
        //pro 2
        
        
        let abc = self.currentNNId2
        
        if self.currentNNId2 != nil {
            
        
        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].currentProductList![3].productId =
        self.currentNNId2
        currentCall?.clinicActivity![index].currentProductList![3].deviceId = self.deviceDemoId2
        currentCall?.clinicActivity![index].currentProductList![3].dose = self.dosId4
        currentCall?.clinicActivity![index].currentProductList![3].deviceDemo = self.device
            currentCall?.clinicActivity![index].currentProductList![3].Frequency = 1
        
        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].currentProductList![4].productId = self.currentNNId2
        currentCall?.clinicActivity![index].currentProductList![4].deviceId = self.deviceDemoId2
        currentCall?.clinicActivity![index].currentProductList![4].dose = self.dosId5
        currentCall?.clinicActivity![index].currentProductList![4].deviceDemo = self.device
            currentCall?.clinicActivity![index].currentProductList![4].Frequency = 2
        
        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].currentProductList![5].productId = self.currentNNId2
        currentCall?.clinicActivity![index].currentProductList![5].deviceId = self.deviceDemoId2
        currentCall?.clinicActivity![index].currentProductList![5].dose = self.dosId6
        currentCall?.clinicActivity![index].currentProductList![5].deviceDemo = self.device
        currentCall?.clinicActivity![index].currentProductList![5].Frequency = 3
        }
        
        if self.currentNNId3 != nil {
        
        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].currentProductList![6].productId = self.currentNNId3
        currentCall?.clinicActivity![index].currentProductList![6].deviceId = self.deviceDemoId3
        currentCall?.clinicActivity![index].currentProductList![6].dose = self.dosId7
        currentCall?.clinicActivity![index].currentProductList![6].deviceDemo = self.device2
            currentCall?.clinicActivity![index].currentProductList![6].Frequency = 1
            
       
        
        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].currentProductList![7].productId = self.currentNNId3
        currentCall?.clinicActivity![index].currentProductList![7].deviceId = self.deviceDemoId3
        currentCall?.clinicActivity![index].currentProductList![7].dose = self.dosId8
        currentCall?.clinicActivity![index].currentProductList![7].deviceDemo = self.device2
            currentCall?.clinicActivity![index].currentProductList![7].Frequency = 2
        
        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].currentProductList![8].productId = self.currentNNId3
        currentCall?.clinicActivity![index].currentProductList![8].deviceId = self.deviceDemoId3
        currentCall?.clinicActivity![index].currentProductList![8].dose = self.dosId9
        currentCall?.clinicActivity![index].currentProductList![8].deviceDemo = self.device2
            currentCall?.clinicActivity![index].currentProductList![8].Frequency = 3
        
        }
        self.currentCall?.clinicActivity![index].concomitantProductList = []
        self.currentCall?.clinicActivity![index].concomitantProductList!.append(ConcomitantProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantProductList![0].productId = self.concomitantProId
        
        if self.concomitantProId2 != nil {
            
        self.currentCall?.clinicActivity![index].concomitantProductList!.append(ConcomitantProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantProductList![1].productId = self.concomitantProId2
            
        }
        
        if self.concomitantProId3 != nil {
        
        self.currentCall?.clinicActivity![index].concomitantProductList!.append(ConcomitantProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantProductList![2].productId = self.concomitantProId3
            
    }
        
        self.currentCall?.clinicActivity![index].concomitantOtherProductList = []
        self.currentCall?.clinicActivity![index].concomitantOtherProductList!.append(ConcomitantOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantOtherProductList![0].otherProductId = self.concomitantOtherproId
        
        if self.concomitantOtherproId2 != nil {
        
        self.currentCall?.clinicActivity![index].concomitantOtherProductList!.append(ConcomitantOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantOtherProductList![1].otherProductId = self.concomitantOtherproId2
    }
        
       if self.concomitantOtherproId3 != nil {
        self.currentCall?.clinicActivity![index].concomitantOtherProductList!.append(ConcomitantOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantOtherProductList![2].otherProductId = self.concomitantOtherproId3
            
        }
        
        self.currentCall?.clinicActivity![index].previousProductList = []
        self.currentCall?.clinicActivity![index].previousProductList!.append(PreviousProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].previousProductList![0].productId = self.previousNNId
        
        if self.previousNNId2 != nil {
        
        self.currentCall?.clinicActivity![index].previousProductList!.append(PreviousProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].previousProductList![1].productId = self.previousNNId2
            
        }
        
        if self.previousNNId3 != nil {
        
        self.currentCall?.clinicActivity![index].previousProductList!.append(PreviousProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].previousProductList![2].productId = self.previousNNId3
            
        }
        
        self.currentCall?.clinicActivity![index].previousOtherProductList = []
        self.currentCall?.clinicActivity![index].previousOtherProductList!.append(PreviousOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].previousOtherProductList![0].otherProductId = self.previousOtherId
        
        if self.previousOtherId2 != nil {
        
        self.currentCall?.clinicActivity![index].previousOtherProductList!.append(PreviousOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].previousOtherProductList![1].otherProductId = self.previousOtherId2
        }
        
        if self.previousOtherId3 != nil {
            
        self.currentCall?.clinicActivity![index].previousOtherProductList!.append(PreviousOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].previousOtherProductList![2].otherProductId = self.previousOtherId3
            
        }
        
        //ammadaliali
        
        let ali1 = othersProduct
        let ali2 = othersProduct2
        let ali3 = othersProduct3
        
        self.currentCall?.clinicActivity![index].currentOtherProductList = []
        self.currentCall?.clinicActivity![index].currentOtherProductList!.append(CurrentOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].currentOtherProductList![0].OtherProductId = self.othersProduct
        
        if self.othersProduct2 != nil {
        
        self.currentCall?.clinicActivity![index].currentOtherProductList!.append(CurrentOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].currentOtherProductList![1].OtherProductId = self.othersProduct2
        }
        
        if self.othersProduct3 != nil {
            
        self.currentCall?.clinicActivity![index].currentOtherProductList!.append(CurrentOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].currentOtherProductList![2].OtherProductId = self.othersProduct3
            
        }
            
        self.currentCall?.clinicActivity![index].discussionTopicList = []
        for i in 0..<self.selectedTopicApi.count{
            
            self.currentCall?.clinicActivity![index].discussionTopicList!.append(DiscussionTopicList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
    //
            currentCall?.clinicActivity![index].discussionTopicList![i].discussionTopicId = self.selectedTopicApi[i].id
                currentCall?.clinicActivity![index].discussionTopicList![i].explained = self.selectedTopicApi[i].isExplained
                currentCall?.clinicActivity![index].discussionTopicList![i].hardCopyProvided = self.selectedTopicApi[i].isHardcopy
        }
        self.onPatientAdded?(self.currentCall)
        
        self.dismiss(animated: true, completion: nil)
        
        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage:"successfully submitted")
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.isexplainedselect, withJson: "false")
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ishardselect, withJson: "false")
        
        var data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.imgPostData)
        if (data == "") {data = "[]"}
        
        var callImages:[ImageCallModel] = Mapper<ImageCallModel>().mapArray(JSONString: data)!
        
        var callImage = ImageCallModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        callImage?.Guid = CommonUtils.getJsonFromUserDefaults(forKey: Constants.patientUuid)
        callImage?.PatinetConsentAttachmentUrl = self.filePathWithName?.absoluteString
        
        callImages.append(callImage!)
        
        let imageJsonString = Mapper().toJSONString(callImages)!
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.imgPostData, withJson: imageJsonString)
        
        namefeild.text = ""
        contactNumTextField.text = ""
        contactNum2TextField.text = ""
        cityTextField.text = ""
        addressTextField.text = ""
        address2TextField.text = ""
        iNovoIdTextField.text = ""
        typePatientTextField.text = ""
        CurrentNNProTextField.text = ""
        CurrentNNProTextField2.text = ""
        CurrentNNPro3TextField.text = ""
        deviceDemoTextField.text = ""
        deviceDemo2TextFeild.text = ""
        deviceDemoTextFeild3.text = ""
        concomitantNNproTextFeild.text = ""
        concomitantNNPro2TextFeild.text = ""
        concomitantNNPro3TextFeild.text = ""
        previousNNProTextfeild.text = ""
        previousNNPro2Textfeild.text = ""
        previousNNPro3Textfeild.text = ""
        previousOtherProTextfeild.text = ""
        previousOtherPro2Textfeild.text = ""
        previousOtherPro3Textfeild.text = ""
        othersProductTextField.text = ""
        otherProduct2TextField.text = ""
        otherProduct3textField.text = ""
        BGSreadingTextField.text = ""
        BPreadingTextField.text = ""
        weightReadingTextField.text = ""
        concomitantOtherproTextFeild.text = ""
        concomitantOther2proTextFeild.text = ""
        concomitantOther3proTextFeild.text = ""
        doseTextField1.text = ""
        doseTextField2.text = ""
        doseTextField3.text = ""
        self.currentNNId = nil
        self.currentNNId2 = nil
        self.currentNNId3 = nil
        self.selectedTopic?.isExplained = false
        self.selectedTopic?.isHardcopy = false
        
    }
    
    @IBAction func onSaveBtnClicked(_ sender: Any) {
        
        let provideAttachment2 = attachmentTextField.text
        
        if provideAttachment2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Patient Consent")
            return
        }
        
        if provideAttachment2 == "No" {
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.ConstantNO, withJson: "0")
        }
        
        if (self.currentCall?.clinicActivity == nil) { self.currentCall?.clinicActivity = [] }
        
        self.currentCall?.clinicActivity?.append(ClinicActivity(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        let index = (self.currentCall?.clinicActivity?.count ?? 0) - 1
        currentCall?.clinicActivity![index].patientName = ""
        currentCall?.clinicActivity![index].patientType = ""
        currentCall?.clinicActivity![index].address1 = ""
        currentCall?.clinicActivity![index].address2 = ""
        currentCall?.clinicActivity![index].contactNumber1 = ""
        currentCall?.clinicActivity![index].contactNumber2 = ""
//        currentCall?.clinicActivity![index].patientConsentAttachmentUrl = ""
        currentCall?.clinicActivity![index].patientConsent = false
        currentCall?.clinicActivity![index].bloodGlucose = ""
        currentCall?.clinicActivity![index].bloodPressure = ""
        currentCall?.clinicActivity![index].weight = ""
        currentCall?.clinicActivity![index].city = ""
        currentCall?.clinicActivity![index].iNovoId = ""
        currentCall?.clinicActivity![index].SafetyEventReportByPatient = self.safetyEvent
        
        currentCall?.clinicActivity![index].AdverseDrugEvent = drugEvent
        currentCall?.clinicActivity![index].TechnicalIssue = technicalIssueEvent
        currentCall?.clinicActivity![index].GDM = GDMEvent
        currentCall?.clinicActivity![index].Hospitalization = hospitalizationEvent
        currentCall?.clinicActivity![index].OffLabel = offLabelEvent
        currentCall?.clinicActivity![index].MedicationErrorOverdoseOrMisuse = overDoseEvent
        
        self.currentCall?.clinicActivity![index].currentProductList = []
        
//        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
//        if self.currentNNId != nil {
//        currentCall?.clinicActivity![index].currentProductList![0].productId = self.currentNNId
//        currentCall?.clinicActivity![index].currentProductList![0].deviceId = self.deviceDemoId
//        currentCall?.clinicActivity![index].currentProductList![0].dose = self.dosId
//        currentCall?.clinicActivity![index].currentProductList![0].deviceDemo = false
//        currentCall?.clinicActivity![index].currentProductList![0].Frequency = self.freqId
//
//
//        }
        
        
        self.currentCall?.clinicActivity![index].concomitantProductList = []
       
        
        self.currentCall?.clinicActivity![index].concomitantOtherProductList = []
        
        
        self.currentCall?.clinicActivity![index].previousProductList = []
        
        
        self.currentCall?.clinicActivity![index].previousOtherProductList = []
        
        
        self.currentCall?.clinicActivity![index].currentOtherProductList = []
       
        
        self.currentCall?.clinicActivity![index].discussionTopicList = []
        
        
        self.onPatientAdded?(self.currentCall)
        
        self.dismiss(animated: true, completion: nil)
        
        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage:"successfully submitted")
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.isexplainedselect, withJson: "false")
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ishardselect, withJson: "false")
        
        var data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.imgPostData)
        if (data == "") {data = "[]"}
        
        var callImages:[ImageCallModel] = Mapper<ImageCallModel>().mapArray(JSONString: data)!
        
        var callImage = ImageCallModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        callImage?.Guid = CommonUtils.getJsonFromUserDefaults(forKey: Constants.patientUuid)
        callImage?.PatinetConsentAttachmentUrl = self.filePathWithName?.absoluteString
        
        callImages.append(callImage!)
        
        let imageJsonString = Mapper().toJSONString(callImages)!
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.imgPostData, withJson: imageJsonString)
        
        namefeild.text = ""
        contactNumTextField.text = ""
        contactNum2TextField.text = ""
        cityTextField.text = ""
        addressTextField.text = ""
        address2TextField.text = ""
        iNovoIdTextField.text = ""
        typePatientTextField.text = ""
        CurrentNNProTextField.text = ""
        CurrentNNProTextField2.text = ""
        CurrentNNPro3TextField.text = ""
        deviceDemoTextField.text = ""
        deviceDemo2TextFeild.text = ""
        deviceDemoTextFeild3.text = ""
        concomitantNNproTextFeild.text = ""
        concomitantNNPro2TextFeild.text = ""
        concomitantNNPro3TextFeild.text = ""
        previousNNProTextfeild.text = ""
        previousNNPro2Textfeild.text = ""
        previousNNPro3Textfeild.text = ""
        previousOtherProTextfeild.text = ""
        previousOtherPro2Textfeild.text = ""
        previousOtherPro3Textfeild.text = ""
        othersProductTextField.text = ""
        otherProduct2TextField.text = ""
        otherProduct3textField.text = ""
        BGSreadingTextField.text = ""
        BPreadingTextField.text = ""
        weightReadingTextField.text = ""
        concomitantOtherproTextFeild.text = ""
        concomitantOther2proTextFeild.text = ""
        concomitantOther3proTextFeild.text = ""
        doseTextField1.text = ""
        doseTextField2.text = ""
        doseTextField3.text = ""
        self.selectedTopic?.isExplained = false
        self.selectedTopic?.isHardcopy = false
        
    }
    
    @IBAction func onSubmitClick(_ sender: Any) {
        
        CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Do you want to submit this form", controller: self, onYesClicked: {()
            self.addPatientActivity()
            
        }, onNoClicked: {()
            
            return
            
        })
        
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        
        CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Do you want to end Camp with this Patient", controller: self, onYesClicked: {()
            self.dismiss(animated: true, completion: nil)
            
        }, onNoClicked: {()
            return
            
        })
        
    }
    
}
//
//extension AddPatientViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
//
//    //MARK: - Done image capture here
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        imagePicker.dismiss(animated: true, completion: {
//            let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//            if (self.imagePickerRequestFor == "Consent") {
//                self.imageViewOutlet.image = image
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
//                        self.patientConsentUrl = imageUploadModel?.result![0]
//                    }
//                }
//            case .failure(let encodingError):
//                print(encodingError)
//            }
//        })
//
//    }
//}
