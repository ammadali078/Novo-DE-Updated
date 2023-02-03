//
//  StatisticsListCell.swift
//  E-detailer
//
//  Created by Ammad on 8/16/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit

class StatisticsListCell: NSObject, UICollectionViewDataSource {
    
    var dataList:  [MissedDoctorsInformationList] = [];
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "StatisticsListCell", for: indexPath) as! StatisticsListCellView
        
        list.doctorCodeLabel.text = dataList[indexPath.item].doccode
        list.doctorNameLabel.text = dataList[indexPath.item].docName
        list.genderLabel.text = dataList[indexPath.item].gender
        list.specificationLabel.text = dataList[indexPath.item].spec
        list.brickNameLabel.text = dataList[indexPath.item].brickName
        list.frequencyLabel.text = "\(dataList[indexPath.item].frequency!)"
        return list;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items:  [MissedDoctorsInformationList]?) {
        self.dataList = items!
    }
}
class StatisticsListCellView: UICollectionViewCell {
    
    @IBOutlet weak var doctorCodeLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var specificationLabel: UILabel!
    @IBOutlet weak var brickNameLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    
    
}
