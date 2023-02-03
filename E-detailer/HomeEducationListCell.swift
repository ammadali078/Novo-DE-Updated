//
//  EducationListCell.swift
//  E-detailer
//
//  Created by Macbook Air on 10/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit
import BEMCheckBox

class HomeEducationListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [EducationalActivityDiscussionTopic] = [];
    var selectedList : Dictionary<Int, EducationalActivityDiscussionTopic> = Dictionary()
    var onSelect : ((_ index: EducationalActivityDiscussionTopic, _ isExplainedSelected: Bool, _ isHardCopySelected: Bool) -> Void)? = nil
    var OpenType = "0";
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeEducationListCellId", for: indexPath) as! HomeEducationListCellView
        list.nameTextView.text = self.dataList[indexPath.row].name
        list.explainationCheckBox.delegate = list
        list.hardCheckBox.delegate = list

        list.index = indexPath.item
        list.onSelect = {(index: Int, isExplainedSelected: Bool, isHardCopySelected: Bool) in
            if index == indexPath.item{
                if isExplainedSelected {
                                self.selectedList[index] = self.dataList[index]
                                self.onSelect!(self.dataList[index], isExplainedSelected, isHardCopySelected)
                            } else {
                                self.selectedList.removeValue(forKey: index)
                                self.onSelect!(self.dataList[index], isExplainedSelected, isHardCopySelected)
                            }

                            if isHardCopySelected {
                                self.selectedList[index] = self.dataList[index]
                                self.onSelect!(self.dataList[index], isExplainedSelected, isHardCopySelected)
                            } else {
                                self.selectedList.removeValue(forKey: index)
                                self.onSelect!(self.dataList[index], isExplainedSelected, isHardCopySelected)
                            }
            }

        }
        
        return list
    }
    
    func setItems(items: [EducationalActivityDiscussionTopic])  {
        dataList = items        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items: [EducationalActivityDiscussionTopic]?) {
        self.dataList = items!
    }
}

class HomeEducationListCellView: UICollectionViewCell, BEMCheckBoxDelegate {
    
    @IBOutlet weak var hardCheckBox: BEMCheckBox!
    @IBOutlet weak var explainationCheckBox: BEMCheckBox!
    @IBOutlet weak var nameTextView: UILabel!
        
    var checkBoxDelegate: BEMCheckBoxDelegate? = nil
    var onSelect : ((_ index: Int, _ isExplainedSelected: Bool, _ isHardCopySelected: Bool) -> Void)? = nil
    var index: Int?
    var OpenType = "0"

    func didTap(_ checkBox: BEMCheckBox) {
        if checkBox == explainationCheckBox{
            if checkBox.on == true{
                //2
                if self.OpenType == "0" {
                    onSelect!(index!, false, true)
                    OpenType = "1"
                }else {
                    onSelect!(index!, true, true)
                }
            }else{
                onSelect!(index!, true, false)
            }
        }else{
            //1
            if checkBox.on == true{
                if self.OpenType == "0" {
                    onSelect!(index!, true, false)
                    self.OpenType = "1"
                }else {
                    
                    onSelect!(index!, true, true)
                }
            }else{
                onSelect!(index!, false, true)
            }
        }

    }
}
