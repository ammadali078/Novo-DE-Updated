//
//  ImageCallModel.swift
//  E-detailer
//
//  Created by macbook on 26/09/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct ImageCallModel : Mappable {
    var Guid : String?
    var PatinetConsentAttachmentUrl : String?
 
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        Guid <- map["Guid"]
        PatinetConsentAttachmentUrl <- map["PatinetConsentAttachmentUrl"]
       
        
    }
    
}
