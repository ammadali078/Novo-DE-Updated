//
//  HomeActivityVistModel.swift
//  E-detailer
//
//  Created by Macbook Air on 09/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct HomeActivityVistModel : Mappable {
    var success : Bool?
    var error : String?
    var result : [HomeVisitResult]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
struct HomeVisitResult : Mappable {
    var homeActivityID : Int?
    var homeActivityPatientId : Int?
    var homeActivityPatientName : String?
    var homeActivityDoctorName : String?
    var homeActivityType : String?
    var homeActivityStartTime : String?
    var homeActivityEndTime : String?
    var homeActivityProduct : [String]?

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
        homeActivityProduct <- map["homeActivityProduct"]
    }

}

