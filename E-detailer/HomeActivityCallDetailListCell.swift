//
//  HomeActivityCallDetailListCell.swift
//  E-detailer
//
//  Created by Macbook Air on 09/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit

class HomeActivityCallDetailListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [HomeCallResult] = [];
    var type: String = "0";
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeActivityCallDetailListCell", for: indexPath) as! HomeActivityCallDetailListCellView
        
        list.patientNameLabel.text = dataList[indexPath.item].homeActivityPatientName
        list.DoctorNameLabel.text = dataList[indexPath.item].homeActivityDoctorName
        list.startTimeLabel.text = dataList[indexPath.item].homeActivityStartTime
        list.endTimeLabel.text = dataList[indexPath.item].homeActivityEndTime
        
        return list;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items: [HomeCallResult]?, type: String = "0") {
        self.dataList = items ?? []
        self.type = type
    }
    
}

public class HomeActivityCallDetailListCellView: UICollectionViewCell {
    
    
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var DoctorNameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    
}

