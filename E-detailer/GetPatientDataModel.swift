//
//  GetPatientDataModel.swift
//  E-detailer
//
//  Created by Macbook Air on 06/10/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//


import Foundation
import ObjectMapper

struct GetPatientDataModel : Mappable {
    var success : Bool?
    var error : String?
    var result : PatientResult?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
struct PatientResult : Mappable {
    
    var educationalActivityViewModel : EducationalActivityViewModel?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        educationalActivityViewModel <- map["educationalActivityViewModel"]
    }

}
struct EducationalActivityViewModel : Mappable {
    var educationalActivityProduct : [EducationalActivityProduct]?
    var educationalActivityOtherProduct : [EducationalActivityOtherProduct]?
    var educationalActivityDevice : [EducationalActivityDevice]?
    var educationalActivityDiscussionTopic : [EducationalActivityDiscussionTopic]?
    var educationalActivityDoseProductWise : [EducationalActivityDoseProductWise]?
    var educationalActivityFrequency : [EducationalActivityFrequency]?
    var educationalActivityCity : [EducationalActivityCity]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        educationalActivityProduct <- map["EducationalActivityProduct"]
        educationalActivityOtherProduct <- map["EducationalActivityOtherProduct"]
        educationalActivityDevice <- map["EducationalActivityDevice"]
        educationalActivityDiscussionTopic <- map["EducationalActivityDiscussionTopic"]
        educationalActivityDoseProductWise <- map["EducationalActivityDoseProductWise"]
        educationalActivityFrequency <- map["EducationalActivityFrequency"]
        educationalActivityCity <- map["EducationalActivityCity"]
        
        
    }

}

struct EducationalActivityCity : Mappable {
    var id : Int?
    var name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        name <- map["Name"]
    }

}

struct EducationalActivityFrequency : Mappable {
    var id : Int?
    var name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        name <- map["Name"]
    }

}

struct EducationalActivityDoseProductWise : Mappable {
    var doseId : Int?
    var productId : Int?
    var productName : String?
    var doseName : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        doseId <- map["DoseId"]
        productId <- map["ProductId"]
        productName <- map["ProductName"]
        doseName <- map["DoseName"]
    }

}

struct EducationalActivityProduct : Mappable {
    var id : Int?
    var name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        name <- map["Name"]
    }

}
struct EducationalActivityOtherProduct : Mappable {
    var id : Int?
    var name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        name <- map["Name"]
    }

}
struct EducationalActivityDiscussionTopic : Mappable {
    var id : Int?
    var name : String?
    var sequence : Int?
    var isExplained : Bool?
    var isHardcopy : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        name <- map["Name"]
        sequence <- map["Sequence"]
        isExplained <- map["IsExplained"]
        isHardcopy <- map["IsHardcopy"]
    }

}
struct EducationalActivityDevice : Mappable {
    var id : Int?
    var name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        name <- map["Name"]
    }

}
