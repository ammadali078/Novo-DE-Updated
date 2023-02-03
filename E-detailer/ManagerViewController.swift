//
//  ManagerViewController.swift
//  E-detailer
//
//  Created by Ammad on 8/15/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class ManagerViewController: UIViewController {
    
    var delegate: (([Productmanagers]) -> Void)? = nil
    @IBOutlet weak var ManagerListLayout: UIView!
    
    @IBOutlet weak var onBorderRadius: UIButton!
    @IBOutlet weak var ManagerListCollectionView: UICollectionView!
    
    var ManagerListDataSource: ManagerListCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onBorderRadius.layer.cornerRadius = 10
        onBorderRadius.clipsToBounds = true
        
        ManagerListDataSource = ManagerListCell()
        ManagerListCollectionView.dataSource = ManagerListDataSource
        
        let callApi = CallApi()
        callApi.getAllManagers(url: Constants.ManagerApi, completionHandler: {(managerModel: ManagerModel?, error: String?) in
            
            if (error != nil) {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: error!)
                return
            }
            // On Response
            
            //temp variable
            var managerModelCopy =  managerModel
            
            //On Dialog Close
            if managerModelCopy != nil {
                
                if (managerModelCopy?.success)! {
                    
                    let result = managerModelCopy?.result
                    
                    if result?.managerID != nil && result?.managerID != "" {
                        var manager = Productmanagers(map: Map(mappingType: .fromJSON, JSON: [:]))
                        manager?.pMId = result?.managerID
                        manager?.id = Int((result?.managerID)!)
                        manager?.pM_Name = result?.managerName
                        manager?.designation = "Manager"
                        
                        managerModelCopy?.result?.productmanagers?.append(manager!)
                    }
                    
                    if result?.smid != nil && result?.smid != "" {
                        var manager = Productmanagers(map: Map(mappingType: .fromJSON, JSON: [:]))
                        manager?.pMId = result?.smid
                        manager?.id = Int((result?.smid)!)
                        manager?.pM_Name = result?.smname
                        manager?.designation = "Sales Manager"
                        
                        managerModelCopy?.result?.productmanagers?.append(manager!)
                    }
                    
                    if result?.bMId != nil && result?.bMId != "" {
                        var manager = Productmanagers(map: Map(mappingType: .fromJSON, JSON: [:]))
                        manager?.pMId = result?.bMId
                        manager?.id = Int((result?.bMId)!)
                        manager?.pM_Name = result?.bMName
                        manager?.designation = "Business Manager"
                        
                        managerModelCopy?.result?.productmanagers?.append(manager!)
                    }
                    
                    if result?.sSMId != nil && result?.sSMId != "" {
                        var manager = Productmanagers(map: Map(mappingType: .fromJSON, JSON: [:]))
                        manager?.pMId = result?.sSMId
                        manager?.id = Int((result?.sSMId)!)
                        manager?.pM_Name = result?.sSMName
                        manager?.designation = "Sub Sales Manager"
                        managerModelCopy?.result?.productmanagers?.append(manager!)
                    }
                    
                    self.ManagerListDataSource.setItems(items: managerModelCopy?.result?.productmanagers)
                    self.ManagerListCollectionView.reloadData()
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (managerModel?.error!)!)
                }
            } else {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
            }
        })
        
    }
    @IBAction func onManagerSubmitBtn(_ sender: Any) {
        CommonUtils.showMsgBoxWithButtons(title: "eDetailer", message: "Are you sure, you have selected all the managers?", controller: self, onYesClicked: {() in
            let list = self.ManagerListDataSource.dataList
            let selectedManagers: Dictionary<Int, Productmanagers> = self.ManagerListDataSource.selectedList
            
            let arrayFromDic = Array(selectedManagers.values.map{ $0 })
            
            self.dismiss(animated: true, completion: {() in
                self.delegate!(arrayFromDic)
            })
            
        })
    }
    
    @IBAction func onBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
