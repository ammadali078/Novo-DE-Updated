//
//  ContactModel.swift
//  E-detailer
//
//  Created by Ammad on 8/11/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct ContactModel : Mappable {
    var success : Bool?
    var error : String?
    var result : [ContactResult]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }
    
}

struct ContactResult : Mappable {
    var id : Int?
    var cPID : Int?
    var dESCR : String?
    var baseTown : String?
    var region : String?
    var zone : String?
    var active : Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["Id"]
        cPID <- map["CPID"]
        dESCR <- map["DESCR"]
        baseTown <- map["BaseTown"]
        region <- map["Region"]
        zone <- map["Zone"]
        active <- map["Active"]
    }
    
}
