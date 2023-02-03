//
//  ProductDownloadContentCell.swift
//  E-detailer
//
//  Created by Ammad on 8/11/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit

class ProductDownloadContentCell : NSObject, UICollectionViewDataSource {
    
    var onClick: ((ContentResult) -> Void)? = nil
    var productList: [ContentResult] = [];
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "downloadableContentCell", for: indexPath) as! ProductDownloadContentCellView
        
        cell.onClickListener = onClick
        cell.productLabelView.text = productList[indexPath.item].product_name
        cell.productImageView.imageFromURL(urlString: productList[indexPath.item].image!)
        cell.model = productList[indexPath.item]
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count;
    }
    
    func setItems (items: [ContentResult]?) {
        self.productList = items!
    }
}

class ProductDownloadContentCellView: UICollectionViewCell {
    
    var onClickListener:((ContentResult) -> Void)? = nil
    var model: ContentResult? = nil
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productLabelView: UILabel!
    
    @IBAction func itemClickButton(_ sender: Any) {
        onClickListener!(model!)
    }
    
}
