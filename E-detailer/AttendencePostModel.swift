//
//  AttendencePostModel.swift
//  E-detailer
//
//  Created by Ammad on 10/8/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper


struct AttendencePostModel : Mappable {
    var listAttendance : [ListAttendance]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        listAttendance <- map["listAttendance"]
    }
    
}
struct ListAttendance : Mappable {
    var rECEIVE_TIME : String?
    var mJsonString : String?
    var eMP_ID : String?
    var shift : String?
    var latitude : String?
    var longitude : String?
    var id : String?
    var dESCR : String?
    var cPID : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        rECEIVE_TIME <- map["RECEIVE_TIME"]
        mJsonString <- map["mJsonString"]
        eMP_ID <- map["EMP_ID"]
        shift <- map["Shift"]
        latitude <- map["Latitude"]
        longitude <- map["Longitude"]
        id <- map["Id"]
        dESCR <- map["DESCR"]
        cPID <- map["CPID"]
    }
    
}
