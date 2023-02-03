//
//  DownloadedProductDataSource.swift
//  E-detailer
//
//  Created by Ammad on 8/25/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit

class DownloadedProductDataSource: NSObject, UICollectionViewDataSource {
    
    var downloadedProductList: [ContentResult] = []
    var onClick: ((ContentResult) -> Void)? = nil
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "downloadedProductCell", for: indexPath) as! ProductDownloadCellView
        
        cell.onClickListener = onClick
        cell.model = downloadedProductList[indexPath.item]
        cell.mLabelView.text = downloadedProductList[indexPath.item].product_name
        cell.mImageView.imageFromURL(urlString: downloadedProductList[indexPath.item].image!)
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return downloadedProductList.count;
    }
    
    func setItems (items: [ContentResult]?) {
        self.downloadedProductList = items!
    }
    
}

class ProductDownloadCellView: UICollectionViewCell{
    var onClickListener:((ContentResult) -> Void)? = nil
    var model: ContentResult? = nil
    
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mLabelView: UILabel!
    
    @IBAction func onClick(_ sender: Any) {
        
        onClickListener!(model!)
        
    }
}
