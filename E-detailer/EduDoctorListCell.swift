//
//  EduDoctorListCell.swift
//  E-detailer
//
//  Created by macbook on 15/05/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit
import BEMCheckBox

class EduDoctorListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [DoctorResult] = [];
    var selectedList : Dictionary<Int, DoctorResult> = Dictionary()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "EduDoctorListCell", for: indexPath) as! EduDoctorListCellView
        
        list.eduDoctorNameLabel.text = dataList[indexPath.item].name
//        list.doctorDayLabel.text = dataList[indexPath.item].morningAddress
        list.eduBrickNameLabel.text = dataList[indexPath.item].brickName
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

class EduDoctorListCellView: UICollectionViewCell, BEMCheckBoxDelegate {
    @IBOutlet weak var eduDoctorNameLabel: UILabel!
    @IBOutlet weak var eduBrickNameLabel: UILabel!
    @IBOutlet weak var mCheckBox: BEMCheckBox!
    var checkBoxDelegate: BEMCheckBoxDelegate? = nil
    var onSelect : ((_ index: Int, _ isSelected: Bool) -> Void)? = nil
    var index: Int = 0
    
    func didTap(_ checkBox: BEMCheckBox) {
        onSelect!(index, checkBox.on)
        //
    }
    
    //    func setModel(model: inout DoctorResult) {
    //        self.model = model
    //    }
    
}
