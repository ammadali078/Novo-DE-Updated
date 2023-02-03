//
//  CallDetailViewController.swift
//  E-detailer
//
//  Created by Macbook Air on 25/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import RLBAlertsPickers
import ActionSheetPicker_3_0
import DatePickerDialog

class CallDetailViewController: UIViewController {
    
//    @IBOutlet weak var doctorNameLabelView: UILabel!
//    @IBOutlet weak var patientNameLabelView: UILabel!
    
    @IBOutlet weak var callDetailLayOut: UIView!
    @IBOutlet weak var CallDetailCollectionView: UICollectionView!
    @IBOutlet weak var PatientDetailCollectionView: UICollectionView!
    var CallDetailDataSource: CallDetailCell!
    var PatientDetailDataSource : PatientDetailCell!
    var selectedIndex: CallModel?
    var selectedTab: String = "0"
//    var array : [CallModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

//        self.array = selectedIndex
        
                CallDetailDataSource = CallDetailCell()
                CallDetailCollectionView.dataSource = CallDetailDataSource
        
        CallDetailDataSource.setItems(items: selectedIndex, type: selectedTab)
        CallDetailCollectionView.reloadData()
        
        PatientDetailDataSource = PatientDetailCell()
        PatientDetailCollectionView.dataSource = PatientDetailDataSource
        
        PatientDetailDataSource.setItems(items: selectedIndex, type: selectedTab)
        PatientDetailCollectionView.reloadData()
        
    }
    
    @IBAction func onBackClick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
