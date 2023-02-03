//
//  PatientAddViewController.swift
//  E-detailer
//
//  Created by Macbook Air on 09/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class PatientAddViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var activitiyViewController: ActivityViewController!
    
    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var doctorTextField: UITextField!
    @IBOutlet weak var patientNameTextField: UITextField!
    @IBOutlet weak var contactNumber2TextField: UITextField!
    @IBOutlet weak var constactNumberTextfield: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var iNovoIdTextField: UITextField!
    @IBOutlet weak var typeOfPatientTextField: UITextField!
    @IBOutlet weak var currentDateLabelView: UILabel!
    
    var typePickerView: UIPickerView?
    var doctorPickerView: UIPickerView?
    var productPickerView: UIPickerView?
    var cityPickerView: UIPickerView?
    var doctorControls: DoctorPickerControls?
    var productControls: ProductPickerControls?
    var cityControls: CityPickerControls?
    var selectedPatientType: String?
    var PatientType = ["New", "Repeat"]
    var maxLength : Int?
    
    override func viewDidLoad() {
        
        // getCurrentDate
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        currentDateLabelView.text = result
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        
        typePickerView = UIPickerView()
        typePickerView = setupTypePicker(pickerView: typePickerView!, field: typeOfPatientTextField,  action: #selector(self.donePicker))
        
        typePickerView?.delegate = self
        typePickerView?.dataSource = self
        
        patientNameTextField.delegate = self
        constactNumberTextfield.delegate = self
        contactNumber2TextField.delegate = self
        addressTextField.delegate = self
        address2TextField.delegate = self
        cityTextField.delegate = self
        iNovoIdTextField.delegate = self
        typeOfPatientTextField.delegate = self
        typeOfPatientTextField.inputView = typePickerView!
        
        doctorPickerView = UIPickerView()
        doctorPickerView = setupTypePicker(pickerView: doctorPickerView!, field: doctorTextField, action: #selector(self.doctorDonePicker))
        
        doctorControls = DoctorPickerControls()
        
        doctorControls?.doctorPatientTextField = doctorTextField
        doctorControls?.dataList = []
        doctorControls?.pickerView = doctorPickerView
        
        doctorPickerView?.delegate = doctorControls
        doctorPickerView?.dataSource = doctorControls
        doctorTextField.delegate = doctorControls
        doctorTextField.inputView = doctorPickerView!
        
        productPickerView = UIPickerView()
        cityPickerView = UIPickerView()
        
        productPickerView = setupTypePicker(pickerView: productPickerView!, field: productTextField, action: #selector(self.productDonePicker))
        
        cityPickerView = setupTypePicker(pickerView: cityPickerView!, field: cityTextField, action: #selector(self.cityDonePicker))

        productControls = ProductPickerControls()
        cityControls = CityPickerControls()
        productControls?.productPatientTextField = productTextField
        cityControls?.cityPatientTextField = cityTextField
        productControls?.dataList = []
        cityControls?.dataList = []
        productControls?.pickerView = productPickerView
        cityControls?.pickerView = cityPickerView
        
        productPickerView?.delegate = productControls
        cityPickerView?.delegate = cityControls
        productPickerView?.dataSource = productControls
        cityPickerView?.dataSource = cityControls
        productTextField.delegate = productControls
        cityTextField.delegate = cityControls
        productTextField.inputView = productPickerView!
        cityTextField.inputView = cityPickerView!
        
        callDoctorApi()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.callProductApi()
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == patientNameTextField{
            maxLength = 30
        }else if textField == addressTextField{
            maxLength = 200
        }else if textField == address2TextField{
            maxLength = 200
        }else if textField == cityTextField{
            maxLength = 30
        }else if textField == iNovoIdTextField{
            maxLength = 20
        }
        
        if textField == constactNumberTextfield {

            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }else  if textField == contactNumber2TextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            maxLength = 20
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        let currentString: NSString = textField.text! as NSString
        
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength ?? 0
    }
    
    func callProductApi() {
        activitiyViewController.show(existingUiViewController: self)
        CallApi().getAllPatient(url: Constants.GetPatientDataApi, completionHandler: {(getPatientDataModel: GetPatientDataModel?, error: String?) in
            self.activitiyViewController.dismiss(animated: false, completion: { 
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
                        
                        self.productControls?.dataList = getPatientDataModel?.result?.educationalActivityViewModel?.educationalActivityProduct
                        self.productPickerView?.reloadAllComponents()
                        self.cityControls?.dataList = getPatientDataModel?.result?.educationalActivityViewModel?.educationalActivityCity
                        self.cityPickerView?.reloadAllComponents()
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (getPatientDataModel?.error!)!)
                    }
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                }
            })
        })
    }
    func callDoctorApi() {
        
        let callApi = CallApi()
        callApi.getAllDoctors(url: Constants.DoctorApi, completionHandler: {(doctorModel: DoctorModel?, error: String?) in
            
            if (error != nil) {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: error!)
                return
            }
            // On Response
            if doctorModel != nil {
                if (doctorModel?.success)! {
                    self.doctorControls?.dataList = doctorModel?.result
                    self.doctorPickerView?.reloadAllComponents()
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (doctorModel?.error!)!)
                }
            } else {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
            }
        })
    }
    
    func setupTypePicker(pickerView: UIPickerView, field: UITextField, action: Selector?) -> UIPickerView {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action:action)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: action)
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        field.inputAccessoryView = toolBar
        
        return pickerView
    }
    
    
    
    @IBAction func onPatientCreated(_ sender: Any) {
        
       
        
        let selectedDoctor = doctorControls?.selectedDoctor
        let selectedProduct = productControls?.selectedProduct
        let selectedPatientType = self.selectedPatientType
        
        let name = patientNameTextField.text
        let contact2 = contactNumber2TextField.text
        let contact = constactNumberTextfield.text
        let add = addressTextField.text
        let add2 = address2TextField.text
        let city = cityControls?.selectedCity
        let novoId = iNovoIdTextField.text
        
        if name == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter the Patient Name")
            return
        }
        if contact == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter the Contact Number 1")
            return
        }
        if contact2 == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter the Contact Number 2")
            return
        }
        if constactNumberTextfield.text!.count < 11 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the Complete Contact Number 1")
            return
        }
        
        if constactNumberTextfield.text!.count > 19 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the less than 20 number in Contact Number 1")
            return
        }
        
        if contactNumber2TextField.text!.count < 11 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the Complete Contact Number 2")
            return
        }
        
        if contactNumber2TextField.text!.count > 19 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Warning", withMessage: "Please Enter the less than 20 number in Contact Number 2")
            return
        }

        if cityTextField.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter the city")
            return
        }
        if add == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter the Address 1")
            return
        }
        if add2 == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter the Address 2")
            return
        }
        
        if novoId == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please enter the iNovo ID")
            return
        }
        if typeOfPatientTextField.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Patient type")
            return
        }
        
        if productTextField.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Product")
            return
        }
        
        if doctorTextField.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Doctor")
            return
        }
       
        
        var params = Dictionary<String, Any>()
        
        params["name"] = name
        params["productId"] = selectedProduct?.id
        params["EmployeeExternalId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        params["doctorId"] = selectedDoctor?.id
        params["iNovoId"] = novoId
        params["patientType"] = selectedPatientType?.lowercased()
        params["contactNumber1"] = contact
        params["contactNumber2"] = contact2
        params["city"] = city?.name
        params["address1"] = add
        params["address2"] = add2
        
        // Api Executed
        Alamofire.request(Constants.CreatePatientApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    let loginModel = Mapper<LoginModel>().map(JSONString: response.value!) //JSON to model
                    
                    if loginModel != nil {
                        if (loginModel?.success)! {
                            CommonUtils.showToast(controller: self, message: "Patient added successfully!", seconds: 3)
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: (loginModel?.error!)!)
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Empty Response is coming from server")
                    }
                })
            })
        
        
        self.patientNameTextField.text = ""
        self.constactNumberTextfield.text = ""
        self.contactNumber2TextField.text = ""
        self.addressTextField.text = ""
        self.address2TextField.text = ""
        self.cityTextField.text = ""
        self.iNovoIdTextField.text = ""
        self.productTextField.text = ""
        self.doctorTextField.text = ""
        self.typeOfPatientTextField.text = ""
        
    }
    
    @IBAction func onBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func productDonePicker(){
        self.productTextField.resignFirstResponder()
    }
    
    @objc func cityDonePicker(){
        self.cityTextField.resignFirstResponder()
    }
    
    @objc func doctorDonePicker(){
        self.doctorTextField.resignFirstResponder()
    }
    
    @objc func donePicker(){
        self.typeOfPatientTextField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.typePickerView?.reloadAllComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if typeOfPatientTextField.isFirstResponder{
            return (self.PatientType.count)
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if typeOfPatientTextField.isFirstResponder{
            return self.PatientType[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if typeOfPatientTextField.isFirstResponder{
            let itemselected = self.PatientType[row]
            typeOfPatientTextField.text = itemselected
            selectedPatientType = itemselected
        }
    }
    
}

class DoctorPickerControls : NSObject, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var doctorPatientTextField: UITextField!
    var dataList: [DoctorResult]? = []
    var selectedDoctor:DoctorResult? = nil
    var pickerView: UIPickerView?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if doctorPatientTextField.isFirstResponder {
            return (self.dataList?.count ?? 0)
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if doctorPatientTextField.isFirstResponder{
            return self.dataList?[row].name
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if doctorPatientTextField.isFirstResponder{
            let itemselected = self.dataList![row]
            selectedDoctor = itemselected
            doctorPatientTextField.text = itemselected.name
        }
    }
}

class ProductPickerControls : NSObject, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var productPatientTextField: UITextField!
    var dataList: [EducationalActivityProduct]? = []
    var selectedProduct:EducationalActivityProduct? = nil
    var pickerView: UIPickerView?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if productPatientTextField.isFirstResponder {
            return (self.dataList?.count ?? 0)
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if productPatientTextField.isFirstResponder{
            return self.dataList?[row].name
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if productPatientTextField.isFirstResponder {
            let itemselected = self.dataList![row]
            selectedProduct = itemselected
            productPatientTextField.text = itemselected.name
        }
    }
}
class CityPickerControls : NSObject, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var cityPatientTextField: UITextField!
    var dataList: [EducationalActivityCity]? = []
    var selectedCity:EducationalActivityCity? = nil
    var pickerView: UIPickerView?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if cityPatientTextField.isFirstResponder {
            return (self.dataList?.count ?? 0)
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if cityPatientTextField.isFirstResponder{
            return self.dataList?[row].name
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if cityPatientTextField.isFirstResponder {
            let itemselected = self.dataList![row]
            selectedCity = itemselected
            cityPatientTextField.text = itemselected.name
        }
    }
}
