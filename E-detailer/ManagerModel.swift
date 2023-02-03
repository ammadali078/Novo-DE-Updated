//
//  ManagerModel.swift
//  E-detailer
//
//  Created by Ammad on 8/15/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper
/*
 Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */

struct ManagerModel : Mappable {
    var success : Bool?
    var error : String?
    var result : ManagerResult?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }
    
}
struct ManagerResult : Mappable {
    var managerID : String?
    var managerName : String?
    var smid : String?
    var smname : String?
    var sSMId : String?
    var sSMName : String?
    var bMId : String?
    var bMName : String?
    var productmanagers : [Productmanagers]?
    
    var isSelected: Bool? = false
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        managerID <- map["managerID"]
        managerName <- map["managerName"]
        smid <- map["smid"]
        smname <- map["smname"]
        sSMId <- map["SSMId"]
        sSMName <- map["SSMName"]
        bMId <- map["BMId"]
        bMName <- map["BMName"]
        productmanagers <- map["Productmanagers"]
    }
    
}
struct Productmanagers : Mappable {
    var id : Int?
    var pMId : String?
    var password : String?
    var pM_Name : String?
    var team : String?
    var status : Bool?
    var designation : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["Id"]
        pMId <- map["PMId"]
        password <- map["Password"]
        pM_Name <- map["PM_Name"]
        team <- map["Team"]
        status <- map["Status"]
        designation <- map["Designation"]
    }
    
}
