//
//  CallListenerViewController.swift
//  E-detailer
//
//  Created by Ammad on 8/18/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import Alamofire

class CallListenerViewController: UIViewController {
    
    @IBOutlet weak var onSubmitRadius: UIButton!
    @IBOutlet weak var callListenerLayout: UIView!
    @IBOutlet weak var callListenerCollectionView: UICollectionView!
    
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var callListenerDataSource: CallListenerCell!
    var calls: [CallModel] = []
    var callImages:[ImageCallModel] = []
    var image : [UploadImage] = []
    var selectediIndex: CallModel? = nil
    var selectedTab: String = "0"
    var callDetail: EmailResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onSubmitRadius.layer.cornerRadius = 10
        onSubmitRadius.clipsToBounds = true
        callListenerDataSource = CallListenerCell()
        callListenerDataSource.onDetailClick = {(index: CallModel) in
            self.selectediIndex = index
            
        }
        
        callListenerDataSource.deleteCallback = {index in
            CommonUtils.showQuesBoxWithButtons(title: "Novo", message: "Are you sure you want to delete this Camp", controller: self, onYesClicked: {() in
                self.deleteItem(index: index)
            }, onNoClicked: {() in
                return
            })
        }
        
        let json = CommonUtils.getJsonFromUserDefaults(forKey: Constants.CallToUploadKey)
        
        if json == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No calls available to preview")
            return
        }
        calls = Mapper<CallModel>().mapArray(JSONString: json)!
        
        callListenerDataSource.setItems(calls: calls)
        callListenerCollectionView.dataSource = callListenerDataSource
        activitiyViewController = ActivityViewController(message: "Loading...")
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
    
    
    func reloadData() {
        var data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.CallToUploadKey)
        if data == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No Expense available to preview")
            return
        }
        if (data == "") {data = "[]"}
        self.calls = Mapper<CallModel>().mapArray(JSONString: data)!
        callListenerDataSource.callList = self.calls
        callListenerCollectionView.reloadData()
        
    }
    
    func deleteItem(index: Int) {
        calls.remove(at: index)
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.CallToUploadKey, withJson: Mapper().toJSONString(calls)!)
        reloadData()
    }
    
    @IBAction func onSubmitPressed(_ sender: Any) {
        
        let uuid = UUID().uuidString
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.Uuid, withJson: uuid)
        
        if calls.count == 0 {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: "No calls available to sync")
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
                            self.ImageUpload()
                            
                            CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Form Submit Successfully", onOkClicked: {()in
                                
                                self.dismiss(animated: true, completion: nil)
                                
                            })
                            
                        }
                        
                        
                        
                        //                        self.dismiss(animated: false, completion: nil)
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Novo", withMessage: response.value!)
                    }
                })
            })
        
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
                            
                            self.ImageUpload()
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (emailModel?.error!)!)
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: response.value!)
                    }
                    
                })
            })
    }
    
    func ImageUpload() {
        
        var imageses = CommonUtils.getJsonFromUserDefaults(forKey: Constants.imgPostData)
      
        if (imageses == "") {imageses = "[]"}
        
        callImages = Mapper<ImageCallModel>().mapArray(JSONString: imageses)!
        
            if callImages.count == 0 {
                
                CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Form Sync Successfully", onOkClicked: {()
                    self.dismiss(animated: true, completion: nil)
                })
                
            }
        
            activitiyViewController.show(existingUiViewController: self)
            Alamofire.upload(multipartFormData: {m in
                
                for (index, body) in self.callImages.enumerated() {
                  
                    m.append((body.Guid ?? "").data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "model[\(index)].Guid")
                    
                    if body.PatinetConsentAttachmentUrl == nil {
                        
                        m.append(("").data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "model[\(index)].PatinetConsentAttachmentUrl")
                           
                    }else{
                       
                        m.append(URL(string: body.PatinetConsentAttachmentUrl!)!, withName: "model[\(index)].PatinetConsentAttachmentUrl")
                        
                    }
                   
                }
            }, to: Constants.PostImageApi, encodingCompletion:{result in
                
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
                            
                            let loginModel = Mapper<LoginModel>().map(JSONObject: response.result.value) //JSON to model
                            
                            if loginModel != nil {
                                
                                if (loginModel?.success)! {
                                    
                                    CommonUtils.saveJsonToUserDefaults(forKey: Constants.imgPostData, withJson: "[]")
                                    
                                    CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Novo", withMessage: "Call Sync successfully", onOkClicked: {()
                                       
                                            self.dismiss(animated: true, completion: nil)
                                        
                                    })
                                    
                                } else {
                                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (loginModel?.error!)!)
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
    
    //    func emailApi() {
    //
    //        let abc = CommonUtils.getJsonFromUserDefaults(forKey: Constants.Uuid)
    //
    ////        var params = Dictionary<String, String>()
    //////        params["RequestIdentifier"] = abc;
    ////        params["RequestIdentifier"] = abc;
    //
    //        let params: Parameters = [
    //                "RequestIdentifier": "171198BC-2ED8-4108-B7D3-988EA1BE29DD"
    //            ]
    //
    //        Alamofire.request(Constants.PostEmailAPi, method: .get,parameters: params, encoding: JSONEncoding.default, headers: nil)
    //            .responseString(completionHandler: {(response) in
    //                // On Response
    //                self.activitiyViewController.dismiss(animated: false, completion: {() in
    //
    //                    //On Dialog Close
    //                    if (response.error != nil) {
    //                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
    //                        return
    //                    }
    //
    //                    let emailModel = Mapper<EmailModel>().map(JSONString: response.value!) //JSON to model
    //
    //                    if emailModel != nil {
    //
    //                        if (emailModel?.success)! {
    //
    //
    //                        } else {
    //                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (emailModel?.error!)!)
    //                        }
    //                    } else {
    //                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
    //                    }
    //                })
    //            })
    //
    //
    //
    //    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        if (id == "SendToCallDetailScreen"){
            let destination = segue.destination as! CallDetailViewController
            destination.selectedIndex = self.selectediIndex
        }
    }
    
    @IBAction func onBackClick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
