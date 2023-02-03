//
//  PDFListCell.swift
//  E-detailer
//
//  Created by Ammad on 8/18/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit

class PDFListCell: NSObject, UICollectionViewDataSource {
    
    var onClick: ((Documents) -> Void)? = nil
    var pdfList:  [Documents] = [];
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PDFListCell", for: indexPath) as! PDFListCellView
        cell.onClickListener = onClick
        let documentObj = pdfList[indexPath.item];
        cell.model = documentObj
        cell.pdfLabelView.text = documentObj.name;
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pdfList.count;
    }
}

class PDFListCellView: UICollectionViewCell {
    
    var onClickListener: ((Documents) -> Void)? = nil
    var model : Documents?
    
    @IBOutlet weak var pdfImage: UIImageView!
    @IBOutlet weak var pdfLabelView: UILabel!
    
    @IBAction func onClick(_ sender: Any) {
        self.onClickListener!(model!)
    }
}
