//
//  AVIViewController.swift
//  E-detailer
//
//  Created by Ammad on 12/31/04.
//  Copyright © 2004 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import Zip

class AVIViewController: UIViewController {
    
    @IBOutlet weak var videoContentLayout: UIView!
    @IBOutlet weak var videoContentCollectionView: UICollectionView!
    @IBOutlet weak var videoProductCollectionView: UICollectionView!
    
    var videoContentDataSource: VideoContentCell!
    var videoProductDataSource: VideoProductDataSource!
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var videoProductBl: VideoProductBL = VideoProductBL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activitiyViewController = ActivityViewController(message: "Loading...")
        
        videoContentDataSource = VideoContentCell()
        videoContentCollectionView.dataSource = videoContentDataSource
        
        videoContentDataSource.onClickVideo = {(selectedModel: VideoContentResult) in
            self.onDownloadRequest(selectedModel: selectedModel)
        }
        
        videoProductDataSource = VideoProductDataSource()
        videoProductDataSource.onClick = {(selectedModel: VideoContentResult) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "videoController") as! VideoPlayerViewController
            newViewController.videoModel = selectedModel
            self.present(newViewController, animated: true, completion: nil)
        }
        
        videoProductCollectionView.dataSource = videoProductDataSource
        notifyVideosChanged();
    }
    
    func notifyVideosChanged() {
        var products = videoProductBl.getAllProducts()
        videoProductDataSource.setItems(items: products)
        videoProductCollectionView.reloadData()
    }
    
    @IBAction func BTNSync(_ sender: Any) {
        activitiyViewController.show(existingUiViewController: self)
        // Api Executed
        Alamofire.request(Constants.VideoContentApi, method: .get, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                self.activitiyViewController.dismiss(animated: false, completion: {() in
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                        return
                    }
                    
                    print(response.value)
                    
                    let videoContentModel = Mapper<VideoContentModel>().map(JSONString: response.value!) //JSON to model
                    if videoContentModel != nil {
                        if (videoContentModel?.success)! {
                            
                            self.videoContentLayout.isHidden = false
                            self.videoContentDataSource.setItems(items: videoContentModel?.result)
                            self.videoContentCollectionView.reloadData()
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (videoContentModel?.error!)!)
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "Empty Response is coming from server")
                    }
                })
            })
    }
    
    func onDownloadRequest(selectedModel: VideoContentResult) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = self.videoProductBl.getDownloadFile(fileNameToDownload: selectedModel.product_name!).addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)! as NSString
            
            return (URL.init(string: String(documentsURL))!, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        self.activitiyViewController.text(text: "Connecting...");
        self.activitiyViewController.show(existingUiViewController: self)
        
        let a = self.videoProductBl.getDownloadFile(fileNameToDownload: selectedModel.product_name!)
        
        let url = selectedModel.video_file_url?.replacingOccurrences(of: " ", with: "%20").replacingOccurrences(of: "//", with: "/")
        Alamofire.download(
            url!,
            method: .get,
            to: destination
        )
            .downloadProgress(closure: {(progress) in
                let per = Int(progress.fractionCompleted * 100)
                self.activitiyViewController.text(text: "Progress: \(per)%")
            })
            .response(completionHandler: {(defaultDownloadResponse) in
                
                if (defaultDownloadResponse.error != nil) {
                    self.activitiyViewController.dismiss()
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: (defaultDownloadResponse.error?.localizedDescription)!)
                    return
                }
                
                self.activitiyViewController.text(text: "Unzipping")
                
                do {
                    let filePath = defaultDownloadResponse.destinationURL
                    let unZipLocation = self.videoProductBl.getVideoDir()
                    
                    try Zip.unzipFile(filePath!, destination: unZipLocation, overwrite: true, password: nil, progress: { (progress) -> () in
                        
                        //! On complete progress will be 1.0
                        if progress == 1.0 {
                            self.activitiyViewController.dismiss()
                            // refresh collectionView
                            self.notifyVideosChanged()
                        }
                    })
                }
                catch {
                    print("Something went wrong")
                }
            })
    }
    
    @IBAction func BtnClose(_ sender: Any) {
        
        self.videoContentLayout.isHidden = true
    }
    @IBAction func onBackClick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
