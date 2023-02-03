//
//  CallCountModel.swift
//  E-detailer
//
//  Created by Macbook Air on 08/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct CallCountModel : Mappable {
    var success : Bool?
    var error : String?
    var result : CountResult?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}

struct CountResult : Mappable {
    var clinicalActivityCallCount : Int?
    var clinicalActivityPatientCount : Int?
    var homeActivityCallCount : Int?
    var homeActivityVisitCount : Int?
    var homeActivityNewPatientCount : Int?
    var rescheduleCount : Int?
    var cancelCount : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        clinicalActivityCallCount <- map["clinicalActivityCallCount"]
        clinicalActivityPatientCount <- map["clinicalActivityPatientCount"]
        homeActivityCallCount <- map["homeActivityCallCount"]
        homeActivityVisitCount <- map["homeActivityVisitCount"]
        homeActivityNewPatientCount <- map["homeActivityNewPatientCount"]
        rescheduleCount <- map["rescheduleCount"]
        cancelCount <- map["cancelCount"]
    }

}
