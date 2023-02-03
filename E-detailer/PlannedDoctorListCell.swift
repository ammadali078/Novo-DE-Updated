//
//  PlannedDoctorListCell.swift
//  E-detailer
//
//  Created by Macbook Air on 30/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import BEMCheckBox

class PlannedDoctorListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [Msrplan] = [];
    var selectedList : Dictionary<Int, Msrplan> = Dictionary()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "PlannedDoctorListCell", for: indexPath) as! PlannedDoctorListCellView
        
        list.doctorNameLabel.text = dataList[indexPath.item].name
        list.morningPracticeLabel.text = dataList[indexPath.item].visitPeriod
        list.doctorBrickLabel.text = dataList[indexPath.item].brickName
        list.mCheckBox.delegate = list
        list.index = indexPath.item
        list.onSelect = {(index: Int, isSelected: Bool) in
            if isSelected {
                self.selectedList[index] = self.dataList[index]
                //                self.selectedList.append(self.dataList[index])
            } else {
                
                self.selectedList.removeValue(forKey: index)
                //                self.selectedList.remove(at: index)
            }
        }
        
        return list;
    }
    
    func stringDate(dateString: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items: [Msrplan]?) {
        self.dataList = items ?? []
    }
}

class PlannedDoctorListCellView: UICollectionViewCell, BEMCheckBoxDelegate {
    
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorBrickLabel: UILabel!
    @IBOutlet weak var morningPracticeLabel: UILabel!
    @IBOutlet weak var mCheckBox: BEMCheckBox!
    
    var checkBoxDelegate: BEMCheckBoxDelegate? = nil
    var onSelect : ((_ index: Int, _ isSelected: Bool) -> Void)? = nil
    var index: Int = 0
    
    func didTap(_ checkBox: BEMCheckBox) {
        onSelect!(index, checkBox.on)
        //
    }
    
    
}
