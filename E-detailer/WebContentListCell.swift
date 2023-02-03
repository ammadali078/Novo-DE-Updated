//
//  WebContentListCell.swift
//  E-detailer
//
//  Created by Ammad on 8/30/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit

class WebContentListCell: NSObject, UICollectionViewDataSource {
    
    var webProductList: [ContentResult] = []
    var onClick: ((ContentResult) -> Void)? = nil
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentListCell", for: indexPath) as! WebProductCellView
        cell.onClickListener = onClick
        cell.model = webProductList[indexPath.item]
        cell.mLabelView.text = webProductList[indexPath.item].product_name
        cell.mImageView.imageFromURL(urlString: webProductList[indexPath.item].image!)
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return webProductList.count;
    }
    
    func setItems (items: [ContentResult]?) {
        self.webProductList = items!
    }
    
}

class WebProductCellView: UICollectionViewCell{
    
    var model: ContentResult? = nil
    var onClickListener:((ContentResult) -> Void)? = nil
    
    @IBOutlet weak var mLabelView: UILabel!
    
    @IBOutlet weak var mImageView: UIImageView!
    
    @IBAction func onClick(_ sender: Any) {
        
        onClickListener!(model!)
        
    }
    
    
}
