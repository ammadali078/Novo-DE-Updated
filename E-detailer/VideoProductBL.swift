//
//  VideoProductBL.swift
//  E-detailer
//
//  Created by Ammad on 8/27/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper


class VideoProductBL : BaseBL {
    
    static let VIDEOPRODUCT_DIR: String = Constants.RootDir + "/" + Constants.TypeVideo
    
    
    override func getType() -> String {
        return Constants.TypeVideo;
    }
    
    func getVideoDir() -> URL {
        return FileUtils.createFolder(folderName: VideoProductBL.VIDEOPRODUCT_DIR)!
    }
    
    func getAllProducts() -> [VideoContentResult] {
        var results: [VideoContentResult] = []
        var dirs = FileUtils.fileList(documentsUrl: getVideoDir())
        
        for dir in dirs {
            var content = VideoContentResult(map: Map(mappingType: .fromJSON, JSON: [:]))
            content?.image = dir.absoluteString + "/thumbnail/index.png"
            content?.video_file_url = dir.absoluteString + "/sample.mp4"
            content?.product_name = dir.lastPathComponent
            results.append(content!)
        }
        return results
    }
}
