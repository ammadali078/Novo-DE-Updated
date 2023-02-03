//
//  DoctorListCell.swift
//  E-detailer
//
//  Created by Ammad on 8/13/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit
import BEMCheckBox

class DoctorListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [DoctorResult] = [];
    var selectedList : Dictionary<Int, DoctorResult> = Dictionary()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "DoctorListCell", for: indexPath) as! DoctorListCellView
        
        list.doctorListLabel.text = dataList[indexPath.item].name
        list.doctorDayLabel.text = dataList[indexPath.item].morningAddress
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items: [DoctorResult]?) {
        self.dataList = items!
    }
}

class DoctorListCellView: UICollectionViewCell, BEMCheckBoxDelegate {
    @IBOutlet weak var doctorBrickLabel: UILabel!
    @IBOutlet weak var doctorDayLabel: UILabel!
    @IBOutlet weak var doctorListLabel: UILabel!
    @IBOutlet weak var mCheckBox: BEMCheckBox!
    var checkBoxDelegate: BEMCheckBoxDelegate? = nil
    var onSelect : ((_ index: Int, _ isSelected: Bool) -> Void)? = nil
    var index: Int = 0
    
    func didTap(_ checkBox: BEMCheckBox) {
        onSelect!(index, checkBox.on)
        //
    }
    
}
