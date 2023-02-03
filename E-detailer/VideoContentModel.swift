//
//  VideoContentModel.swift
//  E-detailer
//
//  Created by Ammad on 8/18/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct VideoContentModel : Mappable {
    var success : Bool?
    var error : String?
    var result : [VideoContentResult]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }
    
}

struct VideoContentResult : Mappable {
    var image : String?
    var product_name : String?
    var video_file_url : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        image <- map["image"]
        product_name <- map["product_name"]
        video_file_url <- map["video_file_url"]
    }
    
}
