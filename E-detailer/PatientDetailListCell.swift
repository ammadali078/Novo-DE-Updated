//
//  PatientDetailListCell.swift
//  E-detailer
//
//  Created by Macbook Air on 24/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit

class PatientDetailListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [PatientDetail] = [];
    var type: String = "0";
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "PatientDetailListCell", for: indexPath) as! PatientDetailListCellView
        let index = indexPath.row
        
        let patient = dataList[index]
        
        list.doctorNameLabelView.text = patient.doctorName
        list.productNameLabelView.text = patient.productName
        
        list.planDateLabelview.text = patient.planDate
        list.scheduleTypeLabelview.text = patient.scheduleType
        list.patientNameLabelView.text = patient.patientName
        
        return list;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items: [PatientDetail]?, type: String = "0") {
        self.dataList = items!
        self.type = type
    }
    
}

public class PatientDetailListCellView: UICollectionViewCell {
    
    
    @IBOutlet weak var patientNameLabelView: UILabel!
    @IBOutlet weak var doctorNameLabelView: UILabel!
    @IBOutlet weak var planDateLabelview: UILabel!
    @IBOutlet weak var productNameLabelView: UILabel!
    @IBOutlet weak var scheduleTypeLabelview: UILabel!
    
}
