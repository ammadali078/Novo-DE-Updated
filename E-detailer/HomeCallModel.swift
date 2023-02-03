//
//  HomeCallModel.swift
//  E-detailer
//
//  Created by macbook on 11/10/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper

struct HomeCallModel : Mappable {
    var homeActivity : [HomeActivity]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        homeActivity <- map["HomeActivity"]
    }

}

struct HomeActivity : Mappable {
    var patientId : String?
    var lat : String?
    var lng : String?
    var HomeActivityGuid : String?
    var employeeUserId : String?
    var startTime : String?
    var endTime : String?
    var activityObjective : String?
    var patinetConsent : String?
    var activityType : String?
    var hbA1c: String?
    var patinetConsentAttachmentUrl : String?
    var prescriptionAvailable : String?
    var prescriptionAttachmentUrl : String?
    var informationAboutProductGiven : String?
    var deviceDemonstrationGiven : String?
    var bloodGlucose : String?
    var bloodPressure : String?
    var weight : String?
    var feedbackStars : String?
    var comments : String?
    var homeActivityConcomitantProduct : [HomeActivityConcomitantProduct]?
    var homeActivityCurrentProduct : [HomeActivityCurrentProduct]?
    var homeActivityDiscussionTopic : [HomeActivityDiscussionTopic]?
    var homeActivityPreviousOtherProduct : [HomeActivityPreviousOtherProduct]?
    var homeActivityPreviousProduct : [HomeActivityPreviousProduct]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        patientId <- map["PatientId"]
        lat <- map["Lat"]
        lng <- map["Lng"]
        HomeActivityGuid <- map["HomeActivityGuid"]
        employeeUserId <- map["EmployeeUserId"]
        startTime <- map["StartTime"]
        endTime <- map["EndTime"]
        activityObjective <- map["ActivityObjective"]
        patinetConsent <- map["PatinetConsent"]
        activityType <- map["ActivityType"]
        hbA1c <- map["HbA1c"]
        patinetConsentAttachmentUrl <- map["PatinetConsentAttachmentUrl"]
        prescriptionAvailable <- map["PrescriptionAvailable"]
        prescriptionAttachmentUrl <- map["PrescriptionAttachmentUrl"]
        informationAboutProductGiven <- map["InformationAboutProductGiven"]
        deviceDemonstrationGiven <- map["DeviceDemonstrationGiven"]
        bloodGlucose <- map["BloodGlucose"]
        bloodPressure <- map["BloodPressure"]
        weight <- map["Weight"]
        feedbackStars <- map["FeedbackStars"]
        comments <- map["Comments"]
        homeActivityConcomitantProduct <- map["HomeActivityConcomitantProduct"]
        homeActivityCurrentProduct <- map["HomeActivityCurrentProduct"]
        homeActivityDiscussionTopic <- map["HomeActivityDiscussionTopic"]
        homeActivityPreviousOtherProduct <- map["HomeActivityPreviousOtherProduct"]
        homeActivityPreviousProduct <- map["HomeActivityPreviousProduct"]
    }

}
struct HomeActivityConcomitantProduct : Mappable {
    var productId : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        productId <- map["ProductId"]
    }

}
struct HomeActivityCurrentProduct : Mappable {
    var productId : String?
    var dose : Int?
    var deviceId : Int?
    var deviceDemo : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        productId <- map["ProductId"]
        dose <- map["Dose"]
        deviceId <- map["DeviceId"]
        deviceDemo <- map["DeviceDemo"]
    }

}
struct HomeActivityDiscussionTopic : Mappable {
    var explained : String?
    var discussionTopicId : String?
    var hardCopyProvided : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        explained <- map["Explained"]
        discussionTopicId <- map["DiscussionTopicId"]
        hardCopyProvided <- map["HardCopyProvided"]
    }

}
struct HomeActivityPreviousOtherProduct : Mappable {
    var otherProductId : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        otherProductId <- map["OtherProductId"]
    }

}
struct HomeActivityPreviousProduct : Mappable {
    var productId : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        productId <- map["ProductId"]
    }

}
