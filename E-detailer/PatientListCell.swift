//
//  PatientListCell.swift
//  E-detailer
//
//  Created by Macbook Air on 08/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit


class PatientListCell: NSObject, UICollectionViewDataSource {
    
    var dataList: [PatientResult] = [];
    var selectedList : Dictionary<Int, PatientResult> = Dictionary()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = collectionView.dequeueReusableCell(withReuseIdentifier: "PatientListCell", for: indexPath) as! PatientListCellView
        
        
        return list;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func setItems (items: [DoctorResult]?) {
        //        self.dataList = items!
    }
}

class PatientListCellView: UICollectionViewCell {
    
    
    
    @IBOutlet weak var patientNameTextField: UILabel!
    
    
}
