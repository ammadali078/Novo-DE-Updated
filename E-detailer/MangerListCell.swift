//
//  MangerListCell.swift
//  E-detailer
//
//  Created by Ammad on 8/15/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit
import BEMCheckBox

class ManagerListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [Productmanagers] = [];
    var selectedList : Dictionary<Int, Productmanagers> = Dictionary()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "ManagerListCell", for: indexPath) as! ManagerListCellView
        list.managerListLabel.text =  "\(dataList[indexPath.item].pM_Name ?? "") (\(dataList[indexPath.item].designation ?? ""))"
        list.model = dataList[indexPath.item]
        list.mCheckBox.delegate = list
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
    
    func setItems (items: [Productmanagers]?) {
        self.dataList = items!
    }
    
}

class ManagerListCellView: UICollectionViewCell,BEMCheckBoxDelegate {
    
    var model : Productmanagers?
    
    @IBOutlet weak var managerListLabel: UILabel!
    @IBOutlet weak var mCheckBox: BEMCheckBox!
    var checkBoxDelegate: BEMCheckBoxDelegate? = nil
    var onSelect : ((_ index: Int, _ isSelected: Bool) -> Void)? = nil
    var index: Int = 0
    
    func didTap(_ checkBox: BEMCheckBox) {
        onSelect!(index, checkBox.on)
        
    }
}
