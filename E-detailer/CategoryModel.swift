//
//  CategoryModel.swift
//  E-detailer
//
//  Created by Ammad on 8/18/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct CategoryModel : Mappable {
    var categoryTree : [CategoryTree]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        categoryTree <- map["CategoryTree"]
    }
    
}
struct CategoryTree : Mappable {
    var childCategories : [CategoryTree]?
    var documentCategory : DocumentCategory?
    var documents : [Documents]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        childCategories <- map["ChildCategories"]
        documentCategory <- map["DocumentCategory"]
        documents <- map["Documents"]
    }
    
}

struct DocumentCategory : Mappable {
    var id : Int?
    var name : String?
    var level : Int?
    var parent : Int?
    var imageUrl : String?
    var teamId : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["Id"]
        name <- map["Name"]
        level <- map["Level"]
        parent <- map["Parent"]
        imageUrl <- map["ImageUrl"]
        teamId <- map["TeamId"]
    }
    
}
struct Documents : Mappable {
    var id : Int?
    var name : String?
    var path : String?
    var type : String?
    var thumbnailPath : String?
    var active : Bool?
    var created : String?
    var modified : String?
    var category : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["Id"]
        name <- map["Name"]
        path <- map["Path"]
        type <- map["Type"]
        thumbnailPath <- map["ThumbnailPath"]
        active <- map["Active"]
        created <- map["Created"]
        modified <- map["Modified"]
        category <- map["Category"]
    }
    
}
