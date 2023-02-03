//
//  EDUAdverseEventModel.swift
//  E-detailer
//
//  Created by macbook on 28/02/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct EDUAdverseEventModel : Mappable {
    var success : Bool?
    var error : String?
    var result : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
