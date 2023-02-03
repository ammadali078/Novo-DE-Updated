//
//  ClicnicCallActivityViewController.swift
//  E-detailer
//
//  Created by Macbook Air on 08/12/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import DatePickerDialog

class ClicnicCallActivityViewController: UIViewController {
    
    @IBOutlet weak var clinicActivityDetailLayout: UIView!
    @IBOutlet weak var clinicActivityDetailCollectionView: UICollectionView!
    
    var ClinicActivityDetailDataSource: ClinicActivityDetailListCell!
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var selectedTab: String = "0"
    
    var callDetail: [CallDetailResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ClinicActivityDetailDataSource = ClinicActivityDetailListCell()
        clinicActivityDetailCollectionView.dataSource = ClinicActivityDetailDataSource
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        self.updateInfo()
        
    }
    
    func updateInfo()  {
        
        let userId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        let date = CommonUtils.getJsonFromUserDefaults(forKey: Constants.callselectedDate)
        switch selectedTab {
        case "0":
            if (callDetail == nil) {
                callState(apiName: String(format: Constants.getClicnicCallApi, userId, date))
            } else if (callDetail != nil) {
                
                callState(apiName: String(format: Constants.getClicnicCallApi, userId, date))
                
                
            }
            break
            
        default:
            print("no case found")
        }
    }
    
    
    func callState(apiName: String) {
        activitiyViewController.show(existingUiViewController: self)
        Alamofire.request(apiName, method: .get, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    let clinicCallDetailModel = Mapper<ClinicCallDetailModel>().map(JSONString: response.value!) //JSON to model
                    
                    if clinicCallDetailModel != nil {
                        if (clinicCallDetailModel?.success)! {
                            
                            if clinicCallDetailModel?.result == nil {
                                
                                CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "No Calls Available To Show", onOkClicked: {()
                                    
                                    self.dismiss(animated: true, completion: nil)
                                    
                                })
                                
                            } else {
                                if (self.selectedTab == "0") {
                                    
                                    self.callDetail = clinicCallDetailModel?.result
                                    self.ClinicActivityDetailDataSource.setItems(items: self.callDetail, type: self.selectedTab)
                                    self.clinicActivityDetailCollectionView.reloadData()
                                    
                                } else {
                                    
                                }
                                
                            }
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (clinicCallDetailModel?.error!)!)
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                    
                })
            })
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
