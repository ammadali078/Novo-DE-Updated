//
//  LoginModel.swift
//  E-detailer
//
//  Created by Ammad on 8/10/18.
//  Copyright © 2018 Ammad. All rights reserved.
//
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseWelcome { response in
//     if let welcome = response.result.value {
//       ...
//     }
//   }

import Foundation
import ObjectMapper

struct LoginModel : Mappable {
    var success : Bool?
    var error : String?
    var result : Result?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }
    
}


struct Result : Mappable {
    var team_id : String?
    var emp_id : String?
    var emp_name : String?
    var emp_designation : String?
    var emp_city : [Emp_city] = []
    var isExpenseRequired : Bool?
    var name = [String]()
    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        
        team_id <- map["team_id"]
        emp_id <- map["emp_id"]
        emp_name <- map["emp_name"]
        emp_designation <- map["emp_designation"]
        emp_city <- map["emp_city"]
        isExpenseRequired <- map["IsExpenseRequired"]
        for i in emp_city{
            self.name.append(i.name ?? "")
        }
    }
    
}
struct Emp_city : Mappable {
    var id : Int?
    var name : String?
    var destinations : [Destinations] = []
    var desName = [String]()
    var desId = [Int]()

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        name <- map["Name"]
        destinations <- map["Destinations"]
        for i in destinations{
            self.desName.append(i.name ?? "")
        }
        
        for i in destinations{
            self.desId.append(i.id ?? 0)
        }
    }

}
struct Destinations : Mappable {
    var id : Int?
    var name : String?
    var distanceInKM : Double?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        name <- map["Name"]
        distanceInKM <- map["DistanceInKM"]
    }

}
