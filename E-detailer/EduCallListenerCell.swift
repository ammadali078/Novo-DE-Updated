//
//  EduCallListenerCell.swift
//  E-detailer
//
//  Created by macbook on 15/05/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit

class EduCallListenerCell: NSObject, UICollectionViewDataSource {
    
    var callList: [CallModel] = [];
    var onDetailClick: ((CallModel) -> Void)? = nil
    var deleteCallback: ((Int) -> Void)? = nil
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EduCallListenerCell", for: indexPath) as! EduCallListenerCellView
      
        
        let call = callList[indexPath.item]
        cell.deleteCallback = deleteCallback;
        cell.index = indexPath.row;
        cell.callModel = call
        cell.onDetailClick = onDetailClick
        var doctorNames = "";
        for doc in call.callDoctors! {
            doctorNames = doctorNames + doc.docName! + ","
        }
        
        cell.doctorNameLabelView.text = "Doctor name(s): \(doctorNames)"
        cell.doctorCountLabelView.text = "\(call.callDoctors!.count)"
        if call.clinicActivity?.count != nil {
            
            cell.patientCountLabel.text = "\(call.clinicActivity!.count)"
        }
        var managerCount:Int = (call.callProductManagers?.count) ?? 0
        
        if call.managerId != nil && call.managerId != ""{
            managerCount += 1
        }
        
        if call.sMId != nil && call.sMId != ""{
            managerCount += 1
        }
        cell.startTimeLabelView.text = "\(CommonUtils.getDateFromTimeStamp(timeStamp: Double(call.startTime!)!))"
        cell.endTimeLabelView.text = "\(CommonUtils.getDateFromTimeStamp(timeStamp: Double(call.endTime!)!))"
        
        return cell;
    }
    
    func setItems(calls: [CallModel]){
        callList = calls;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return callList.count;
    }
}

class EduCallListenerCellView: UICollectionViewCell {
    
    //    @IBOutlet weak var callSessionLabelView: UILabel!
//    @IBOutlet weak var edaSessionLabeView: UILabel!
    @IBOutlet weak var doctorNameLabelView: UILabel!
    @IBOutlet weak var startTimeLabelView: UILabel!
    @IBOutlet weak var endTimeLabelView: UILabel!
    //    @IBOutlet weak var edaSessionCountLabelView: UILabel!
    @IBOutlet weak var patientCountLabel: UILabel!
    
    var onDetailClick: ((CallModel) -> Void)? = nil
    var callModel: CallModel? = nil
    var deleteCallback: ((Int) -> Void)? = nil
    var index: Int?
    
    @IBAction func deleteBtn(_ sender: Any) {
        
    }
    @IBOutlet weak var doctorCountLabelView: UILabel!
    //    @IBOutlet weak var managerCountLabelView: UILabel!
    @IBAction func managerAddBtn(_ sender: Any) {
        
    }
    @IBAction func doctorAddBtn(_ sender: Any) {
        
    }
    @IBAction func callDetailBtn(_ sender: Any) {
        onDetailClick!(callModel!)
    }
    @IBAction func onDeleteClick(_ sender: Any) {
        self.deleteCallback!(index!)
    }
    
    
}
