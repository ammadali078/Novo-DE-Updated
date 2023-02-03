//
//  PatientModel.swift
//  E-detailer
//
//  Created by Macbook Air on 13/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON
import RealmSwift

class PatientModel : Object {
    var success : Bool?
    var error : String?
    var result = List<Patients>()
    
    
    func updateModelWithJSON(json: JSON){
        success = json["Success"].boolValue
        error = json["Error"].stringValue
        let patient = json["Result"].arrayValue
        for trending in patient{
            let vendor = Patients()
            vendor.updateModelWithJSON(json: trending)
            self.result.append(vendor)
        }
    }
    
    static func getPatientData() -> PatientModel?{
            let realm = try! Realm()
        if let model = realm.objects(PatientModel.self).first{
                return model
            }
            return nil
        }
}

class Patients : Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var name : String? = ""
    @objc dynamic var iNovoId : String? = ""
    @objc dynamic var allProductId : Int = 0
    @objc dynamic var allProductName : String? = ""
    @objc dynamic var allDoctorId : Int = 0
    @objc dynamic var allDoctorName : String? = ""
    @objc dynamic var patientId : Int = 0
    @objc dynamic var patientName : String? = ""
    @objc dynamic var scheduleType : String? = ""
    @objc dynamic var daySequence : Int = 0
    @objc dynamic var planObjective : String? = ""
    @objc dynamic var planDate : String? = ""
    @objc dynamic var isRescheduled : Bool = false
    @objc dynamic var isCanceled : Bool = false
    @objc dynamic var patientType : String? = ""
    @objc dynamic var novoID : String? = ""
    @objc dynamic var cancelReason : String? = ""
    @objc dynamic var updatedDate : String? = ""
    @objc dynamic var canceledDate : String? = ""
    @objc dynamic var doctorId : Int = 0
    @objc dynamic var doctorName : String? = ""
    @objc dynamic var productId : Int = 0
    @objc dynamic var productName : String? = ""
    
    
    
    
    
    func updateModelWithJSON(json: JSON){
        
        id = json["Id"].intValue
        name = json["Name"].stringValue
        iNovoId = json["INovoId"].stringValue
        allProductId = json["AllProductId"].intValue
        allProductName = json["AllProductName"].stringValue
        allDoctorId = json["AllDoctorId"].intValue
        allDoctorName = json["AllDoctorName"].stringValue
        patientId = json["PatientId"].intValue
        patientName = json["PatientName"].stringValue
        scheduleType = json["ScheduleType"].stringValue
        daySequence = json["DaySequence"].intValue
        planObjective = json["PlanObjective"].stringValue
        planDate = json["PlanDate"].stringValue
        isRescheduled = json["IsRescheduled"].boolValue
        isCanceled = json["IsCanceled"].boolValue
        patientType = json["PatientType"].stringValue
        novoID = json["NovoID"].stringValue
        cancelReason = json["CancelReason"].stringValue
        updatedDate = json["UpdatedDate"].stringValue
        canceledDate = json["CanceledDate"].stringValue
        doctorId = json["DoctorId"].intValue
        doctorName = json["DoctorName"].stringValue
        productId = json["ProductId"].intValue
        productName = json["ProductName"].stringValue
    }
    
}

class PlannedPatientModel : Object {
    var success : Bool?
    var error : String?
    var result = List<PlannedPatients>()
    
    
    func updateModelWithJSON(json: JSON){
        success = json["Success"].boolValue
        error = json["Error"].stringValue
        let patient = json["Result"].arrayValue
        for trending in patient{
            let vendor = PlannedPatients()
            vendor.updateModelWithJSON(json: trending)
            self.result.append(vendor)
        }
    }
    
    static func getPLannedPatientData() -> PlannedPatientModel?{
            let realm = try! Realm()
        if let model = realm.objects(PlannedPatientModel.self).last{
                return model
            }
            return nil
        }
}

class PlannedPatients : Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var name : String? = ""
    @objc dynamic var iNovoId : String? = ""
    @objc dynamic var allProductId : Int = 0
    @objc dynamic var allProductName : String? = ""
    @objc dynamic var allDoctorId : Int = 0
    @objc dynamic var allDoctorName : String? = ""
    @objc dynamic var patientId : Int = 0
    @objc dynamic var patientName : String? = ""
    @objc dynamic var scheduleType : String? = ""
    @objc dynamic var daySequence : Int = 0
    @objc dynamic var planObjective : String? = ""
    @objc dynamic var planDate : String? = ""
    @objc dynamic var isRescheduled : Bool = false
    @objc dynamic var isCanceled : Bool = false
    @objc dynamic var patientType : String? = ""
    @objc dynamic var novoID : String? = ""
    @objc dynamic var cancelReason : String? = ""
    @objc dynamic var updatedDate : String? = ""
    @objc dynamic var canceledDate : String? = ""
    @objc dynamic var doctorId : Int = 0
    @objc dynamic var doctorName : String? = ""
    @objc dynamic var productId : Int = 0
    @objc dynamic var productName : String? = ""
    
    
    
    
    
    func updateModelWithJSON(json: JSON){
        
        id = json["Id"].intValue
        name = json["Name"].stringValue
        iNovoId = json["INovoId"].stringValue
        allProductId = json["AllProductId"].intValue
        allProductName = json["AllProductName"].stringValue
        allDoctorId = json["AllDoctorId"].intValue
        allDoctorName = json["AllDoctorName"].stringValue
        patientId = json["PatientId"].intValue
        patientName = json["PatientName"].stringValue
        scheduleType = json["ScheduleType"].stringValue
        daySequence = json["DaySequence"].intValue
        planObjective = json["PlanObjective"].stringValue
        planDate = json["PlanDate"].stringValue
        isRescheduled = json["IsRescheduled"].boolValue
        isCanceled = json["IsCanceled"].boolValue
        patientType = json["PatientType"].stringValue
        novoID = json["NovoID"].stringValue
        cancelReason = json["CancelReason"].stringValue
        updatedDate = json["UpdatedDate"].stringValue
        canceledDate = json["CanceledDate"].stringValue
        doctorId = json["DoctorId"].intValue
        doctorName = json["DoctorName"].stringValue
        productId = json["ProductId"].intValue
        productName = json["ProductName"].stringValue
    }
    
}


