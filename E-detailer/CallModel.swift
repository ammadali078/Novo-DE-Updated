//
//  CallListenerModel.swift
//  E-detailer
//
//  Created by Ammad on 8/18/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct CallModel : Mappable {
    var lng : String?
    var lat : String?
    var managerId : String?
    var Activity : String?
    var sMId : String?
    var callNotes : [CallNotes]?
    var mACAddress : String?
    var callDoctors : [CallDoctors]?
    var isUseful : String?
    var remarks : String?
    var isConnectedwithInternet : Bool?
    var userId : String?
    var callProductManagers : [String]?
    var eDASessions : [EDASessions]?
    var expenses : [String]?
    var endTime : String?
    var sampleDistributions : [String]?
    var doctorId : String?
    var startTime : String?
    var clinicActivity : [ClinicActivity]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        Activity <- map["Activity"]
        lng <- map["Lng"]
        lat <- map["Lat"]
        managerId <- map["ManagerId"]
        sMId <- map["SMId"]
        callNotes <- map["CallNotes"]
        mACAddress <- map["MACAddress"]
        callDoctors <- map["CallDoctors"]
        isUseful <- map["IsUseful"]
        remarks <- map["Remarks"]
        isConnectedwithInternet <- map["IsConnectedwithInternet"]
        userId <- map["UserId"]
        callProductManagers <- map["CallProductManagers"]
        eDASessions <- map["EDASessions"]
        expenses <- map["Expenses"]
        endTime <- map["EndTime"]
        sampleDistributions <- map["SampleDistributions"]
        doctorId <- map["DoctorId"]
        startTime <- map["StartTime"]
        clinicActivity <- map["ClinicActivity"]
        
    }
    
}

struct CallDoctors : Mappable {
    var id : String?
    var docName : String? = ""
    var callId : String?
    var doctorId : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        docName <- map["docName"]
        id <- map["Id"]
        callId <- map["CallId"]
        doctorId <- map["DoctorId"]
    }
    
}




struct CallRequestModel : Mappable {
    var ConnectivityMedium : String?
    var Lng : String?
    var Lat : String?
    var requestId : String?
    var Calls : [CallModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        ConnectivityMedium <- map["ConnectivityMedium"]
        Lng <- map["Lng"]
        Lat <- map["Lat"]
        requestId <- map["requestId"]
        Calls <- map["Calls"]
    }
    
}

struct CallNotes : Mappable {
    var nextCall : String?
    var id : String?
    var callId : String?
    var preCall : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        nextCall <- map["NextCall"]
        id <- map["Id"]
        callId <- map["CallId"]
        preCall <- map["PreCall"]
    }
    
}
struct EDALogs : Mappable {
    var breakPoints : [String]?
    var endTime : String?
    var pageId : String?
    var startTime : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        breakPoints <- map["BreakPoints"]
        endTime <- map["EndTime"]
        pageId <- map["PageId"]
        startTime <- map["StartTime"]
    }
    
}
struct EDASessions : Mappable {
    var endTime : String?
    var title : String?
    var startTime : String?
    var eDALogs : [EDALogs]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        endTime <- map["EndTime"]
        title <- map["Title"]
        startTime <- map["StartTime"]
        eDALogs <- map["EDALogs"]
    }
    
}
struct ClinicActivity : Mappable {
    var patientConsent : Bool?
//    var patientConsentAttachmentUrl : String?
    var patientName : String?
    var contactNumber1 : String?
    var contactNumber2 : String?
    var city : String?
    var address1 : String?
    var address2 : String?
    var iNovoId : String?
    var patientType : String?
    var bloodGlucose : String?
    var bloodPressure : String?
    var hbA1c : String?
    var weight : String?
    var ClinicActivityGuid : String?
    var feedbackStars : String?
    var SafetyEventReportByPatient : Bool?
    var AdverseDrugEvent : Bool?
    var TechnicalIssue : Bool?
    var GDM : Bool?
    var OffLabel : Bool?
    var Discontinuation : Bool?
    var MedicationErrorOverdoseOrMisuse : Bool?
    var Hospitalization : Bool?
    
    var concomitantOtherProductList : [ConcomitantOtherProductList]?
    var concomitantProductList : [ConcomitantProductList]?
    var currentProductList : [CurrentProductList]?
    var discussionTopicList : [DiscussionTopicList]?
    var previousOtherProductList : [PreviousOtherProductList]?
    var previousProductList : [PreviousProductList]?
    var currentOtherProductList : [CurrentOtherProductList]?
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        patientConsent <- map["PatientConsent"]
//        patientConsentAttachmentUrl <- map["PatientConsentAttachmentUrl"]
        patientName <- map["PatientName"]
        contactNumber1 <- map["ContactNumber1"]
        contactNumber2 <- map["ContactNumber2"]
        city <- map["City"]
        address1 <- map["Address1"]
        address2 <- map["Address2"]
        iNovoId <- map["INovoId"]
        patientType <- map["PatientType"]
        bloodGlucose <- map["BloodGlucose"]
        bloodPressure <- map["BloodPressure"]
        hbA1c <- map["HbA1c"]
        weight <- map["Weight"]
        feedbackStars <- map["FeedbackStars"]
        concomitantOtherProductList <- map["ConcomitantOtherProductList"]
        concomitantProductList <- map["ConcomitantProductList"]
        currentProductList <- map["CurrentProductList"]
        discussionTopicList <- map["DiscussionTopicList"]
        previousOtherProductList <- map["PreviousOtherProductList"]
        currentOtherProductList <- map["CurrentOtherProductList"]
        previousProductList <- map["PreviousProductList"]
        SafetyEventReportByPatient <- map["SafetyEventReportByPatient"]
        ClinicActivityGuid <- map["ClinicActivityGuid"]
        AdverseDrugEvent <- map["AdverseDrugEvent"]
        TechnicalIssue <- map["TechnicalIssue"]
        Discontinuation <- map["Discontinuation"]
        GDM <- map["GDM"]
        OffLabel <- map["OffLabel"]
        MedicationErrorOverdoseOrMisuse <- map["MedicationErrorOverdoseOrMisuse"]
        Hospitalization <- map["Hospitalization"]
        
    }
    
}
struct ConcomitantOtherProductList : Mappable {
    var otherProductId: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        otherProductId <- map["OtherProductId"]
        
    }
    
}
struct ConcomitantProductList : Mappable {
    var productId: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        productId <- map["ProductId"]
        
    }
    
}
struct CurrentProductList : Mappable {
    
    var productId: Int?
    var dose: Int?
    var deviceDemo: Bool?
    var deviceId: Int?
    var Frequency: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        productId <- map["ProductId"]
        dose <- map["Dose"]
        deviceDemo <- map["DeviceDemo"]
        deviceId <- map["DeviceId"]
        Frequency <- map["Frequency"]
        
    }
    
}
struct DiscussionTopicList : Mappable {
    var discussionTopicId: Int?
    var explained: Bool?
    var hardCopyProvided: Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        discussionTopicId <- map["DiscussionTopicId"]
        explained <- map["Explained"]
        hardCopyProvided <- map["HardCopyProvided"]
        
    }
    
}

struct PreviousOtherProductList : Mappable {
    var otherProductId: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        otherProductId <- map["OtherProductId"]
        
    }
    
}

struct CurrentOtherProductList : Mappable {
    var OtherProductId: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        OtherProductId <- map["OtherProductId"]
        
    }
    
}

struct PreviousProductList : Mappable {
    var productId: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        productId <- map["ProductId"]
        
    }
    
}

