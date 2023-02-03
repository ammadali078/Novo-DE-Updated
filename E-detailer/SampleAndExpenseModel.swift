//
//  SampleAndExpenseModel.swift
//  E-detailer
//
//  Created by macbook on 15/12/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct SampleAndExpenseModel : Mappable {
    var success : Bool?
    var error : String?
    var result : SampleAndExpenseResult?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
struct SampleAndExpenseResult : Mappable {
    var expenseTypes : [ExpenseTypes]?
    var sampleBalance : [String]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        expenseTypes <- map["ExpenseTypes"]
        sampleBalance <- map["SampleBalance"]
    }

}
struct ExpenseTypes : Mappable {
    var expenseType : String?
    var code : String?
    var amount : Double?
    var mode : String?
    var isReceiptRequired : Bool?
    var isNoteRequired : Bool?
    var assignedRole : String?
    var cityRequired : Bool?
    var appliedFrom : String?
    var id : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        expenseType <- map["ExpenseType"]
        code <- map["Code"]
        amount <- map["Amount"]
        mode <- map["Mode"]
        isReceiptRequired <- map["isReceiptRequired"]
        isNoteRequired <- map["isNoteRequired"]
        assignedRole <- map["AssignedRole"]
        cityRequired <- map["CityRequired"]
        appliedFrom <- map["AppliedFrom"]
        id <- map["id"]
    }

}
