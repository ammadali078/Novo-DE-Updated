//
//  ContentModel.swift
//  E-detailer
//
//  Created by Ammad on 8/11/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct ContentModel : Mappable {
    var success : Bool?
    var error : String?
    var result : [ContentResult]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }
    
}

struct ContentResult : Mappable {
    var image : String?
    var presentation_file_url : String?
    var product_name : String?
    var lastmodified : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        image <- map["image"]
        presentation_file_url <- map["presentation_file_url"]
        product_name <- map["product_name"]
        lastmodified <- map["lastmodified"]
    }
    
}
