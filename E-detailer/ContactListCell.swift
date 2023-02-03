//
//  ContactListCell.swift
//  E-detailer
//
//  Created by Ammad on 8/11/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit

class ContactListCell: NSObject, UICollectionViewDataSource {
    
    var onClick: ((ContactResult) -> Void)? = nil
    var dataList: [ContactResult] = [];
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactListCell", for: indexPath) as! ContactListCellView
        
        list.listLabelView.text = dataList[indexPath.item].dESCR
        list.onClick = onClick
        list.model = dataList[indexPath.item]
        
        return list;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items: [ContactResult]?) {
        self.dataList = items!
    }
    
}

class ContactListCellView: UICollectionViewCell {
    
    @IBOutlet weak var mMarkLabelView: UILabel!
    var onClick: ((ContactResult) -> Void)? = nil
    var model : ContactResult?
    
    @IBOutlet weak var listLabelView: UILabel!
    
    
    @IBAction func onMarkClicked(_ sender: Any) {
        onClick!(model!)
        mMarkLabelView.text = "Marked"
    }
    
}



