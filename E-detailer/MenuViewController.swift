//
//  MenuViewController.swift
//  E-detailer
//
//  Created by Ammad on 8/4/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Alamofire
import ObjectMapper

class MenuViewController: UIViewController {
    
    @IBOutlet weak var mEmpIdLabel: UILabel!
    @IBOutlet weak var empNameLabel: UILabel!
    @IBOutlet weak var logOutView: UIView!
    @IBOutlet weak var syncAllView: UIView!
    @IBOutlet weak var expViewOutlet: UIView!
    @IBOutlet weak var navViewOutlet: UIView!
    
    var loginViewController: UIViewController? = nil
    var calls: [CallModel] = []
    var Educalls: [HomeActivity] = []
    var callImages:[HomeImageCallModel] = []
    var selectedTab: String = "0"
    var callDetail: EmailResult?
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logOutView.layer.cornerRadius = 15
        logOutView.clipsToBounds = true
        syncAllView.layer.cornerRadius = 15
        syncAllView.clipsToBounds = true
        expViewOutlet.layer.cornerRadius = 15
        expViewOutlet.clipsToBounds = true
        empNameLabel.text = CommonUtils.getJsonFromUserDefaults(forKey: Constants.Employe_Name)
        
        mEmpIdLabel.text = "User ID: " + CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID)
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        
        let json = CommonUtils.getJsonFromUserDefaults(forKey: Constants.CallToUploadKey)

        if json == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No calls available to preview")
            return
        }
        calls = Mapper<CallModel>().mapArray(JSONString: json)!
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navViewOutlet.isHidden = true

        let json = CommonUtils.getJsonFromUserDefaults(forKey: Constants.CallToUploadKey)

        if json == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No calls available to preview")
            return
        }
        calls = Mapper<CallModel>().mapArray(JSONString: json)!
        

    }
    
    
    @IBAction func navBtn(_ sender: Any) {
        
        if navViewOutlet.isHidden == false {
            
            navViewOutlet.isHidden = true
            
        }else {
            
            navViewOutlet.isHidden = false
            
        }
        
    }
    
    
    @IBAction func sendToProductView(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ProductController") as! ProductViewController
        
    }
    
    @IBAction func syncExpenseBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "SendToSyncExpense", sender: nil)
        
    }
    
    @IBAction func expenseBtn(_ sender: Any) {
    
        self.performSegue(withIdentifier: "SendToExpenseScreen", sender: self)
    }
    
    
    @IBAction func sendToStatisticsScreen(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SendStatisticsScreen", sender: self)
        
    }
    //
    @IBAction func sendToProductScreen(_ sender: Any) {
        
        
    }
    
    
    //        CommonUtils.showCallBoxWithButtons(title: "Novo", message: "Choose the Appropriate Time", controller: self, onYesClicked: {()
    //           let screen = "1"
    //            CommonUtils.saveJsonToUserDefaults(forKey: Constants.screen1, withJson: screen)
    //            self.performSegue(withIdentifier: "SendAdverseReportingScreen", sender: self)
    //
    //        }, onNoClicked: {()
    //            let screen = "0"
    //             CommonUtils.saveJsonToUserDefaults(forKey: Constants.screen1, withJson: screen)
    //             self.performSegue(withIdentifier: "SendAdverseReportingScreen", sender: self)
    //
    //        })
    
    @IBAction func SendToAdverseReporting(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SendAdverseReportingScreen", sender: self)
        
    }
    
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let id = segue.identifier
        let cont = segue.destination
        
        switch id! {
            
        case "knowlegdeSegue":
            let cCont = cont as! CategoryViewController
            cCont.dataIndex = 2
            break
            
        case "teamSegue":
            let cCont = cont as! CategoryViewController
            cCont.dataIndex = 1
            break
            
        case "generalSegue":
            let cCont = cont as! CategoryViewController
            cCont.dataIndex = 0
            break
            
        case "SendTologinController":
            CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Are you sure you want to Logout?", controller: self, onYesClicked: {()in
                CommonUtils.saveJsonToUserDefaults(forKey: Constants.IsSignInKey, withJson: "0")
                CommonUtils.saveJsonToUserDefaults(forKey: Constants.key, withJson: "0")
                self.dismiss(animated: true, completion: nil)
            }, onNoClicked:{()in
                return
            })
            
            
            break
            
        case "SendToProductScreen":
            let destination = segue.destination as! ProductViewController
            destination.OpenType = "0"
            break
            
        case "HomeActivity":
            let destination = segue.destination as! ProductViewController
            destination.OpenType = "1"
            break
            
        default:
            break
            
        }
    }
    
    
    //    @IBAction func sendToStatisticsScreen(_ sender: Any) {
    //        self.performSegue(withIdentifier: "SendToStatisticsScreen", sender: self)
    //    }
    ////    @IBAction func sendToVideoController(_ sender: Any) {
    ////        self.performSegue(withIdentifier: "SendToAVIScreen", sender: self)
    ////    }
    ////    @IBAction func sendToContactController(_ sender: Any) {
    ////        self.performSegue(withIdentifier: "SendToAVIScreen", sender: self)
    ////    }
    //
    //    @IBAction func mExpBtn(_ sender: Any) {
    //
    //        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: "Sorry, This Fuctionality is not been set")
    //    }
    
    
    
    @IBAction func syncAllBtn(_ sender: Any) {
        
        let uuid = UUID().uuidString
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.Uuid, withJson: uuid)
        
        if calls.count == 0 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No data available to sync")
            return
        }
        
        //        var img: [Dictionary<String, Any>] = []
        //               self.image.forEach({body in
        //                   var params = Dictionary<String,Any>()
        //
        //                params["type"] = "PatientConsant";
        //                params["file"] = body.file ;
        //
        //                   img.append(params)
        //         })
        //
        //        Alamofire.upload(multipartFormData: {m in
        //
        //            for (index, body) in self.image.enumerated() {
        //
        //                let imag = body.type == nil ? "" : String(body.type!)
        //                m.append(imag.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "img[\(index)].type")
        //
        //                if body.file != nil && body.file != "" {
        //                    m.append(URL(string: body.file!)!, withName: "img[\(index)].file")
        //
        //                }
        //            }
        //        }, to: Constants.imageUrlApi, encodingCompletion:{result in
        //
        //            switch result {
        //            case .success(let upload, _, _):
        //                upload.responseJSON { response in
        //                    print(response.result.value)
        //
        //                    self.activitiyViewController.dismiss(animated: true, completion: {() in
        //
        //                        //On Dialog Close
        //                        if (response.error != nil) {
        //                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
        //                            return
        //                        }
        //
        //                        let uploadImageModel = Mapper<UploadImageModel>().map(JSONObject: response.result.value) //JSON to model
        //
        //                        if uploadImageModel != nil {
        //
        //                            if (uploadImageModel?.success)! {
        //
        //                                let imageUrl = uploadImageModel?.result
        //
        //                                CommonUtils.saveJsonToUserDefaults(forKey: Constants.imgURL, withJson: "\(String(describing: imageUrl))")
        //
        //                            } else {
        //                                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (uploadImageModel?.error!)!)
        //                            }
        //                        } else {
        //                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
        //                        }
        //                    })
        //
        //                }
        //
        //            case .failure(let encodingError):
        //                print(encodingError)
        //
        //                self.activitiyViewController.dismiss(animated: true, completion: {() in
        //                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Sorry, Something went wrong")
        //                })
        //            }
        //
        //        })
        
        var req = CallRequestModel(map: Map(mappingType: .fromJSON, JSON: [:]))
        
        req?.Calls = calls
        req?.ConnectivityMedium = "WIFI"
        req?.Lat = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LatitudeKey)
        req?.Lng = CommonUtils.getJsonFromUserDefaults(forKey: Constants.LongitudeKey)
        let ID = CommonUtils.getJsonFromUserDefaults(forKey: Constants.Uuid)
        req?.requestId = ID
        
        activitiyViewController.show(existingUiViewController: self)
        
        let a = req?.toJSON()
        // Api Executed
        Alamofire.request(Constants.CallApi, method: .post, parameters: a, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    if (response.value == "1") {
                        
                        let Constent = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ConstantNO)
                        
                        if Constent == "1" {
                            
                            self.updateInfo()
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.LastTimeOfUpload, withJson: String(CommonUtils.getCurrentTime()))
                            
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.CallToUploadKey, withJson: "[]")
                        }else {
                            
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.LastTimeOfUpload, withJson: String(CommonUtils.getCurrentTime()))
                            
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.CallToUploadKey, withJson: "[]")
                            
                            CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Form Submit Successfully", onOkClicked: {()in
                                
                                
                            })
                            
                        }
                        
                        
                        
                        //                        self.dismiss(animated: false, completion: nil)
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: response.value!)
                    }
                })
            })
        
    }
    
    func updateInfo()  {
        
        let UuID = CommonUtils.getJsonFromUserDefaults(forKey: Constants.Uuid)
        
        switch selectedTab {
        case "0":
            if (callDetail == nil) {
                emailApi(apiName: String(format: Constants.PostEmailAPi, UuID))
            } else if (callDetail != nil) {
                
                emailApi(apiName: String(format: Constants.PostEmailAPi, UuID))
                
            }
            break
            
        default:
            print("no case found")
        }
    }
    
    func emailApi(apiName: String) {
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
                    let emailModel = Mapper<EmailModel>().map(JSONString: response.value!) //JSON to model
                    
                    if emailModel != nil {
                        if (emailModel?.success)! {
                            
                            CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Email Successfully Sent", onOkClicked: {()in
                                
                            })
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (emailModel?.error!)!)
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                    
                })
            })
    }
    
    
    
    @IBAction func abcd(_ sender: Any) {
        
        //        self.performSegue(withIdentifier: "AddPatientScreen", sender: self)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AddPatientScreen") as! AddPatientViewController
    }
    
    
    
}
