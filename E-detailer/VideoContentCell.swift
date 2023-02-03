//
//  VideoContentCell.swift
//  E-detailer
//
//  Created by Ammad on 8/18/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit

class VideoContentCell: NSObject, UICollectionViewDataSource {
    
    var onClickVideo: ((VideoContentResult) -> Void)? = nil
    var videoList: [VideoContentResult] = [];
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoContentCell", for: indexPath) as! VideoContentCellView
        
        cell.videoLabelView.text = videoList[indexPath.item].product_name
        cell.videoImageView.imageFromURL(urlString: videoList[indexPath.item].image!)
        cell.onClickListener = onClickVideo
        cell.model = videoList[indexPath.item]
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoList.count;
    }
    
    func setItems (items: [VideoContentResult]?) {
        self.videoList = items!
    }
    
}

class VideoContentCellView: UICollectionViewCell {
    
    var onClickListener:((VideoContentResult) -> Void)? = nil
    var model: VideoContentResult? = nil
    
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoLabelView: UILabel!
    
    @IBAction func onClickVideo(_ sender: Any) {
        
        onClickListener!(model!)
        
    }
    
}
