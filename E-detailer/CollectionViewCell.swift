//
//  CollectionViewCell.swift
//  E-detailer
//
//  Created by Ammad on 12/31/04.
//  Copyright © 2004 Ammad. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell:  UICollectionViewCell {
    
    @IBOutlet weak var EdaName: UILabel!
    @IBOutlet weak var EdaImage: UIImageView!
    
    func displayContent(image: UIImage, title: String){
    
        EdaImage.image = image
        EdaName.text = title
    
    }
}
