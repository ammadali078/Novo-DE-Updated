//
//  AttendenceModel.swift
//  E-detailer
//
//  Created by Ammad on 9/6/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct AttendenceModel : Mappable {
    var success : Bool?
    var error : String?
    var result : AttendenceResult?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }
    
}

struct AttendenceResult : Mappable {
    var morningTimeStart : String?
    var maxMorningTime : String?
    var eveningTimeStart : String?
    var maxEveningTime : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        morningTimeStart <- map["MorningTimeStart"]
        maxMorningTime <- map["MaxMorningTime"]
        eveningTimeStart <- map["EveningTimeStart"]
        maxEveningTime <- map["MaxEveningTime"]
    }
    
}
