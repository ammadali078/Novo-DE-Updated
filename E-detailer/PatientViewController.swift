//
//  PatientViewController.swift
//  E-detailer
//
//  Created by Macbook Air on 08/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import RLBAlertsPickers
import ActionSheetPicker_3_0
import DatePickerDialog
import WebKit
import RealmSwift
import SwiftyJSON

class PatientViewController: UIViewController {
    
    @IBOutlet weak var patientListCollectionView: UICollectionView!
    @IBOutlet weak var allPatientView: UIView!
    @IBOutlet weak var plannedPatientView: UIView!
    @IBOutlet weak var showDatePlanLabel: UILabel!
    @IBOutlet weak var dropDownImg: UIImageView!
    @IBOutlet weak var plannedBtnOutlet: UIButton!
    @IBOutlet weak var allPatientBtnOutlet: UIButton!
    @IBOutlet weak var refreshBtnOutlet: UIButton!
    @IBOutlet weak var syncViewOutlet: UIView!
    
    var plannedPatientDataSource: PlannedPatientListCell!
    var indicator: UIActivityIndicatorView!
    var Educalls: [HomeActivity] = []
    var activitiyViewController: ActivityViewController!
    var selectedTab: String = "0"
    var allPatients: PatientModel?
    var plannedPatients: PlannedPatientModel?
    var selectedPatient: PlannedPatients? = nil
    var selectedPlan: Patients?
    var OpenType = "0";
    var abc = "0";
    var dropDownInfo : PatientResult?
    var homeCurrentCall: HomeCallModel? = nil
    var callImages:[HomeImageCallModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        syncViewOutlet.layer.cornerRadius = 15
        syncViewOutlet.clipsToBounds = true
        
        syncViewOutlet.isUserInteractionEnabled = true
        
        refreshBtnOutlet.isUserInteractionEnabled = false
        //getCurrentDate
        let date = Date()
        let formatter = DateFormatter()
        let apiformatter = DateFormatter()
        apiformatter.dateFormat = "yyyy-MM-dd"
        
        formatter.dateFormat = "dd-MM-YYYY"
        let result = formatter.string(from: date)
        let apiResult = apiformatter.string(from: date)
        self.showDatePlanLabel.text = result
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.appDate, withJson: result)
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.selectedDate, withJson: apiResult)
        self.allPatientBtnOutlet.isUserInteractionEnabled = false
        self.showDatePlanLabel.isHidden = true
        self.dropDownImg.isHidden = true
        
        self.plannedBtnOutlet.isUserInteractionEnabled = false
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        
        plannedPatientDataSource = PlannedPatientListCell()
        plannedPatientDataSource.onStartClick = {patient in
            self.onStartClick(patient: patient)
        }
        
        plannedPatientDataSource.onPlanClick = {(planner: Patients) in
            self.selectedPlan = planner
        }
        
        plannedPatientDataSource.onCancelClick = {patient in
            self.onCancelClick(patient: patient)
            
        }
        
        plannedPatientDataSource.onReschuledClick = {sender, patient in
            self.onReschuledClick(sender, patient: patient)
        }
        
        patientListCollectionView.dataSource = plannedPatientDataSource
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateInfo()
        }
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.key, withJson: "1")
        
        activitiyViewController.show(existingUiViewController: self)
        let callApi = CallApi()
        callApi.getAllPatient(url: Constants.GetPatientDataApi, completionHandler: {(getPatientDataModel: GetPatientDataModel?, error: String?) in
            
            if (error != nil) {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: error!)
                return
            }
            
            self.activitiyViewController.dismiss(animated: false, completion: nil)
            // On Response
            
            //temp variable
            let getPatientDataModelCopy =  getPatientDataModel
            
            //On Dialog Close
            if getPatientDataModelCopy != nil {
                
                if (getPatientDataModelCopy?.success)! {
                    
                    self.dropDownInfo = getPatientDataModelCopy?.result
                    
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (getPatientDataModel?.error!)!)
                }
            } else {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Please check your Internet connection")
            }
        })
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        syncViewOutlet.isUserInteractionEnabled = true
        let date = Date()
        let formatter = DateFormatter()
        let apiformatter = DateFormatter()
        apiformatter.dateFormat = "yyyy-MM-dd"
        
        formatter.dateFormat = "dd-MM-YYYY"
        let result = formatter.string(from: date)
        let apiResult = apiformatter.string(from: date)
        self.showDatePlanLabel.text = result
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.selectedDate, withJson: apiResult)
        
        if OpenType == "1" {
            self.showDatePlanLabel.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.appDate2)
        }
        
    }
    
    func updateInfo()  {
        
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        let date = CommonUtils.getJsonFromUserDefaults(forKey: Constants.selectedDate)
        switch selectedTab {
        case "0":
            if (allPatients == nil) {
                updatePatients(apiName: String(format: Constants.AllPatientsApi, userId))
            } else {
                plannedPatientDataSource.setItemsofPatient(items: allPatients!.result, type: selectedTab)
                patientListCollectionView.reloadData()
            }
            break
            
        case "1":
            if (plannedPatients == nil) {
                updatePatients(apiName: String(format: Constants.PlannedPatientsApi, userId, date))
            } else if (plannedPatients != nil) {
                updatePatients(apiName: String(format: Constants.PlannedPatientsApi, userId, date))
            }
            break
            
        default:
            print("no case found")
        }
    }
    
    @objc func onReschuledDateSelected(_ date: Date) {
        activitiyViewController.show(existingUiViewController: self)
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        var params = Dictionary<String, Any>()
        
        params["HomeActivityPlanId"] = selectedPatient?.id;
        params["RescheduleTo"] = dateFormatterGet.string(from: date);
        params["RescheduleReason"] = "true";
        
        // Api Executed
        Alamofire.request(Constants.PatientReschuledApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    let loginModel = Mapper<LoginModel>().map(JSONString: response.value!) //JSON to model
                    
                    if loginModel != nil {
                        
                        if (loginModel?.success)! {
                            CommonUtils.showToast(controller: self, message: "Rescheduled successful", seconds: 2)
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (loginModel?.error!)!)
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                })
            })
    }
    
    func onReschuledClick(_ sender: UIButton, patient: PlannedPatients)  {
        selectedPatient = patient
        let currentDate = Date()
        var dateComponent = DateComponents()
        
        dateComponent.year = 100
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        let datePicker = ActionSheetDatePicker(title: "Rescheduled date",
                                               datePickerMode: UIDatePicker.Mode.date,
                                               selectedDate: Date(),
                                               minimumDate: Date(),
                                               maximumDate: futureDate,
                                               target: self,
                                               action: #selector(onReschuledDateSelected(_:)),
                                               origin: sender)
        datePicker?.minuteInterval = 20
        
        if #available(iOS 13.4, *) {
            datePicker?.datePickerStyle = .automatic
        }
        
        datePicker?.show()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        if (id == "OnSiteSegue") {
            let visitController: VisitViewController = segue.destination as! VisitViewController
            visitController.selectedPatient = selectedPatient
        }else if id == "DiscussWithPatientSegue"{
            let visitController: DiscussionPatientViewController = segue.destination as! DiscussionPatientViewController
            visitController.selectedPatient = selectedPatient
        }else if (id == "SendToPatientDetailScreen"){
            let destination = segue.destination as! PatientDetailViewController
            destination.selectedPlan = self.selectedPlan
        }
    }
    
    func onStartClick(patient: PlannedPatients)  {
        
        self.selectedPatient = patient
        
        let planObjective = patient.planObjective
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.Objective, withJson: planObjective ?? "")
        
        if patient.scheduleType == "Visit" {
            self.performSegue(withIdentifier: "OnSiteSegue", sender: self)
        } else {
            self.performSegue(withIdentifier: "DiscussWithPatientSegue", sender: self)
        }
    }
    
    func onCancelClick(patient: PlannedPatients)  {
        let alert = UIAlertController(style: .alert, title: "Cancel Plan")
        let config: TextField.Config = { textField in
            textField.becomeFirstResponder()
            textField.textColor = .black
            textField.placeholder = "Reason of Cancellation"
            textField.leftViewPadding = 12
            textField.backgroundColor = nil
            textField.keyboardAppearance = .default
            textField.keyboardType = .default
            textField.isSecureTextEntry = false
            textField.returnKeyType = .done
            textField.action { textField in
                // validation and so on
                let reason = textField.text
                var params = Dictionary<String, Any>()
                
                params["HomeActivityPlanId"] = patient.id
                params["CancelReason"] = reason
                
                // Api Executed
                Alamofire.request(Constants.PatientCancelApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                    .responseString(completionHandler: {(response) in
                        // On Response
                        self.activitiyViewController.dismiss(animated: false, completion: {() in
                            //On Dialog Close
                            if (response.error != nil) {
                                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                                return
                            }
                            
                            let loginModel = Mapper<LoginModel>().map(JSONString: response.value!) //JSON to model
                            
                            if loginModel != nil {
                                if (loginModel?.success)! {
                                    self.abc = "1"
                                    
                                    CommonUtils.showToast(controller: self, message: "Cancel Successful", seconds: 2)
                                    
                                } else {
                                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (loginModel?.error!)!)
                                }
                            } else {
                                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                            }
                        })
                    })
            }
            
        }
        
        alert.addOneTextField(configuration: config)
        alert.addAction(title: "OK", style: .cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func updatePatients(apiName: String) {
        activitiyViewController.show(existingUiViewController: self)
        Alamofire.request(apiName, method: .get, encoding: JSONEncoding.default, headers: nil)
        //            .responseString(completionHandler: {(response) in
            .responseJSON(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    //                    let contentModel = Mapper<PatientModel>().map(JSONString: response.value!) //JSON to model
                    let res = JSON(response.result.value)
                    let realm = try! Realm()
                    if self.selectedTab == "0"{
                        var model = PatientModel()
                        try! realm.write {
                            //                        let model = PatientModel()
                            model.updateModelWithJSON(json: res)
                            realm.add(model)
                        }
                        if model != nil{
                            if model.error == "" {
                                
                                self.plannedBtnOutlet.isUserInteractionEnabled = true
                                self.allPatients = PatientModel.getPatientData()
                                self.updateInfo()
                                self.refreshBtnOutlet.isUserInteractionEnabled = true
                                self.allPatientBtnOutlet.isUserInteractionEnabled = true
                                
                            } else {
                                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                            }
                            
                        }
                    }else{
                        var model = PlannedPatientModel()
                        try! realm.write {
                            //                        let model = PatientModel()
                            model.updateModelWithJSON(json: res)
                            realm.add(model)
                        }
                        if model != nil{
                            if model.error == "" {
                                
                                self.refreshBtnOutlet.isUserInteractionEnabled = true
                                self.plannedBtnOutlet.isUserInteractionEnabled = true
                                self.plannedPatients = PlannedPatientModel.getPLannedPatientData()
                                
                                self.plannedPatientDataSource.setItemsofPlannedPatient(items:   self.plannedPatients!.result, type: self.selectedTab)
                                self.patientListCollectionView.reloadData()
                                //                                self.updateInfo()
                                
                            } else {
                                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                            }
                            
                        }
                    }
                    
                })
            })
    }
    
    @IBAction func allPatientBtn(_ sender: Any) {
        selectedTab = "1"
        updateInfo()
        self.allPatientView.isHidden = true
        self.plannedPatientView.isHidden = false
        self.showDatePlanLabel.isHidden = false
        if OpenType == "1" {
            self.showDatePlanLabel.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.appDate2)
        }else {
            
            self.showDatePlanLabel.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.appDate)
        }
        self.dropDownImg.isHidden = false
    }
    
    @IBAction func plannedPatientBtn(_ sender: Any) {
        selectedTab = "0"
        updateInfo()
        self.allPatientView.isHidden = false
        self.plannedPatientView.isHidden = true
        self.showDatePlanLabel.isHidden = true
        self.dropDownImg.isHidden = true
        
        showDatePlanLabel.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.appDate)
        
    }
    
    @IBAction func onRefreshClick(_ sender: Any) {
        
        allPatients = nil
        plannedPatients = nil
        updateInfo()
        if OpenType == "1" {
            self.showDatePlanLabel.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.appDate)
        }
    }
    
    @IBAction func onChangeDateClick(_ sender: Any) {
        
        self.OpenType = "1"
        DatePickerDialog().show("Plan Visit", doneButtonTitle: "Search",cancelButtonTitle: "Cancel", minimumDate: Date(), datePickerMode: .date) { date in
            if let dt = date {
                
                let formatter = DateFormatter()
                let apiFormatter = DateFormatter()
                apiFormatter.dateFormat = "yyyy-MM-dd"
                formatter.dateFormat = "dd-MM-YYYY"
                let planPasteDate = formatter.string(from: dt)
                let apiPlanPasteDate = apiFormatter.string(from: dt)
                self.showDatePlanLabel.text = planPasteDate
                
                CommonUtils.saveJsonToUserDefaults(forKey: Constants.appDate2, withJson: planPasteDate)
                CommonUtils.saveJsonToUserDefaults(forKey: Constants.selectedDate, withJson: apiPlanPasteDate)
                self.updateInfo()
                
            }
        }
    }
    
    @IBAction func syncBtn(_ sender: Any) {
        syncViewOutlet.isUserInteractionEnabled = false
        
        
        if syncViewOutlet.isUserInteractionEnabled == false {
            
            let aa = ""
        }else {
            
            let aaa = "1"
        }
        
        HomeCallApi()
        
    }
    
    func HomeCallApi() {
        
       
        
        let Eudata = CommonUtils.getJsonFromUserDefaults(forKey: Constants.HomeUploadKey)
        
        if Eudata == "" || Eudata == "[]" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Data available to preview")
            syncViewOutlet.isUserInteractionEnabled = true
            return
           
        }
        
        Educalls = Mapper<HomeActivity>().mapArray(JSONString: Eudata)!
        
        var homeReq = HomeCallModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        homeReq?.homeActivity = Educalls
        
        let HomeCall = homeReq?.toJSON()
        
        //        MSLActivityApi
        Alamofire.request(Constants.SyncHomeActivity, method: .post, parameters: HomeCall, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        self.syncViewOutlet.isUserInteractionEnabled = true
                        return
                    }
                    
                    if (response.value == "1"){
                        
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.HomeUploadKey, withJson: "[]")

                            self.ImageUpload()
                      
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: response.value!)
                    }
                })
            })
        
    }
    
    func ImageUpload() {
        
        let homeImages = CommonUtils.getJsonFromUserDefaults(forKey: Constants.homeImgPostData)
        
        callImages = Mapper<HomeImageCallModel>().mapArray(JSONString: homeImages)!
        
        if callImages.count == 0 {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Image available to sync")
            return
        }
        
        activitiyViewController.show(existingUiViewController: self)
        Alamofire.upload(multipartFormData: {m in
            
            for (index, body) in self.callImages.enumerated() {
                
                m.append((body.Guid ?? "").data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "model[\(index)].Guid")
                
                
                if body.PatinetConsentAttachmentUrl == nil {
                    
                    m.append(("").data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "model[\(index)].PatinetConsentAttachmentUrl")
                    
                }else{
                    
                    m.append(URL(string: body.PatinetConsentAttachmentUrl ?? "")!, withName: "model[\(index)].PatinetConsentAttachmentUrl")
                }
                
              
                
             
                if body.PrescriptionConsentAttachmentUrl == nil {
                    
                    m.append(("").data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "model[\(index)].PrescriptionConsentAttachmentUrl")
                    
                }else {
                    
                    m.append(URL(string: body.PrescriptionConsentAttachmentUrl ?? "")!, withName: "model[\(index)].PrescriptionConsentAttachmentUrl")
                 
                    
                }
                
            }
        }, to: Constants.HomePostImageApi, encodingCompletion:{result in
            
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response.result.value)
                    
                    self.activitiyViewController.dismiss(animated: true, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    let loginModel = Mapper<LoginModel>().map(JSONObject: response.result.value) //JSON to model
                    
                    if loginModel != nil {
                        
                        if (loginModel?.success)! {
                            
                            self.syncViewOutlet.isUserInteractionEnabled = true
                            
                            CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Form submit successfully", onOkClicked: {()
                                
                                
                                CommonUtils.saveJsonToUserDefaults(forKey: Constants.homeImgPostData, withJson: "[]")
                                
                                self.dismiss(animated: true, completion: nil)
                                
                            })
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (loginModel?.error!)!)
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                    }
                        
                    })
                    
                }
                
            case .failure(let encodingError):
                print(encodingError)
                
                self.activitiyViewController.dismiss(animated: true, completion: {() in
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Sorry, Something went wrong")
                })
            }
            
        })
        
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
