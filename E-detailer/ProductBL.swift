//
//  ProductBL.swift
//  E-detailer
//
//  Created by Ammad on 8/25/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper


class ProductBL : BaseBL {
    
    static let PRODUCT_DIR: String = Constants.RootDir + "/" + Constants.TypeProduct

    
    override func getType() -> String {
        return Constants.TypeProduct;
    }
    
    func getProductDir() -> URL {
        return FileUtils.createFolder(folderName: ProductBL.PRODUCT_DIR)!
    }
    
    func getAllProducts() -> [ContentResult] {
        var results: [ContentResult] = []
        var dirs = FileUtils.fileList(documentsUrl: getProductDir())
       
        for dir in dirs {
            var content = ContentResult(map: Map(mappingType: .fromJSON, JSON: [:]))
            content?.image = dir.absoluteString + "/thumbnail/index.png"
            content?.presentation_file_url = dir.absoluteString + "/index.html"
            content?.product_name = dir.lastPathComponent
            results.append(content!)
        }
        return results
    }
}
