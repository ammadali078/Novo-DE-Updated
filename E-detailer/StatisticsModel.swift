//
//  StatisticsModel.swift
//  E-detailer
//
//  Created by Ammad on 8/16/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct StatisticsModel : Mappable {
    
    var currentMonthYear : String?
    var pADetails : PADetails?
    var stats : Stats?
    var frequencyDeviationMissedDoctorsList : [String]?
    var missedDoctorsList : [MissedDoctorsList]?
    var attendance : Attendance?
    var frequencyDeviationMissedDoctorsInformation : FrequencyDeviationMissedDoctorsInformation?
    var missedDoctorsInformation : MissedDoctorsInformation?
    var todayCalls : TodayCalls?
    var dayWiseCallTrend : DayWiseCallTrend?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        currentMonthYear <- map["CurrentMonthYear"]
        pADetails <- map["PADetails"]
        stats <- map["Stats"]
        frequencyDeviationMissedDoctorsList <- map["FrequencyDeviationMissedDoctorsList"]
        missedDoctorsList <- map["MissedDoctorsList"]
        attendance <- map["Attendance"]
        frequencyDeviationMissedDoctorsInformation <- map["FrequencyDeviationMissedDoctorsInformation"]
        missedDoctorsInformation <- map["MissedDoctorsInformation"]
        todayCalls <- map["TodayCalls"]
        dayWiseCallTrend <- map["DayWiseCallTrend"]
    }
    
}
struct Attendance : Mappable {
    var present : Int?
    var absent : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        present <- map["Present"]
        absent <- map["Absent"]
    }
    
}

struct CallStatus : Mappable {
    var date : String?
    var value : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        date <- map["Date"]
        value <- map["Value"]
    }
    
}
struct DayWiseCallTrend : Mappable {
    var tCode : String?
    var totalCalls : String?
    var callsAvg : String?
    var callStatus : [CallStatus]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        tCode <- map["TCode"]
        totalCalls <- map["TotalCalls"]
        callsAvg <- map["CallsAvg"]
        callStatus <- map["CallStatus"]
    }
    
}

struct Duration : Mappable {
    var ticks : Int?
    var days : Int?
    var hours : Int?
    var milliseconds : Int?
    var minutes : Int?
    var seconds : Int?
    var totalDays : Double?
    var totalHours : Double?
    var totalMilliseconds : Int?
    var totalMinutes : Double?
    var totalSeconds : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        ticks <- map["Ticks"]
        days <- map["Days"]
        hours <- map["Hours"]
        milliseconds <- map["Milliseconds"]
        minutes <- map["Minutes"]
        seconds <- map["Seconds"]
        totalDays <- map["TotalDays"]
        totalHours <- map["TotalHours"]
        totalMilliseconds <- map["TotalMilliseconds"]
        totalMinutes <- map["TotalMinutes"]
        totalSeconds <- map["TotalSeconds"]
    }
    
}

struct FrequencyDeviationMissedDoctorsInformation : Mappable {
    var missedDoctorsInformationList : [String]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        missedDoctorsInformationList <- map["MissedDoctorsInformationList"]
    }
    
}
struct MissedDoctorsInformation : Mappable {
    var missedDoctorsInformationList : [MissedDoctorsInformationList]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        missedDoctorsInformationList <- map["MissedDoctorsInformationList"]
    }
    
}
struct MissedDoctorsInformationList : Mappable {
    var doccode : String?
    var docName : String?
    var gender : String?
    var spec : String?
    var brickName : String?
    var actualVisits : Int?
    var city : String?
    var frequency : Int?
    var empId : String?
    var empName : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        doccode <- map["Doccode"]
        docName <- map["DocName"]
        gender <- map["Gender"]
        spec <- map["Spec"]
        brickName <- map["BrickName"]
        actualVisits <- map["ActualVisits"]
        city <- map["City"]
        frequency <- map["Frequency"]
        empId <- map["EmpId"]
        empName <- map["EmpName"]
    }
    
}


struct MissedDoctorsList : Mappable {
    var frequency : Int?
    var count : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        frequency <- map["Frequency"]
        count <- map["Count"]
    }
    
}

struct PADetails : Mappable {
    var name : String?
    var region : String?
    var tCode : String?
    var baseTown : String?
    var empId : String?
    var zone : String?
    var team : String?
    var contactPoint : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        name <- map["Name"]
        region <- map["Region"]
        tCode <- map["TCode"]
        baseTown <- map["BaseTown"]
        empId <- map["EmpId"]
        zone <- map["Zone"]
        team <- map["Team"]
        contactPoint <- map["ContactPoint"]
    }
    
}
struct Stats : Mappable {
    var totalCalls : String?
    var eDAsViewed : String?
    var slidesViewed : String?
    var avgCallDuration : String?
    var avgSessionDuration : String?
    var avgSlidesDuration : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        totalCalls <- map["TotalCalls"]
        eDAsViewed <- map["EDAsViewed"]
        slidesViewed <- map["SlidesViewed"]
        avgCallDuration <- map["AvgCallDuration"]
        avgSessionDuration <- map["AvgSessionDuration"]
        avgSlidesDuration <- map["AvgSlidesDuration"]
    }
    
}


struct TodayCalls : Mappable {
    var todayCallsDetailsList : [TodayCallsDetailsList]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        todayCallsDetailsList <- map["TodayCallsDetailsList"]
    }
    
}

struct TodayCallsDetailsList : Mappable {
    var tcode : String?
    var location : String?
    var dateOfVisit : String?
    var startTime : String?
    var endTime : String?
    var duration : Duration?
    var doctorId : Int?
    var doctorName : String?
    var manager : String?
    var salesManager : String?
    var extManager : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        tcode <- map["Tcode"]
        location <- map["Location"]
        dateOfVisit <- map["DateOfVisit"]
        startTime <- map["StartTime"]
        endTime <- map["EndTime"]
        duration <- map["Duration"]
        doctorId <- map["DoctorId"]
        doctorName <- map["DoctorName"]
        manager <- map["Manager"]
        salesManager <- map["SalesManager"]
        extManager <- map["ExtManager"]
    }
    
}
