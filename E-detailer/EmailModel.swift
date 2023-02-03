//
//  EmailModel.swift
//  E-detailer
//
//  Created by macbook on 16/05/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct EmailModel : Mappable {
    var success : Bool?
    var error : String?
    var result : EmailResult?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
struct EmailResult : Mappable {
    var emailSent : [EmailSent]?
    var emailnotSent : [EmailnotSent]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        emailSent <- map["emailSent"]
        emailnotSent <- map["emailnotSent"]
    }

}
struct EmailSent : Mappable {
    var doctorName : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        doctorName <- map["DoctorName"]
    }

}
struct EmailnotSent : Mappable {
    var doctorName : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        doctorName <- map["DoctorName"]
    }

}
