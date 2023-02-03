//
//  CallExpModel.swift
//  E-detailer
//
//  Created by macbook on 15/12/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct CallExpModel : Mappable {
    var expenseModel : [ExpenseModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
       
        expenseModel <- map["ExpenseModel"]
    }
    
}
struct ExpenseModel : Mappable {
    var expenseType : String?
    var code : String?
    var amount : Double?
    var mode : String?
    var isReceiptRequired : Bool?
    var isNoteRequired : Bool?
    var assignedRole : String?
    var cityRequired : Bool?
    var appliedFrom : String?
    var emp_City : String?
    var id : Int?
    var desName : String?
    var date : String?
    var desId : Int?
    var cityId : Int?
    var notes : String?
    var filePath : String?
    var fileName : String?

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
        desName <- map["DesName"]
        desId <- map["DesId"]
        cityId <- map["CityId"]
        emp_City <- map["Emp-City"]
        notes <- map["Notes"]
        date <- map["Date"]
        filePath <- map["filePath"]
        fileName <- map["fileName"]
    }

}



