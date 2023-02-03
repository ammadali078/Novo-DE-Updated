//
//  EducationalActivityViewController.swift
//  E-detailer
//
//  Created by macbook on 14/05/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import BEMCheckBox
import Photos
import Cosmos

class EducationalActivityViewController: UIViewController,BEMCheckBoxDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var namefeild: UITextField!
    @IBOutlet weak var contactNumTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var educationProvideLayOut: UIView!
    @IBOutlet weak var educationProvideCollectionView: UICollectionView!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var deviceDemoTextField: UITextField!
    @IBOutlet weak var deviceDemo2TextFeild: UITextField!
    @IBOutlet weak var deviceDemoTextFeild3: UITextField!
    @IBOutlet weak var BGSreadingTextField: UITextField!
    @IBOutlet weak var saveBtnOutlet: UIButton!
    @IBOutlet weak var attachmentTextField: UITextField!
    @IBOutlet weak var viewImageOutlet: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var whiteViewOutlet: UIView!
    @IBOutlet weak var cosmosFullView: CosmosView!
    
    var patientResult : PatientResult?
    var selectedImageData: Data?
    var productNN: [Int] = [0 , 0 , 0]
    var educationProvideDataSource: ActEducationProvideCell!
    var imagePicker = UIImagePickerController()
    var filePathWithName: URL?
    var patientConsentUrl: String? = ""
    var fileName: String? = ""
    var currentNNId: Int?
    var ratingScale:Int?
    var currentNNId2: Int?
    var currentNNId3: Int?
    var dosId: Int?
    var freqId: Int?
    var Count = "0"
    var Count2 = "0"
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
    var imagePickerRequestFor: String? = ""
    var activitiyViewController: ActivityViewController!
    var concomitantProId: Int?
    var concomitantOtherproId: Int?
    var previousOtherId: Int?
    var previousNNId: Int?
    var device: Bool?
    var device2: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Uuid = UUID().uuidString
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.patientUuid2, withJson: Uuid)
        
        cosmosFullView.didTouchCosmos = {rating in
            self.ratingScale = Int(rating)
        }
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarddisAppear), name: UIResponder.keyboardWillHideNotification, object: nil)
        educationProvideDataSource = ActEducationProvideCell()
        
        self.scrollView.isScrollEnabled = false
        
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
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.callProductApi()
//        }
       
        BGSreadingTextField.delegate = self
        //self.selectedPlan = planner
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        saveBtnOutlet.layer.cornerRadius = 10.0
        
        educationProvideCollectionView.dataSource = educationProvideDataSource
        imagePicker.delegate = self
        //UIPICKER
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
      
        cityTextField.delegate = self
        
        attachmentTextField.delegate = self
        contactNumTextField.delegate = self
        cityTextField.delegate = self
        addressTextField.delegate = self
        
        deviceDemoTextField.delegate = self
        deviceDemo2TextFeild.delegate = self
        deviceDemoTextFeild3.delegate = self
        
        attachmentTextField.inputView = pickerView
        
        cityTextField.inputView = pickerView
        
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
        
        deviceDemoTextField.inputAccessoryView = toolBar
        deviceDemo2TextFeild.inputAccessoryView = toolBar
        deviceDemoTextFeild3.inputAccessoryView = toolBar
        attachmentTextField.inputAccessoryView = toolBar
        
        cityTextField.inputAccessoryView = toolBar
        
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
       
    }
    
    var isExpand : Bool = false
    
    @objc func keyboardAppear() {
        if !isExpand {
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 2500 )
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
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 2500 )
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
        }else if textField == BGSreadingTextField{
            maxLength = 8
        }else if textField == contactNumTextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
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
       
        self.deviceDemoTextField.resignFirstResponder()
        self.deviceDemo2TextFeild.resignFirstResponder()
        self.deviceDemoTextFeild3.resignFirstResponder()
        self.attachmentTextField.resignFirstResponder()
        self.cityTextField.resignFirstResponder()
       
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if deviceDemoTextField.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?.count ?? 0)!
        }
        else if deviceDemo2TextFeild.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?.count ?? 0)!
        }
        else if deviceDemoTextFeild3.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?.count ?? 0)!
        }else if cityTextField.isFirstResponder{
            return (self.patientResult?.educationalActivityViewModel?.educationalActivityCity?.count ?? 0)!
        }else if attachmentTextField.isFirstResponder{
            return (self.Attachment.count)
        }
        
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         if deviceDemoTextField.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
        }else if deviceDemo2TextFeild.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
        }else if deviceDemoTextFeild3.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
        }else if cityTextField.isFirstResponder{
            return self.patientResult?.educationalActivityViewModel?.educationalActivityCity?[row].name
        }else if attachmentTextField.isFirstResponder{
            return self.Attachment[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if deviceDemoTextField.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
            deviceDemoTextField.text = itemselected
            self.deviceDemoId = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].id
        }else if deviceDemo2TextFeild.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
            deviceDemo2TextFeild.text = itemselected
            self.deviceDemoId2 = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].id
        }else if deviceDemoTextFeild3.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].name
            deviceDemoTextFeild3.text = itemselected
            self.deviceDemoId3 = self.patientResult?.educationalActivityViewModel?.educationalActivityDevice?[row].id
        }else if cityTextField.isFirstResponder{
            let itemselected = self.patientResult?.educationalActivityViewModel?.educationalActivityCity?[row].name
            cityTextField.text = itemselected
        }else if attachmentTextField.isFirstResponder{
            let itemselected = self.Attachment[row]
            attachmentTextField.text = itemselected
        }
        
        
        if attachmentTextField.text == "Yes" {
            viewImageOutlet.isHidden = false
            whiteViewOutlet.isHidden = true
            self.scrollView.isScrollEnabled = true
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
        let providedCity = cityTextField.text
        let providedAddress = addressTextField.text
        let providedDeviceDemo = deviceDemoTextField.text
        let providedDeviceDemo2 = deviceDemo2TextFeild.text
        let providedDeviceDemo3 = deviceDemoTextFeild3.text
        let provideAttachment = attachmentTextField.text
        let provideBGS = BGSreadingTextField.text
        let isHardCopy = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ishardselect)
        let isExplained = CommonUtils.getJsonFromUserDefaults(forKey: Constants.isexplainedselect)
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
       
        
        if providedPatientName == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Patient Name")
            return
        }
        if contactNumTextField.text!.count < 11 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the Complete Contact Number")
            return
        }
        
        if contactNumTextField.text!.count > 19 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the less than 20 Number in Contact Number")
            return
        }
       
        if providedContact == nil || providedContact == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Contact Number")
            return
        }
        
        if providedCity == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the City")
            return
        }
        if providedAddress == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Address")
            return
        }
        
        if providedDeviceDemo == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Device Demo 1")
            return
        }
        
        
        
        if provideBGS == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Blood Sugar Screening")
            return
        }
       
        
        if rating == nil {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Rating Stars")
            return
        }
        
        let abcd = deviceDemoId2
        
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
        
        
        
        let patientfield = providedPatientName
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.validate, withJson: patientfield ?? "")
        
        let imagePath = self.patientConsentUrl
        
        if (self.currentCall?.clinicActivity == nil) { self.currentCall?.clinicActivity = [] }
        
        self.currentCall?.clinicActivity?.append(ClinicActivity(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        let index = (self.currentCall?.clinicActivity?.count ?? 0) - 1
        currentCall?.clinicActivity![index].patientName = providedPatientName
        currentCall?.clinicActivity![index].patientType = ""
        currentCall?.clinicActivity![index].address1 = providedAddress
        currentCall?.clinicActivity![index].address2 = ""
        currentCall?.clinicActivity![index].contactNumber1 = providedContact
        currentCall?.clinicActivity![index].contactNumber2 = ""
//        currentCall?.clinicActivity![index].patientConsentAttachmentUrl = imagePath
        currentCall?.clinicActivity![index].ClinicActivityGuid = CommonUtils.getJsonFromUserDefaults(forKey: Constants.patientUuid2)
        currentCall?.clinicActivity![index].patientConsent = true
        currentCall?.clinicActivity![index].bloodGlucose = provideBGS
        currentCall?.clinicActivity![index].bloodPressure = ""
        currentCall?.clinicActivity![index].hbA1c = ""
        currentCall?.clinicActivity![index].feedbackStars = "\(rating ?? 0)"
        currentCall?.clinicActivity![index].weight = ""
        currentCall?.clinicActivity![index].city = providedCity
        currentCall?.clinicActivity![index].iNovoId = ""
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
       
        
        currentCall?.clinicActivity![index].currentProductList![0].deviceId = self.deviceDemoId
        currentCall?.clinicActivity![index].currentProductList![0].deviceDemo = true
        
        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
       
        
        currentCall?.clinicActivity![index].currentProductList![1].deviceId = self.deviceDemoId2
        currentCall?.clinicActivity![index].currentProductList![1].deviceDemo = self.device
        
        
        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
       
        
        currentCall?.clinicActivity![index].currentProductList![2].deviceId = self.deviceDemoId3
        currentCall?.clinicActivity![index].currentProductList![2].deviceDemo = self.device2
        
        self.currentCall?.clinicActivity![index].concomitantProductList = []
        self.currentCall?.clinicActivity![index].concomitantProductList!.append(ConcomitantProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantProductList![0].productId = self.currentNNId
        
        self.currentCall?.clinicActivity![index].concomitantProductList!.append(ConcomitantProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantProductList![1].productId = self.currentNNId
        
        self.currentCall?.clinicActivity![index].concomitantProductList!.append(ConcomitantProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantProductList![2].productId = self.currentNNId
        
        self.currentCall?.clinicActivity![index].concomitantOtherProductList = []
        self.currentCall?.clinicActivity![index].concomitantOtherProductList!.append(ConcomitantOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantOtherProductList![0].otherProductId = self.currentNNId
        
        self.currentCall?.clinicActivity![index].previousProductList = []
        self.currentCall?.clinicActivity![index].previousProductList!.append(PreviousProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].previousProductList![0].productId = self.currentNNId
        
        self.currentCall?.clinicActivity![index].previousOtherProductList = []
        self.currentCall?.clinicActivity![index].previousOtherProductList!.append(PreviousOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].previousOtherProductList![0].otherProductId = self.currentNNId
        
        
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
        
        var data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.imgPostData2)
        if (data == "") {data = "[]"}
        
        var callImages:[ImagesCallsModel] = Mapper<ImagesCallsModel>().mapArray(JSONString: data)!
        
        var callImage = ImagesCallsModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        callImage?.Guid = CommonUtils.getJsonFromUserDefaults(forKey: Constants.patientUuid2)
        callImage?.PatinetConsentAttachmentUrl = self.filePathWithName?.absoluteString
        
        callImages.append(callImage!)
        
        let imageJsonString = Mapper().toJSONString(callImages)!
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.imgPostData2, withJson: imageJsonString)
        
        namefeild.text = ""
        contactNumTextField.text = ""
        cityTextField.text = ""
        addressTextField.text = ""
        deviceDemoTextField.text = ""
        deviceDemo2TextFeild.text = ""
        deviceDemoTextFeild3.text = ""
        BGSreadingTextField.text = ""
        self.selectedTopic?.isExplained = false
        self.selectedTopic?.isHardcopy = false
        
    }
    
    @IBAction func onSaveBtnClicked(_ sender: Any) {
        
        let provideAttachment2 = attachmentTextField.text
        
        if provideAttachment2 == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Patient Consent")
            return
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
        
        self.currentCall?.clinicActivity![index].currentProductList!.append(CurrentProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        if self.currentNNId != nil {
        currentCall?.clinicActivity![index].currentProductList![0].productId = self.currentNNId
        currentCall?.clinicActivity![index].currentProductList![0].deviceId = self.deviceDemoId
        currentCall?.clinicActivity![index].currentProductList![0].dose = self.dosId
        currentCall?.clinicActivity![index].currentProductList![0].deviceDemo = false
        currentCall?.clinicActivity![index].currentProductList![0].Frequency = self.freqId
        
        
        }
       
        self.currentCall?.clinicActivity![index].concomitantProductList = []
        self.currentCall?.clinicActivity![index].concomitantProductList!.append(ConcomitantProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantProductList![0].productId = self.concomitantProId
        
        self.currentCall?.clinicActivity![index].concomitantOtherProductList = []
        self.currentCall?.clinicActivity![index].concomitantOtherProductList!.append(ConcomitantOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].concomitantOtherProductList![0].otherProductId = self.concomitantOtherproId
        
        self.currentCall?.clinicActivity![index].previousProductList = []
        self.currentCall?.clinicActivity![index].previousProductList!.append(PreviousProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].previousProductList![0].productId = self.previousNNId
        
        self.currentCall?.clinicActivity![index].previousOtherProductList = []
        self.currentCall?.clinicActivity![index].previousOtherProductList!.append(PreviousOtherProductList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].previousOtherProductList![0].otherProductId = self.previousOtherId
        
        self.currentCall?.clinicActivity![index].discussionTopicList = []
        self.currentCall?.clinicActivity![index].discussionTopicList!.append(DiscussionTopicList(map: Map(mappingType: .fromJSON, JSON: [:]))!)
        
        currentCall?.clinicActivity![index].discussionTopicList![0].discussionTopicId = self.selectedTopic?.id
        currentCall?.clinicActivity![index].discussionTopicList![0].explained = selectedTopic?.isExplained ?? false
        currentCall?.clinicActivity![index].discussionTopicList![0].hardCopyProvided = selectedTopic?.isHardcopy ?? false
        
        self.onPatientAdded?(self.currentCall)
        
        self.dismiss(animated: true, completion: nil)
        
        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage:"successfully submitted")
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.isexplainedselect, withJson: "false")
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ishardselect, withJson: "false")
        
        
        var data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.imgPostData2)
        if (data == "") {data = "[]"}
        
        var callImages:[ImagesCallsModel] = Mapper<ImagesCallsModel>().mapArray(JSONString: data)!
        
        var callImage = ImagesCallsModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        callImage?.Guid = CommonUtils.getJsonFromUserDefaults(forKey: Constants.patientUuid2)
        callImage?.PatinetConsentAttachmentUrl = self.filePathWithName?.absoluteString
        
        callImages.append(callImage!)
        
        let imageJsonString = Mapper().toJSONString(callImages)!
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.imgPostData2, withJson: imageJsonString)
        
        
        
        namefeild.text = ""
        contactNumTextField.text = ""
        cityTextField.text = ""
        addressTextField.text = ""
        deviceDemoTextField.text = ""
        deviceDemo2TextFeild.text = ""
        deviceDemoTextFeild3.text = ""
        BGSreadingTextField.text = ""
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

//extension EducationalActivityViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
