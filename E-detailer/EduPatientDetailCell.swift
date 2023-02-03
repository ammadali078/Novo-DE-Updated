//
//  EduPatientDetailCell.swift
//  E-detailer
//
//  Created by macbook on 16/05/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit

class EduPatientDetailCell: NSObject, UICollectionViewDataSource {
    
    var dataList: CallModel?;
    var type: String = "0";
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "EduPatientDetailCell", for: indexPath) as! EduPatientDetailCellView
       
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

public class EduPatientDetailCellView: UICollectionViewCell {
   
    @IBOutlet weak var patientNameLabel: UILabel!
    
    
}
