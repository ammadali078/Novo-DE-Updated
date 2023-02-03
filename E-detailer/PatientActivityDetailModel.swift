//
//  PatientActivityDetailModel.swift
//  E-detailer
//
//  Created by Macbook Air on 09/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct PatientActivityDetailModel : Mappable {
    var success : Bool?
    var error : String?
    var result : [PatientActivityResult]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}

struct PatientActivityResult : Mappable {
    var clinicalActivityId : Int?
    var callId : Int?
    var doctorID : Int?
    var doctorName : String?
    var patientName : String?
    var patientType : String?
    var callStartTime : String?
    var callEndTime : String?
    var products : [String]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        clinicalActivityId <- map["clinicalActivityId"]
        callId <- map["callId"]
        doctorID <- map["doctorID"]
        doctorName <- map["doctorName"]
        patientName <- map["patientName"]
        patientType <- map["patientType"]
        callStartTime <- map["callStartTime"]
        callEndTime <- map["callEndTime"]
        products <- map["Products"]
    }

}
