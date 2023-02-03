//
//  CallDetailCell.swift
//  E-detailer
//
//  Created by Macbook Air on 25/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit

class CallDetailCell: NSObject, UICollectionViewDataSource {
    
    var dataList: CallModel?;
    var type: String = "0";
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "CallDetailCell", for: indexPath) as! CallDetailCellView
        
        list.doctorNameLabelView.text = dataList?.callDoctors![indexPath.row].docName
        list.doctorCountLabel.text = "\(indexPath.row + 1)" + " )"
        
        return list;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataList?.callDoctors!.count)!;
    }
    
    func setItems (items: CallModel?, type: String = "0") {
        self.dataList = items!
        self.type = type
    }
   
}

public class CallDetailCellView: UICollectionViewCell {
   
    @IBOutlet weak var doctorNameLabelView: UILabel!
    @IBOutlet weak var doctorCountLabel: UILabel!
}
