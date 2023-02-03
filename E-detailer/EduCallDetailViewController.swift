//
//  EduCallDetailViewController.swift
//  E-detailer
//
//  Created by macbook on 16/05/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import RLBAlertsPickers
import ActionSheetPicker_3_0
import DatePickerDialog

class EduCallDetailViewController: UIViewController {
    
//    @IBOutlet weak var doctorNameLabelView: UILabel!
//    @IBOutlet weak var patientNameLabelView: UILabel!
    
    @IBOutlet weak var callDetailLayOut: UIView!
    @IBOutlet weak var CallDetailCollectionView: UICollectionView!
    @IBOutlet weak var PatientDetailCollectionView: UICollectionView!
    var CallDetailDataSource: EduCallDetailCell!
    var PatientDetailDataSource : EduPatientDetailCell!
    var selectedIndex: CallModel?
    var selectedTab: String = "0"
//    var array : [CallModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

//        self.array = selectedIndex
        
                CallDetailDataSource = EduCallDetailCell()
                CallDetailCollectionView.dataSource = CallDetailDataSource
        
        CallDetailDataSource.setItems(items: selectedIndex, type: selectedTab)
        CallDetailCollectionView.reloadData()
        
        PatientDetailDataSource = EduPatientDetailCell()
        PatientDetailCollectionView.dataSource = PatientDetailDataSource
        
        PatientDetailDataSource.setItems(items: selectedIndex, type: selectedTab)
        PatientDetailCollectionView.reloadData()
        
    }
    
    @IBAction func onBackClick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
