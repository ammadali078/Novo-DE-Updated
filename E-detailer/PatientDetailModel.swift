//
//  PatientDetailModel.swift
//  E-detailer
//
//  Created by Macbook Air on 24/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//


import Foundation
import ObjectMapper

struct PatientDetailModel : Mappable {
    var success : Bool?
    var error : String?
    var result : [PatientDetail]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}

struct PatientDetail : Mappable {
    var id : Int?
    var patientId : Int?
    var patientName : String?
    var scheduleType : String?
    var daySequence : Int?
    var planObjective : String?
    var planDate : String?
    var isRescheduled : Bool?
    var isCanceled : Bool?
    var patientType : String?
    var novoID : String?
    var cancelReason : String?
    var updatedDate : String?
    var canceledDate : String?
    var doctorId : Int?
    var doctorName : String?
    var productId : Int?
    var productName : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        patientId <- map["PatientId"]
        patientName <- map["PatientName"]
        scheduleType <- map["ScheduleType"]
        daySequence <- map["DaySequence"]
        planObjective <- map["PlanObjective"]
        planDate <- map["PlanDate"]
        isRescheduled <- map["IsRescheduled"]
        isCanceled <- map["IsCanceled"]
        patientType <- map["PatientType"]
        novoID <- map["NovoID"]
        cancelReason <- map["CancelReason"]
        updatedDate <- map["UpdatedDate"]
        canceledDate <- map["CanceledDate"]
        doctorId <- map["DoctorId"]
        doctorName <- map["DoctorName"]
        productId <- map["ProductId"]
        productName <- map["ProductName"]
    }

}
