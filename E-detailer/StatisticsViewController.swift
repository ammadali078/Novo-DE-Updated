//
//  StatisticsViewController.swift
//  E-detailer
//
//  Created by Ammad on 12/31/04.
//  Copyright © 2004 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var empTextField: UILabel!
    @IBOutlet weak var empNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var territoryCodeLabel: UILabel!
    @IBOutlet weak var baseTownLabel: UILabel!
    @IBOutlet weak var teamZoneLabel: UILabel!
    @IBOutlet weak var totalCalsLabel: UILabel!
    @IBOutlet weak var eDAsViewedLabel: UILabel!
    @IBOutlet weak var slidesViewedLabel: UILabel!
    @IBOutlet weak var averageCallsLabel: UILabel!
    @IBOutlet weak var averageSessionsLabel: UILabel!
    @IBOutlet weak var averageSlidesLabel: UILabel!
    @IBOutlet weak var contactPointLabel: UILabel!
    @IBOutlet weak var attendenceLabel: UILabel!
    @IBOutlet weak var currentYear: UILabel!
    
    @IBOutlet weak var statisticsListLayout: UIView!
    
    @IBOutlet weak var statisticsCollectionView: UICollectionView!
    
    var statisticsListDataSource: StatisticsListCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statisticsListDataSource = StatisticsListCell()
        statisticsCollectionView.dataSource = statisticsListDataSource
        
        let callApi = CallApi()
        callApi.getAllStatistics(url: Constants.StatisticsApi, completionHandler: {(statisticsModel: StatisticsModel?, error: String?) in
            
            if (error != nil) {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: error!)
                return
            }
        
        self.empTextField.text = "Hi, " + CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        //!---------- Api Call
        var params = Dictionary<String, String>()
        
        params["EmployeeId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);

            var statisticsModelCopy =  statisticsModel
       
                // On Response
                    if statisticsModelCopy != nil {
                        self.empNameLabel.text = statisticsModelCopy?.pADetails?.name
                        self.teamNameLabel.text = statisticsModelCopy?.pADetails?.team
                        self.regionLabel.text = statisticsModelCopy?.pADetails?.region
                        self.territoryCodeLabel.text = statisticsModelCopy?.pADetails?.tCode
                        self.baseTownLabel.text = statisticsModelCopy?.pADetails?.baseTown
                        self.teamZoneLabel.text = statisticsModelCopy?.pADetails?.zone
                        self.totalCalsLabel.text = statisticsModelCopy?.stats?.totalCalls
                        self.eDAsViewedLabel.text = statisticsModelCopy?.stats?.eDAsViewed
                        self.slidesViewedLabel.text = statisticsModelCopy?.stats?.slidesViewed
                        self.averageCallsLabel.text = statisticsModelCopy?.stats?.avgCallDuration
                        self.averageSessionsLabel.text = statisticsModelCopy?.stats?.avgSessionDuration
                        self.averageSlidesLabel.text = statisticsModelCopy?.stats?.avgSlidesDuration
                        self.contactPointLabel.text = statisticsModelCopy?.pADetails?.contactPoint
                        self.currentYear.text = statisticsModelCopy?.currentMonthYear
                        
                        self.attendenceLabel.text = "P:\(statisticsModelCopy?.attendance?.present ?? 0) A:\(statisticsModelCopy?.attendance?.absent ?? 0)"
                        
                        self.statisticsListDataSource.setItems(items: statisticsModelCopy?.missedDoctorsInformation?.missedDoctorsInformationList)
                        self.statisticsCollectionView.reloadData()
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                
            })

    }
    @IBAction func onBackClick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
