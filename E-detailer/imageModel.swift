//
//  imageModel.swift
//  E-detailer
//
//  Created by Macbook Air on 11/10/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import ObjectMapper
import Foundation

struct imageModel : Mappable {
    var uploadImage : [UploadImage]?
   
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        uploadImage <- map["uploadImage"]
        
    }
    
}

struct UploadImage : Mappable {
    var type : String?
    var file : String?
   
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        type <- map["Type"]
        file <- map["File"]
        
    }
    
}
