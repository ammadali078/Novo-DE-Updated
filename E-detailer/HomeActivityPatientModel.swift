//
//  HomeActivityPatientModel.swift
//  E-detailer
//
//  Created by Macbook Air on 10/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct HomeActivityPatientModel : Mappable {
    var success : Bool?
    var error : String?
    var result : [HomePatientResult]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}

struct HomePatientResult : Mappable {
    var homeActivityID : Int?
    var homeActivityPatientName : String?
    var homeActivityProduct : String?
    var homeActivityDoctorId : Int?
    var homeActivityDoctorName : String?
    var homeActivityType : String?
    var homeActivityTime : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        homeActivityID <- map["homeActivityID"]
        homeActivityPatientName <- map["homeActivityPatientName"]
        homeActivityProduct <- map["homeActivityProduct"]
        homeActivityDoctorId <- map["homeActivityDoctorId"]
        homeActivityDoctorName <- map["homeActivityDoctorName"]
        homeActivityType <- map["homeActivityType"]
        homeActivityTime <- map["homeActivityTime"]
    }

}
