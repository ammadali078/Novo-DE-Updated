//
//  VideoProductDataSource.swift
//  E-detailer
//
//  Created by Ammad on 8/27/18.
//  Copyright © 2018 Ammad. All rights reserved.
//
import Foundation
import UIKit

class VideoProductDataSource: NSObject, UICollectionViewDataSource {
    
    var videoProductList: [VideoContentResult] = []
    var onClick: ((VideoContentResult) -> Void)? = nil
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoProductCell", for: indexPath) as! VideoProductCellView
        
        cell.onClickListener = onClick
        cell.model = videoProductList[indexPath.item]
        cell.downloadLabelView.text = videoProductList[indexPath.item].product_name
        cell.downloadImageView.imageFromURL(urlString: videoProductList[indexPath.item].image!)
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoProductList.count;
    }
    
    func setItems (items: [VideoContentResult]?) {
        self.videoProductList = items!
    }
    
}

class VideoProductCellView: UICollectionViewCell{
    
    var onClickListener:((VideoContentResult) -> Void)? = nil
    var model: VideoContentResult? = nil
    
    @IBOutlet weak var downloadLabelView: UILabel!
    @IBOutlet weak var downloadImageView: UIImageView!
    
    @IBAction func onClick(_ sender: Any) {
        
        onClickListener!(model!)
    }
    
}
