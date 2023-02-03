//
//  CategoryListCell.swift
//  E-detailer
//
//  Created by Ammad on 8/18/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit

class CategoryListCell: NSObject, UICollectionViewDataSource {
    var onClick: ((CategoryTree) -> Void)? = nil
    var category:  [CategoryTree] = [];
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryListCell", for: indexPath) as! CategoryListCellView
        
        cell.onClickListener = onClick
        cell.pdfLabelView.text = category[indexPath.item].documentCategory?.name
        cell.pdfImageView.imageFromURL(urlString: Constants.BaseUrl + (category[indexPath.item].documentCategory?.imageUrl)!)
        cell.model = category[indexPath.item]
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count;
    }
    
    func setItems (items:  [CategoryTree]?) {
        self.category = items!
    }
}

class CategoryListCellView: UICollectionViewCell {
    
    var model : CategoryTree?
    var onClickListener: ((CategoryTree) -> Void)? = nil
    
    @IBOutlet weak var pdfImageView: UIImageView!
    @IBOutlet weak var pdfLabelView: UILabel!
    @IBAction func onClick(_ sender: Any) {
        self.onClickListener!(model!)
    }
    
    
}
