//
//  PlannedDoctorModel.swift
//  E-detailer
//
//  Created by Macbook Air on 30/11/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct PlannedDoctorModel : Mappable {
    var success : Bool?
    var error : String?
    var result : PlannedResult?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }

}
struct PlannedResult : Mappable {
    var msrplan : [Msrplan]?
    var docList : [DocList]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        msrplan <- map["msrplan"]
        docList <- map["docList"]
    }

}
struct Msrplan : Mappable {
    var id : String?
    var mSRId : String?
    var plannedVisit : String?
    var actualVisit : String?
    var territory : String?
    var managerApproved : Bool?
    var sMApproved : Bool?
    var pMApproved : Bool?
    var jointWithManager : Bool?
    var iMSBrickId1 : String?
    var offDay : Bool?
    var absent : String?
    var jointWithSM : Bool?
    var brickName : String?
    var month : Int?
    var year : Int?
    var day : Int?
    var visitPeriod : String?
    var scheduleStatusId : String?
    var leaveReasonId : String?
    var isHoliday : Bool?
    var reason : String?
    var displayOrder : Int?
    var dayName : String?
    var dayOfWeek : Int?
    var week : Int?
    var deleted : Bool?
    var mSRName : String?
    var name : String?
    var speciality : String?
    var mobile : String?
    var ptcl : String?
    var morningAddress : String?
    var eveningAddress : String?
    var description : String?
    var doctorInternalId : Int?
    var doctorExternalId : String?
    var doctorBrickCode : String?
    var doctorBrickName : String?
    var doctorTeam : String?
    var doctorUploadDate : String?
    var doctorEmpID : String?
    var docClass : String?
    var callFreq : Double?
    var designation : String?
    var city : String?
    var area : String?
    var preCall : String?
    var nextCall : String?
    var callStartTime : String?
    var alreadyVisited : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        mSRId <- map["MSRId"]
        plannedVisit <- map["PlannedVisit"]
        actualVisit <- map["ActualVisit"]
        territory <- map["Territory"]
        managerApproved <- map["ManagerApproved"]
        sMApproved <- map["SMApproved"]
        pMApproved <- map["PMApproved"]
        jointWithManager <- map["JointWithManager"]
        iMSBrickId1 <- map["IMSBrickId1"]
        offDay <- map["OffDay"]
        absent <- map["Absent"]
        jointWithSM <- map["JointWithSM"]
        brickName <- map["BrickName"]
        month <- map["Month"]
        year <- map["Year"]
        day <- map["Day"]
        visitPeriod <- map["VisitPeriod"]
        scheduleStatusId <- map["ScheduleStatusId"]
        leaveReasonId <- map["LeaveReasonId"]
        isHoliday <- map["IsHoliday"]
        reason <- map["Reason"]
        displayOrder <- map["DisplayOrder"]
        dayName <- map["DayName"]
        dayOfWeek <- map["DayOfWeek"]
        week <- map["Week"]
        deleted <- map["Deleted"]
        mSRName <- map["MSRName"]
        name <- map["name"]
        speciality <- map["speciality"]
        mobile <- map["mobile"]
        ptcl <- map["ptcl"]
        morningAddress <- map["MorningAddress"]
        eveningAddress <- map["EveningAddress"]
        description <- map["Description"]
        doctorInternalId <- map["DoctorInternalId"]
        doctorExternalId <- map["DoctorExternalId"]
        doctorBrickCode <- map["DoctorBrickCode"]
        doctorBrickName <- map["DoctorBrickName"]
        doctorTeam <- map["DoctorTeam"]
        doctorUploadDate <- map["DoctorUploadDate"]
        doctorEmpID <- map["DoctorEmpID"]
        docClass <- map["DocClass"]
        callFreq <- map["CallFreq"]
        designation <- map["Designation"]
        city <- map["City"]
        area <- map["Area"]
        preCall <- map["PreCall"]
        nextCall <- map["NextCall"]
        callStartTime <- map["CallStartTime"]
        alreadyVisited <- map["AlreadyVisited"]
    }

}

struct DocList : Mappable {
    var day : Int?
    var month : Int?
    var year : Int?
    var id : String?
    var docCode : String?
    var tM_Division : String?
    var timeOfVisit : String?
    var updatedDate : String?
    var tMId : String?
    var tM_Name : String?
    var visitWith : String?
    var drName : String?
    var drMobile : String?
    var drDesignation : String?
    var area : String?
    var brick : String?
    var callFreq : Int?
    var address : String?
    var city : String?
    var speciality : String?
    var prescriberOrPurchaser : String?
    var doctorStar : String?
    var noOfPatients : Double?
    var lastVerified : String?
    var brand : String?
    var vID : Bool?
    var bF1 : Bool?
    var bF2 : Bool?
    var bF3 : Bool?
    var nL33 : Bool?
    var bFYes : Bool?
    var bFM : Bool?
    var cS : Bool?
    var doctorFeedback : [String]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        day <- map["Day"]
        month <- map["Month"]
        year <- map["Year"]
        id <- map["id"]
        docCode <- map["DocCode"]
        tM_Division <- map["TM_Division"]
        timeOfVisit <- map["TimeOfVisit"]
        updatedDate <- map["UpdatedDate"]
        tMId <- map["TMId"]
        tM_Name <- map["TM_Name"]
        visitWith <- map["VisitWith"]
        drName <- map["DrName"]
        drMobile <- map["DrMobile"]
        drDesignation <- map["DrDesignation"]
        area <- map["Area"]
        brick <- map["Brick"]
        callFreq <- map["CallFreq"]
        address <- map["Address"]
        city <- map["City"]
        speciality <- map["Speciality"]
        prescriberOrPurchaser <- map["PrescriberOrPurchaser"]
        doctorStar <- map["DoctorStar"]
        noOfPatients <- map["NoOfPatients"]
        lastVerified <- map["LastVerified"]
        brand <- map["Brand"]
        vID <- map["VID"]
        bF1 <- map["BF1"]
        bF2 <- map["BF2"]
        bF3 <- map["BF3"]
        nL33 <- map["NL33"]
        bFYes <- map["BFYes"]
        bFM <- map["BFM"]
        cS <- map["CS"]
        doctorFeedback <- map["DoctorFeedback"]
    }

}
