//
//  HomeActivityPatientDetailListCell.swift
//  E-detailer
//
//  Created by Macbook Air on 10/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit

class HomeActivityPatientDetailListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [HomePatientResult] = [];
    var type: String = "0";
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeActivityPatientDetailListCell", for: indexPath) as! HomeActivityPatientDetailListCellView
        
        if dataList[indexPath.item].homeActivityProduct == "" {
            
            list.productnameLabel.text = "No Product"
            
        }else {
            
            list.productnameLabel.text = dataList[indexPath.item].homeActivityProduct
            
        }
        
        list.patientNameLabel.text = dataList[indexPath.item].homeActivityPatientName
        list.doctorNameLabel.text = dataList[indexPath.item].homeActivityDoctorName
        
        list.startTimeLabel.text = dataList[indexPath.item].homeActivityTime
        
        return list;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items: [HomePatientResult]?, type: String = "0") {
        self.dataList = items ?? []
        self.type = type
    }
    
}

public class HomeActivityPatientDetailListCellView: UICollectionViewCell {
    
    
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var productnameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    
}

