//
//  DoctorModel.swift
//  E-detailer
//
//  Created by Ammad on 8/13/18.
//  Copyright © 2018 Ammad. All rights reserved.
//


import Foundation
import ObjectMapper

struct DoctorModel : Mappable {
    var success : Bool?
    var error : String?
    var result : [DoctorResult]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }
    
}
struct DoctorResult : Mappable {
    var id : String?
    var name : String?
    var eveningAddress : String?
    var residentialAddress : String?
    var morningAddress : String?
    var mobile : String?
    var ptcl : String?
    var speciality : String?
    var territory : String?
    var brickName : String?
    var isSelected: Bool? = false
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        eveningAddress <- map["EveningAddress"]
        residentialAddress <- map["ResidentialAddress"]
        morningAddress <- map["MorningAddress"]
        mobile <- map["mobile"]
        ptcl <- map["ptcl"]
        speciality <- map["speciality"]
        territory <- map["Territory"]
        brickName <- map["BrickName"]
    }
    
}

