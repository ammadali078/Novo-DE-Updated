//
//  HomeImageCallModel.swift
//  E-detailer
//
//  Created by macbook on 13/10/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct HomeImageCallModel : Mappable {
    var Guid : String?
    var PatinetConsentAttachmentUrl : String?
    var PrescriptionConsentAttachmentUrl : String?
 
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        Guid <- map["Guid"]
        PatinetConsentAttachmentUrl <- map["PatinetConsentAttachmentUrl"]
        PrescriptionConsentAttachmentUrl <- map["PrescriptionConsentAttachmentUrl"]
       
        
    }
    
}
