//
//  PostSamAndExpModel.swift
//  E-detailer
//
//  Created by macbook on 15/12/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct PostSamAndExpModel : Mappable {
    var success : Bool?
    var error : String?
    var result : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
