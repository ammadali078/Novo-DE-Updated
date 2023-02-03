//
//  HomeActivityVisitDetailListCell.swift
//  E-detailer
//
//  Created by Macbook Air on 09/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit

class HomeActivityVisitDetailListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [HomeVisitResult] = [];
    var type: String = "0";
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeActivityVisitDetailListCell", for: indexPath) as! HomeActivityVisitDetailListCellView
        
        list.patientNameLabel.text = dataList[indexPath.item].homeActivityPatientName
        list.doctorNameLabel.text = dataList[indexPath.item].homeActivityDoctorName
        list.startTimeLabel.text = dataList[indexPath.item].homeActivityStartTime
        list.endTimeLabel.text = dataList[indexPath.item].homeActivityEndTime
        
        if dataList[indexPath.item].homeActivityProduct == [] {
            
            list.productNameLabelView.text = "No Product"
            
        }else {
            
            list.productNameLabelView.text = dataList[indexPath.item].homeActivityProduct![0]
            
        }
        
        
        
        return list;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items: [HomeVisitResult]?, type: String = "0") {
        self.dataList = items ?? []
        self.type = type
    }
    
}

public class HomeActivityVisitDetailListCellView: UICollectionViewCell {
    
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var productNameLabelView: UILabel!
    
}

