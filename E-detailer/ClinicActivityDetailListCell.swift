//
//  ClinicActivityDetailListCell.swift
//  E-detailer
//
//  Created by Macbook Air on 08/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit

class ClinicActivityDetailListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [CallDetailResult] = [];
    var type: String = "0";
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "ClinicActivityDetailListCell", for: indexPath) as! ClinicActivityDetailListCellView
        
        list.doctorNameLabel.text = dataList[indexPath.item].doctorName
        list.startTimeLabel.text = dataList[indexPath.item].callStartTime
        list.endTimeLabel.text = dataList[indexPath.item].callEndTime
        list.patientCountLabelView.text = "\(dataList[indexPath.item].patientCount ?? 0)"
        
        
        return list;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items: [CallDetailResult]?, type: String = "0") {
        self.dataList = items ?? []
        self.type = type
    }
    
}

public class ClinicActivityDetailListCellView: UICollectionViewCell {
    
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var patientCountLabelView: UILabel!
    
}
