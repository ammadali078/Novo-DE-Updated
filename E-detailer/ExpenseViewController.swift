//
//  ExpenseViewController.swift
//  E-detailer
//
//  Created by macbook on 14/12/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import BEMCheckBox
import Photos
import Cosmos

class ExpenseViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var expenseTypeTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var notetextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var onImageClicked: UIButton!
    @IBOutlet weak var cityDropDown: UIImageView!
    @IBOutlet weak var desDropDown: UIImageView!
    
    var expences = [ExpenseTypes]()
    let datePicker = UIDatePicker()
    var imagePicker = UIImagePickerController()
    var selectedImageData: Data?
    var expenseCode = ""
    let picker1 = UIPickerView()
    var amount = Double()
    var expenseId = ""
    let ExpensedatePicker = UIDatePicker()
    var empcity = [Emp_city]()
    var filtercity = [Emp_city]()
    var isCity = "0"
    var selectedCity = [String]()
    var destinationId = [Int]()
    var expCity = [ExpenseModel]()
    var filePathWithName: URL?
    var fileName: String? = ""
    
    override func viewDidLoad() {
        
        let json = CommonUtils.getJsonFromUserDefaults(forKey: Constants.getCity)
        empcity = Mapper<Emp_city>().mapArray(JSONString: json == "" ? "[]" : json)!
        self.expenseTypeTextField.inputView = UIView()
        self.expenseTypeTextField.inputAccessoryView = UIView()
        imagePicker.delegate = self
        self.TableView.allowsSelection = true
        self.ExpensedatePicker.maximumDate = Date()
        
        self.showDatePicker()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ExpenseViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        self.addDoneButtonOnKeyboard()
        callSamAndExpApi()
        self.createPickerView()
        self.cityTextField.isHidden = true
        self.destinationTextField.isHidden = true
        self.cityDropDown.isHidden = true
        self.desDropDown.isHidden = true
       
    }
    
    func showDatePicker(){
        //Formate Date
        ExpensedatePicker.datePickerMode = .date
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = ExpensedatePicker
    }
    
    @objc func donedatePicker(){
        
        
        
        
        
        let formatter = DateFormatter()
        let apiFormatter = DateFormatter()
        apiFormatter.dateFormat = "MM-dd-yyyy"
        formatter.dateFormat = "dd-MM-YYYY"
        let planPasteDate = formatter.string(from: ExpensedatePicker.date)
        let apiPlanPasteDate = apiFormatter.string(from: ExpensedatePicker.date)
        self.dateTextField.text = planPasteDate
        
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.expDate, withJson: apiPlanPasteDate)
        
        
//        let Formatter = DateFormatter()
//        Formatter.dateFormat = "MM-dd-yyyy"
//
//        let strDate = Formatter.string(from: ExpensedatePicker.date)
//        dateTextField.text = strDate
        
//        CommonUtils.saveJsonToUserDefaults(forKey: Constants.appDate2, withJson: planPasteDate)
//        CommonUtils.saveJsonToUserDefaults(forKey: Constants.selectedDate, withJson: apiPlanPasteDate)
        self.view.endEditing(true)
        
//        let Formatter = DateFormatter()
//        Formatter.dateFormat = "MM-dd-yyyy"
//
//        let strDate = Formatter.string(from: ExpensedatePicker.date)
//        dateTextField.text = strDate
//
//        CommonUtils.saveJsonToUserDefaults(forKey: Constants.expDate, withJson: strDate)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        
        view.endEditing(true)
    }
    
    func callSamAndExpApi(){
        
        let callApi = CallApi()
        callApi.getSampleAndExpense(url: Constants.SampleAndExpenseApi, isRequiredNetworkCall: false, completionHandler: {(sampleAndExpenseModel: SampleAndExpenseModel?, error: String?) in
            
            if (error != nil) {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: error!)
                return
            }
            if sampleAndExpenseModel != nil {
                if (sampleAndExpenseModel?.success)! {
                    
                    self.expences = sampleAndExpenseModel?.result?.expenseTypes as! [ExpenseTypes]
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: (sampleAndExpenseModel?.error!)!)
                }
            }else{
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Empty Response is coming from server")
            }
        })
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.amountTextField.inputAccessoryView = doneToolbar
        
    }
    
    func createToolbar()
    {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = UIColor.blue
        toolbar.backgroundColor = UIColor.white
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ExpenseViewController.isclosePickerView))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closePickerView));
        toolbar.setItems([doneButton,cancelButton,spaceButton], animated: false)
        toolbar.isUserInteractionEnabled = true
     expenseTypeTextField.inputAccessoryView = toolbar
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == self.cityTextField){
            self.TableView.isHidden = false
            self.isCity = "1"
            self.TableView.reloadData()
            
        }else if textField == destinationTextField{
            self.TableView.isHidden = false
            destinationTextField.endEditing(true)
            self.isCity = "2"
            self.TableView.reloadData()
            
        }else{
            self.TableView.isHidden = true
            self.isCity = "0"
            self.TableView.reloadData()
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        if textField == self.expenseCityTextField{
        //            self.tblView.reloadData()
        //        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == self.cityTextField){
            self.filtercity = self.empcity.filter { $0.name?.range(of: textField.text ?? "", options: .caseInsensitive, range: nil, locale: nil) != nil }
            if textField.text == "" {
                // 3 if there is nothing to search, auxiliar receive the complete orihinal array
                filtercity = empcity
            }
            print(filtercity)
            TableView.reloadData()
        }
        return true
    }
    
    @objc func closePickerView()
    {
        self.expenseTypeTextField.text = ""
        self.view.endEditing(false)
        self.amountTextField.text = ""
        
    }
    
    @objc func isclosePickerView()
    {
        self.view.endEditing(true)
    }
    
    func createPickerView()
    {
        
        picker1.delegate = self
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = UIColor.blue
        toolbar.backgroundColor = UIColor.white
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ExpenseViewController.isclosePickerView))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closePickerView));
        toolbar.setItems([doneButton,cancelButton,spaceButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        expenseTypeTextField.inputAccessoryView = toolbar
        expenseTypeTextField.inputView = picker1
        //        picker1.backgroundColor = UIColor.white
        
    }
    
    @objc func doneButtonAction() {
        
        self.amountTextField.resignFirstResponder()
    }
    
    var getCity = CommonUtils.getJsonFromUserDefaults(forKey: Constants.getCity)
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let countrows = self.expences.count
        
        return countrows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return (self.expences[row]).expenseType
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.expenseTypeTextField.text = self.expences[row].expenseType
        self.expenseCode = self.expences[row].code!
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.expCode, withJson: self.expences[row].code!)
        self.expenseId = "\(self.expences[row].id ?? 0)"
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.expType, withJson:self.expences[row].expenseType!)
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.expTypeId, withJson: "\(self.expences[row].id ?? 0)")
        self.amountTextField.text = "\(self.expences[row].amount ?? 0)"
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.expAmount, withJson: "\(self.expences[row].amount ?? 0)")
        
        if expenseCode == "OA" {
            
            self.cityTextField.isHidden = false
            self.destinationTextField.isHidden = false
            self.cityDropDown.isHidden = false
            self.desDropDown.isHidden = false
            
            self.amountTextField.isHidden = true
        }else {
            
            self.cityTextField.isHidden = true
            self.destinationTextField.isHidden = true
            self.cityDropDown.isHidden = true
            self.desDropDown.isHidden = true
            self.amountTextField.isHidden = false
            self.amountTextField.isUserInteractionEnabled = false
            
        }
        
    }
    
    @IBAction func ImageBtnClicked(_ sender: Any) {
        
        CommonUtils.showQuesCameraButtons(title: "Novo", message: "Choose Image", controller: self, onYesClicked: {()
            self.openCamera()
            
        }, onNoClicked: {()
            
            self.openGallary()
        })
        
//        PHPhotoLibrary.requestAuthorization({
//            (newStatus) in
//            DispatchQueue.main.async(execute: { () -> Void in
//                if newStatus ==  PHAuthorizationStatus.authorized {
//                    UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
//                    print("Button capture")
//                    self.imagePicker.sourceType = .photoLibrary
//                    self.imagePicker.allowsEditing = true
//
//                    self.present(self.imagePicker, animated: true, completion: nil)
//
//                }
//            })
//        })
        
    }
    
    func openCamera()
        {
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
            {
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

        func openGallary()
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
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
    
    @IBAction func onSubmitClicked(_ sender: Any) {
        
        let providedDate = CommonUtils.getJsonFromUserDefaults(forKey: Constants.expDate)
        let providedAmount = amountTextField.text
        let providedNotes = notetextField.text
        //        let providedCity = CommonUtils.getJsonFromUserDefaults(forKey: Constants.expCityName)
        let providedCity = cityTextField.text
        let providedType = expenseTypeTextField.text
        let providedDestination = destinationTextField.text
        let providedCityId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.cityId)
        let providedDesId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.getDesId)
        let providedExpId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.expTypeId)
        let providedCode = CommonUtils.getJsonFromUserDefaults(forKey: Constants.expCode)
        
        if providedCode == "OA" {
            
            if self.fileName == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Receipt is required")
                return
                
            }
          
            if providedType == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select the Expense Type")
                return
            }
            
            if providedAmount == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Expense Amount")
                return
            }
            if providedDate == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Expense Date")
                return
            }
            if providedNotes == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Expense Notes")
                return
            }
            if providedCity == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select City")
                return
            }
            if providedDestination == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Select Destination")
                return
            }
            
        } else {
            
            if self.fileName == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Receipt is required")
                return
                
            }
            
            if providedType == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Expense Type")
                return
            }
            if providedAmount == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Expense Amount")
                return
            }
            if providedDate == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Expense Date")
                return
            }
            if providedNotes == "" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Expense Notes")
                return
            }
            if providedAmount == "0.0" {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please Enter the Valid Amount")
                return
            }
            
        }
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.expNotes, withJson: providedNotes ?? "Hello")
        
        var data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.expPostData)
        if (data == "") {data = "[]"}
        
        var callExpenses:[ExpenseModel] = Mapper<ExpenseModel>().mapArray(JSONString: data)!
        
        var callExpense = ExpenseModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        callExpense?.expenseType = providedType
        callExpense?.amount  = Double(providedAmount ?? "")
        callExpense?.cityId = Int(providedCityId)
        callExpense?.desName = providedDestination
        callExpense?.desId = Int(providedDesId)
        callExpense?.emp_City = providedCity
        callExpense?.notes = providedNotes
        callExpense?.id = Int(providedExpId)
        callExpense?.date = providedDate
        callExpense?.code = providedCode
        callExpense?.fileName = self.fileName
        callExpense?.filePath = self.filePathWithName?.absoluteString
        
        callExpenses.append(callExpense!)
        
        let expensesJsonString = Mapper().toJSONString(callExpenses)!
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.expPostData, withJson: expensesJsonString)
        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage:"successfully submitted")
        
        self.dateTextField.text = ""
        self.notetextField.text = ""
        self.amountTextField.text = ""
        self.cityTextField.text = ""
        self.dateTextField.text = ""
        self.destinationTextField.text = ""
        self.expenseTypeTextField.text = ""
        self.fileName = ""
        self.imageViewOutlet.image = UIImage(named: "selectImage")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension ExpenseViewController: UITableViewDelegate, UITableViewDataSource, EmpCityTableViewDelegate{
    
    
    func onLblPress(position: Int) {
        if self.isCity == "1"{
            let city = filtercity[position].name
            let cityId = filtercity[position].id
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.expCityName, withJson: city!)
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.cityId, withJson: "\(cityId ?? 0)")
            self.cityTextField.text = city
            let a = self.empcity.filter({ $0.name == city })
            self.selectedCity.append(contentsOf: a[0].desName)
            self.destinationId.append(contentsOf: a[0].desId)
            self.TableView.isHidden = true
            destinationTextField.text = ""
            destinationTextField.isUserInteractionEnabled = true
            cityTextField.resignFirstResponder()
        }else{
            let city = selectedCity[position]
            let selectedDesId = destinationId[position]
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.desName, withJson: city)
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.getDesId, withJson: "\(selectedDesId)")
            self.destinationTextField.text = city
            self.TableView.isHidden = true
            destinationTextField.isUserInteractionEnabled = false
            destinationTextField.resignFirstResponder()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isCity == "1"{
            return filtercity.count
        }else{
            return selectedCity.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmpCityViewCell", for: indexPath) as! EmpCityViewCell
        if self.isCity == "1"{
            cell.cityLbl.text = self.filtercity[indexPath.row].name
            cell.delegate = self
            cell.position = indexPath.row
        }else{
            cell.cityLbl.text = self.selectedCity[indexPath.row]
            cell.delegate = self
            cell.position = indexPath.row
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

