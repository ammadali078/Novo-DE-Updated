//
//  UploadImageModel.swift
//  E-detailer
//
//  Created by Macbook Air on 11/10/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct UploadImageModel : Mappable {
    var success : Bool?
    var error : String?
    var result : [String]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
