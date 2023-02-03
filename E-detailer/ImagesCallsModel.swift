//
//  ImagesCallsModel.swift
//  E-detailer
//
//  Created by macbook on 18/01/2023.
//  Copyright © 2023 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct ImagesCallsModel : Mappable {
    var Guid : String?
    var PatinetConsentAttachmentUrl : String?
 
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        Guid <- map["Guid"]
        PatinetConsentAttachmentUrl <- map["PatinetConsentAttachmentUrl"]
       
        
    }
    
}
