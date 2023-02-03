//
//  EduCallDetailCell.swift
//  E-detailer
//
//  Created by macbook on 16/05/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit

class EduCallDetailCell: NSObject, UICollectionViewDataSource {
    
    var dataList: CallModel?;
    var type: String = "0";
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "EduCallDetailCell", for: indexPath) as! EduCallDetailCellView
        
        list.doctorNameLabelView.text = dataList?.callDoctors![indexPath.row].docName
        list.doctorCountLabel.text = "\(indexPath.row + 1)" + " )"
        
        return list;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataList?.callDoctors!.count ?? 0);
    }
    
    func setItems (items: CallModel?, type: String = "0") {
        self.dataList = items!
        self.type = type
    }
   
}

public class EduCallDetailCellView: UICollectionViewCell {
   
    @IBOutlet weak var doctorNameLabelView: UILabel!
    @IBOutlet weak var doctorCountLabel: UILabel!
}
