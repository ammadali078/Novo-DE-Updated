//
//  DoctorViewController.swift
//  E-detailer
//
//  Created by Ammad on 12/31/04.
//  Copyright © 2004 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import WebKit

class DoctorViewController: UIViewController {
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var allPLannedDocBtn: UIButton!
    @IBOutlet weak var allDoctorsBtn: UIButton!
    @IBOutlet weak var DoctorListLayout: UIView!
    @IBOutlet weak var DoctorListCollectionView: UICollectionView!
    @IBOutlet weak var PlannedDoctorListCollectionView: UICollectionView!
    @IBOutlet weak var allDoctorView: UIView!
    @IBOutlet weak var allPatientView: UIView!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    var DoctorListDataSource: DoctorListCell!
    var plannedDoctorListDataSource: PlannedDoctorListCell!
    var delegate: (([DoctorResult]) -> Void)? = nil
    var delegate2: (([Msrplan]) -> Void)? = nil
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var OpenType = "0"
    var msrData = [Msrplan]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        let result = formatter.string(from: date)
        self.currentDateLabel.text = result
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        DoctorListDataSource = DoctorListCell()
        DoctorListCollectionView.dataSource = DoctorListDataSource
        
        self.allPatientView.isHidden = false
        self.allDoctorView.isHidden = true
        
        plannedDoctorListDataSource = PlannedDoctorListCell()
        PlannedDoctorListCollectionView.dataSource = plannedDoctorListDataSource

        allDoctorsBtn.layer.cornerRadius = 10
        allDoctorsBtn.clipsToBounds = true
        allPLannedDocBtn.layer.cornerRadius = 10
        allPLannedDocBtn.clipsToBounds = true
        saveBtn.layer.cornerRadius = 10
        saveBtn.clipsToBounds = true
        PlannedDoctorListCollectionView.isHidden = false
        
        DoctorListCollectionView.isHidden = true
        
        callApi()
        getPlannedDoc()
    }
    
    func callApi() {
        
        activitiyViewController.show(existingUiViewController: self)
        
        let callApi = CallApi()
        callApi.getAllDoctors(url: Constants.DoctorApi, completionHandler: {(doctorModel: DoctorModel?, error: String?) in
            
            if (error != nil) {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: error!)
                return
            }
            // On Response
            self.activitiyViewController.dismiss(animated: false, completion: nil)
            if doctorModel != nil {
                if (doctorModel?.success)! {
                    self.DoctorListDataSource.setItems(items: doctorModel?.result)
                    self.DoctorListCollectionView.reloadData()
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (doctorModel?.error!)!)
                }
            } else {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
            }
        })
    }
    
    func getPlannedDoc() {
        activitiyViewController.show(existingUiViewController: self)
        
        let callApi = CallApi()
        callApi.getAllPlannedDoctors(url: Constants.getAllPlannedDoc, completionHandler: {(plannedDoctorModel: PlannedDoctorModel?, error: String?) in
            
            if (error != nil) {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: error!)
                return
            }
            // On Response
            self.activitiyViewController.dismiss(animated: false, completion: nil)
            if plannedDoctorModel != nil {
                if (plannedDoctorModel?.success)! {
                    let dataList = plannedDoctorModel?.result?.msrplan
                    for i in 0..<dataList!.count{
                        let days = dataList?[i].day ?? 0
                        var day = ""
                        if days < 10{
                            day = "0\(days)"
                        }else{
                            day = "\(days)"
                        }
                        let date = "\(dataList?[i].year ?? 0)/\(dataList?[i].month ?? 0)/\(day)"
                        let convertedDate = CommonUtils.stringDate(dateString: date)
                        let currentDate = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy/M/dd"
                        let results = formatter.string(from: currentDate)
                        //                        self.msrData.removeAll()
                        if date == results{
                            self.msrData.append(dataList![i])
                        }else{
                        }
                    }
                    
                    self.plannedDoctorListDataSource.setItems(items: self.msrData)
                    self.PlannedDoctorListCollectionView.reloadData()
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (plannedDoctorModel?.error!)!)
                }
            } else {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
            }
        })
    }
    
    @IBAction func BTN_Update(_ sender: Any) {
        callApi()
    }
    
    @IBAction func allDoctorBtn(_ sender: Any) {
        self.DoctorListCollectionView.isHidden = true
        self.PlannedDoctorListCollectionView.isHidden = false
        self.OpenType = "0"
        self.allPatientView.isHidden = false
        self.allDoctorView.isHidden = true
        self.currentDateLabel.isHidden = false
    }
    
    @IBAction func plannedDoctorBtn(_ sender: Any) {
        self.DoctorListCollectionView.isHidden = false
        self.PlannedDoctorListCollectionView.isHidden = true
        self.OpenType = "1"
        self.allPatientView.isHidden = true
        self.allDoctorView.isHidden = false
        self.currentDateLabel.isHidden = false
    }
    
    @IBAction func onDoctorSave(_ sender: Any) {
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ConstantNO, withJson: "0")
        
        if OpenType == "0" {
            
            if self.plannedDoctorListDataSource.selectedList.count == 0 && self.DoctorListDataSource.selectedList.count == 0 {
                
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please select atleast one Doctor")
                return
                
            }else if self.plannedDoctorListDataSource.selectedList.count != 1 && self.DoctorListDataSource.selectedList.count != 1 {
                
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please select only one Doctor")
                return
                
            }else if self.plannedDoctorListDataSource.selectedList.count == 1 && self.DoctorListDataSource.selectedList.count == 1 {
                
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please select only one Doctor")
                return
                
            }else {
                
                CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Do you want to start Camp with this Doctor", controller: self, onYesClicked: {()
                    
                    let selectedDoctors = self.plannedDoctorListDataSource.selectedList
                    self.dismiss(animated: true, completion: {() in
                        let arrayFromDic = Array(selectedDoctors.values.map{ $0 })
                        self.delegate2!(arrayFromDic)
                    })
                    
                }, onNoClicked: {()
                    return
                })
            }
            
        }else {
            
            if self.DoctorListDataSource.selectedList.count == 0 && self.plannedDoctorListDataSource.selectedList.count == 0 {
                
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please select atleast one Doctor")
                return
                
            }else if self.DoctorListDataSource.selectedList.count != 1 && self.plannedDoctorListDataSource.selectedList.count != 1 {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please select only one Doctor")
                return
                
            }else if self.plannedDoctorListDataSource.selectedList.count == 1 && self.DoctorListDataSource.selectedList.count == 1 {
                
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Please select only one Doctor")
                return
                
            }else {
                
                CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Do you want to start Camp with this Doctor", controller: self, onYesClicked: {()
                    
                    let list = self.DoctorListDataSource.dataList
                    let selectedDoctors = self.DoctorListDataSource.selectedList
                    self.dismiss(animated: true, completion: {() in
                        let arrayFromDic = Array(selectedDoctors.values.map{ $0 })
                        (self.delegate)?(arrayFromDic)
                    })
                }, onNoClicked: {()
                    return
                })
            }
        }
    }
    
    @IBAction func onBackClick(_ sender: Any) {
        
        CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Do you want to exit", controller: self, onYesClicked: {()
            self.dismiss(animated: true, completion: nil)
        }, onNoClicked: {()
            return
        })
    }
}
