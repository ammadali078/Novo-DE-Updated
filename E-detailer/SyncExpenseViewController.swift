//
//  SyncExpenseViewController.swift
//  E-detailer
//
//  Created by macbook on 15/12/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit
import Alamofire

class SyncExpenseViewController: UIViewController {
    
    @IBOutlet weak var syncExpenseLayout: UIView!
    @IBOutlet weak var syncExpenseCollectionView: UICollectionView!
    @IBOutlet weak var syncBtnOutlet: UIButton!
    
    var activitiyViewController: ActivityViewController!
    
    var ds: SyncExpenseListCell!
    var callExpenses:[ExpenseModel] = []
    
    override func viewDidLoad() {
        
        let data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.expPostData)
        if data == "[]" || data == "" {
            self.syncBtnOutlet.isHidden = true
            return
        }
        ds = SyncExpenseListCell()
        
        ds.deleteCallback = {index in
            CommonUtils.showCallBoxWithYesButtons(title: "Novo", message: "Are you sure you want to delete this form", controller: self, onYesClicked: {() in
                self.deleteItem(index: index)
            })
        }
        
        syncExpenseCollectionView.dataSource = ds
        activitiyViewController = ActivityViewController(message: "Loading...")
        reloadData()
        
    }
    
    func reloadData() {
        var data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.expPostData)
        if data == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Expense available to preview")
            return
        }
        if (data == "") {data = "[]"}
        self.callExpenses = Mapper<ExpenseModel>().mapArray(JSONString: data)!
        ds.list = self.callExpenses
        syncExpenseCollectionView.reloadData()
        
    }
    
    func deleteItem(index: Int) {
        callExpenses.remove(at: index)
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.expPostData, withJson: Mapper().toJSONString(callExpenses)!)
        reloadData()
        
       
        let data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.expPostData)
        if data == "[]" || data == "" {
            self.syncBtnOutlet.isHidden = true
            return
        }
    }
    
    
    @IBAction func syncBtnClicked(_ sender: Any) {
        
            if callExpenses.count == 0 {
                
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Expense available to sync")
                return
            }
        activitiyViewController.show(existingUiViewController: self)
            
            var expenses: [Dictionary<String, Any>] = []
            self.callExpenses.forEach({body in
                var params = Dictionary<String,Any>()
                
                params["Notes"] = body.notes ;
                params["Type"] = body.id ?? "";
                params["Amount"] = body.amount ?? "";
                params["MSRId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);
                params["ExpenseDate"] = body.date ?? "";
                params["ImagePath"] = "" ;
                params["ImageName"] = "" ;
                params["destinationId"] = 0;
                params["DistanceInKM"] = 0.0;
                params["HopDestinationId"] = body.desId ?? "";
                params["HopFromId"] = body.cityId ?? "";
                expenses.append(params)
            })
            
            var root = Dictionary<String, [Dictionary<String, Any>]>()
            
            root["expense"] = expenses
            root["Samples"] = []
            
            
            //        public func upload(
            //            multipartFormData: @escaping (MultipartFormData) -> Void,
            //            usingThreshold encodingMemoryThreshold: UInt64 = SessionManager.multipartFormDataEncodingMemoryThreshold,
            //            to url: URLConvertible,
            //            method: HTTPMethod = .post,
            //            headers: HTTPHeaders? = nil,
            //            encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?)
            //        {
            
            
            Alamofire.upload(multipartFormData: {m in
                
                for (index, body) in self.callExpenses.enumerated() {
                    
                    m.append(body.notes!.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "expense[\(index)].Notes")
                    
                    let type = body.id == nil ? "" : String(body.id!)
                    
                    m.append(type.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "expense[\(index)].Type")
                    
                    let amount = body.amount == nil ? "" : String(body.amount!)
                    //                m.append(amount!.data, withName: "expense[\(index)].Amount")
                    m.append(amount.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "expense[\(index)].Amount")
                    
                    m.append(CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID).data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "expense[\(index)].MSRId")
                    
                    m.append((body.date ?? "").data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "expense[\(index)].ExpenseDate")
                    
                    m.append(0.data, withName: "expense[\(index)].destinationId")
                    m.append((0.0).data, withName: "expense[\(index)].DistanceInKM")
                    
                    let desId = body.desId == nil ? "" : String(body.desId!)
                    //                m.append(desId!.data, withName: "expense[\(index)].HopDestinationId")
                    m.append(desId.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "expense[\(index)].HopDestinationId")
                    
                    let cityId = body.cityId == nil ? "" : String(body.cityId!)
                    //                m.append(cityId!.data, withName: "expense[\(index)].HopFromId")
                    m.append(cityId.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "expense[\(index)].HopFromId")
                    
                    if body.fileName != nil && body.fileName != "" {
                        m.append(URL(string: body.filePath!)!, withName: "expense[\(index)].ImagePath")
                        m.append((body.fileName ?? "").data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "expense[\(index)].ImageName")
                    }
                }
            }, to: Constants.PostSamAndExpenseApi, encodingCompletion:{result in
                
                switch result {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print(response.result.value)
                        
                        self.activitiyViewController.dismiss(animated: true, completion: {() in
                            
                            //On Dialog Close
                            if (response.error != nil) {
                                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                                return
                            }
                            
                            let postSamAndExpModel = Mapper<PostSamAndExpModel>().map(JSONObject: response.result.value) //JSON to model
                            
                            if postSamAndExpModel != nil {
                                
                                if (postSamAndExpModel?.success)! {
                                    
                                    CommonUtils.saveJsonToUserDefaults(forKey: Constants.expPostData, withJson: "[]")
                                    
                                    self.reloadData()
                                    
                                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Success", withMessage: (postSamAndExpModel?.result)!)
                                    
                                    if self.callExpenses.count == 0 {
                                        self.syncBtnOutlet.isHidden = true
                                    }
                                    
                                } else {
                                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (postSamAndExpModel?.error!)!)
                                }
                            } else {
                                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                            }
                        })
                        
                    }
                    
                case .failure(let encodingError):
                    print(encodingError)
                    
                    self.activitiyViewController.dismiss(animated: true, completion: {() in
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "Sorry, Something went wrong")
                    })
                }
                
            })
            
            
            
            
            
            
            
            //        Alamofire.upload( method: .post,
            //                          to: Constants.PostSamAndExpenseApi,
            //                          multipartFormData: { multipartFormData in
            //                            //                             multipartFormData.appendBodyPart(fileURL: imagePathUrl!, name: "photo")
            //                            //                             multipartFormData.appendBodyPart(fileURL: videoPathUrl!, name: "video")
            //                            //                             multipartFormData.appendBodyPart(data: Constants.AuthKey.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"authKey")
            //                            //                             multipartFormData.appendBodyPart(data: "\(16)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"idUserChallenge")
            //                            //                             multipartFormData.appendBodyPart(data: "comment".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"comment")
            //                            //                             multipartFormData.appendBodyPart(data:"\(0.00)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"latitude")
            //                            //                             multipartFormData.appendBodyPart(data:"\(0.00)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"longitude")
            //                            //                             multipartFormData.appendBodyPart(data:"India".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"location")
            //        },
            //                          encodingCompletion: { encodingResult in
            ////                              switch encodingResult {
            ////                              case .Success(let upload, _, _):
            ////                                  upload.responseJSON { request, response, JSON, error in
            ////
            ////
            ////                                  }
            ////                              case .Failure(let encodingError):
            ////
            ////                              }
            //                          }
            //        )
            
            
            //        Alamofire.request(Constants.PostSamAndExpenseApi, method: .post, parameters: root, encoding: JSONEncoding.default, headers: nil)
            //            .responseString(completionHandler:{(response) in
            //                // On Response
            //                self.activitiyViewController.dismiss(animated: true, completion: {() in
            //
            //                    //On Dialog Close
            //                    if (response.error != nil) {
            //                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
            //                        return
            //                    }
            //
            //                    let postSamAndExpModel = Mapper<PostSamAndExpModel>().map(JSONString: response.value!) //JSON to model
            //
            //                    if postSamAndExpModel != nil {
            //
            //                        if (postSamAndExpModel?.success)! {
            //
            //
            //                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.expPostData, withJson: "[]")
            //
            //                            self.reloadData()
            //
            //                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Success", withMessage: (postSamAndExpModel?.result)!)
            //
            //                        } else {
            //                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (postSamAndExpModel?.error!)!)
            //                        }
            //                    } else {
            //                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
            //                    }
            //                })
            //            })
            
            
        }
    
    @IBAction func BackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
protocol DataConvertible {
    init?(data: Data)
    var data: Data { get }
}

extension DataConvertible where Self: ExpressibleByIntegerLiteral{
    
    init?(data: Data) {
        var value: Self = 0
        guard data.count == MemoryLayout.size(ofValue: value) else { return nil }
        _ = withUnsafeMutableBytes(of: &value, { data.copyBytes(to: $0)} )
        self = value
    }
    
    var data: Data {
        return withUnsafeBytes(of: self) { Data($0) }
    }
}

extension Int : DataConvertible { }
extension Float : DataConvertible { }
extension Double : DataConvertible { }
