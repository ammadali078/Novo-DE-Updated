//
//  PatientActivityDetailListCell.swift
//  E-detailer
//
//  Created by Macbook Air on 09/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit

class PatientActivityDetailListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [PatientActivityResult] = [];
    var type: String = "0";
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "PatientActivityDetailListCell", for: indexPath) as! PatientActivityDetailListCellView
        
        if dataList[indexPath.item].products == nil || dataList[indexPath.item].products == [] {
            
            list.productNameLabelView.text = "No Product"
            
        }else {
            
            list.productNameLabelView.text = dataList[indexPath.item].products![0]
            
        }
        
        list.patientNameLabel.text = dataList[indexPath.item].patientName
        list.doctorNameLabel.text = dataList[indexPath.item].doctorName
        list.startTimeLabel.text = dataList[indexPath.item].callStartTime
        list.endTimeLabel.text = dataList[indexPath.item].callEndTime
        
        
        
        
        
        return list;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items: [PatientActivityResult]?, type: String = "0") {
        self.dataList = items ?? []
        self.type = type
    }
    
}

public class PatientActivityDetailListCellView: UICollectionViewCell {
    
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var productNameLabelView: UILabel!
    
    
    
}
