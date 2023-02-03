//
//  PlannedPatientListCell.swift
//  E-detailer
//
//  Created by Macbook Air on 08/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class PlannedPatientListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: List<Patients>?
    var plannedDataList: List<PlannedPatients>?
    var onStartClick: ((PlannedPatients) -> Void)? = nil
    var onPlanClick: ((Patients) -> Void)? = nil
    var onReschuledClick: ((UIButton, PlannedPatients) -> Void)? = nil
    var onCancelClick: ((PlannedPatients) -> Void)? = nil
    var type: String = "0";
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlannedPatientListCell", for: indexPath) as! PlannedPatientListCellView
        let index = indexPath.row
        
        cell.onStartClick = onStartClick
        cell.onPlanClick = onPlanClick
        cell.onCancelClick = onCancelClick
        cell.onReschuledClick = onReschuledClick
        
        if (type == "0") {
            
            let patient = dataList?[index]
            
            cell.patient = patient
            cell.patientNameLabelView.text = patient?.name
            cell.startCallButton.isHidden = true
            cell.rescheduleCallButton.isHidden = true
            cell.cancelCallButton.isHidden = true
            cell.statusTypeLabelView.isHidden = true
            cell.daySequenceLabelView.isHidden = true
            cell.doctorNameLabel.text = patient?.allDoctorName
            cell.productNameLabel.text = patient?.allProductName
            cell.planDetailBtnOutlet.isHidden = false
            cell.daySequenceLabelView.text = ""
            
        } else {
            
            let PlannedPatient = plannedDataList?[index]
            
            let ammad = PlannedPatient?.patientName
            cell.plannedPatient = PlannedPatient
            cell.patientNameLabelView.text = PlannedPatient?.patientName
            cell.statusTypeLabelView.isHidden = false
            cell.startCallButton.isHidden = false
            cell.rescheduleCallButton.isHidden = false
            cell.cancelCallButton.isHidden = false
            cell.daySequenceLabelView.isHidden = false
            cell.statusTypeLabelView.text = PlannedPatient?.scheduleType
            cell.doctorNameLabel.text = PlannedPatient?.doctorName
            cell.productNameLabel.text = PlannedPatient?.productName
            cell.planDetailBtnOutlet.isHidden = true
            if PlannedPatient?.daySequence == 0 {
                cell.daySequenceLabelView.text = ""
            }else {
                cell.daySequenceLabelView.text = "\(PlannedPatient?.daySequence ?? 0)"
            }
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if type == "0"{
            return dataList?.count ?? 0;
        }else {
            return plannedDataList?.count ?? 0;
        }
    }
    
    func setItemsofPatient (items: List<Patients>, type: String = "0") {
        dataList = items
        self.type = type
    }
    
    func setItemsofPlannedPatient (items: List<PlannedPatients>, type: String = "0") {
        plannedDataList = items
        self.type = type
    }
}

public class PlannedPatientListCellView: UICollectionViewCell {
    
    @IBOutlet weak var patientNameLabelView: UILabel!
    @IBOutlet weak var startCallButton: UIButton!
    @IBOutlet weak var cancelCallButton: UIButton!
    @IBOutlet weak var rescheduleCallButton: UIButton!
    @IBOutlet weak var statusTypeLabelView: UILabel!
    @IBOutlet weak var daySequenceLabelView: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var planDetailBtnOutlet: UIButton!
    var patient: Patients? = nil
    var plannedPatient: PlannedPatients? = nil
    var onStartClick: ((PlannedPatients) -> Void)? = nil
    var onPlanClick: ((Patients) -> Void)? = nil
    var onReschuledClick: ((UIButton,PlannedPatients) -> Void)? = nil
    var onCancelClick: ((PlannedPatients) -> Void)? = nil
    
    @IBAction func onClickCancel(_ sender: Any) {
        onCancelClick!(plannedPatient!)
    }
    @IBAction func onClickStartVisit(_ sender: Any) {
        onStartClick!(plannedPatient!)
    }
    @IBAction func onClickReschuledVisit(_ sender: Any) {
        onReschuledClick!(sender as! UIButton, plannedPatient!)
    }
    @IBAction func onPlanClicked(_ sender: Any) {
        onPlanClick!(patient!)
    }
    
}
