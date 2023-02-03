//
//  PatientDetailCell.swift
//  E-detailer
//
//  Created by Macbook Air on 06/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit

class PatientDetailCell: NSObject, UICollectionViewDataSource {
    
    var dataList: CallModel?;
    var type: String = "0";
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "PatientDetailCell", for: indexPath) as! PatientDetailCellView
       
        if dataList?.clinicActivity?.count == nil {

            list.patientNameLabel.text = ""

        }else {

            list.patientNameLabel.text = dataList?.clinicActivity![indexPath.row].patientName
        }
//
        
        return list;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataList?.clinicActivity?.count ?? 0);
    }
    
    func setItems (items: CallModel?, type: String = "0") {
        self.dataList = items!
        self.type = type
    }
   
}

public class PatientDetailCellView: UICollectionViewCell {
   
    @IBOutlet weak var patientNameLabel: UILabel!
    
    
}
