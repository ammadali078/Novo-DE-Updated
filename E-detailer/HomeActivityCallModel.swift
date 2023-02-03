//
//  HomeActivityCallModel.swift
//  E-detailer
//
//  Created by Macbook Air on 09/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct HomeActivityCallModel : Mappable {
    var success : Bool?
    var error : String?
    var result : [HomeCallResult]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
struct HomeCallResult : Mappable {
    var homeActivityID : Int?
    var homeActivityPatientId : Int?
    var homeActivityPatientName : String?
    var homeActivityDoctorName : String?
    var homeActivityType : String?
    var homeActivityStartTime : String?
    var homeActivityEndTime : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        homeActivityID <- map["homeActivityID"]
        homeActivityPatientId <- map["homeActivityPatientId"]
        homeActivityPatientName <- map["homeActivityPatientName"]
        homeActivityDoctorName <- map["homeActivityDoctorName"]
        homeActivityType <- map["homeActivityType"]
        homeActivityStartTime <- map["homeActivityStartTime"]
        homeActivityEndTime <- map["homeActivityEndTime"]
    }

}
