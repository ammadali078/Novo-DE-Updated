//
//  WebViewController.swift
//  E-detailer
//
//  Created by Ammad on 8/25/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import WebKit

class WebViewController: UIViewController {
    
    var productBl: ProductBL = ProductBL()
    var oldViewController: WebViewController? = nil
    var contentModel: ContentResult?
    @IBOutlet weak var contentWebViewOutlet: WKWebView!
    var delegate: ((EDASessions) -> Void)? = nil
    var currentSession: EDASessions? = nil
    @IBOutlet weak var webProductCollectionView: UICollectionView!
    @IBOutlet weak var webProductLayout: UIView!
    @IBOutlet weak var mBackBtn: UIButton!
    @IBOutlet weak var mSwitchBtn: UIButton!
    
    
    var webProductDataSource: WebContentListCell!
    
    override func viewDidLoad() {
        webProductDataSource = WebContentListCell()
        currentSession = EDASessions(map: Map(mappingType: .fromJSON, JSON: [:]))
        currentSession?.startTime = String(CommonUtils.getCurrentTime())
        currentSession?.title = contentModel?.product_name
        
        contentWebViewOutlet.load(URLRequest.init(url: URL.init(string: (contentModel?.presentation_file_url)!)!))
        webProductCollectionView.dataSource = webProductDataSource
        webProductDataSource.onClick = {(c) in
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            newViewController.contentModel = c
            newViewController.delegate = self.delegate
            newViewController.oldViewController = self
            
            self.present(newViewController, animated: true, completion: {() in
                
            })
        }
        
        
        if oldViewController != nil {
            oldViewController?.onClose()
        }
        
    }
    
    @IBAction func mSwitchBtn(_ sender: Any) {
        mSwitchBtn.layer.cornerRadius = 10
        mSwitchBtn.clipsToBounds = true
        self.webProductLayout.isHidden = false
        let products = productBl.getAllProducts()
        webProductDataSource.setItems(items: products)
        webProductCollectionView.reloadData()
    }
    @IBAction func onCloseProductBtn(_ sender: Any) {
        self.webProductLayout.isHidden = true
    }
    
    func onClose() {
        
        
        do {
            
            let javascript = "EDAClient.toString()"
            
            let edaLogs: Void = contentWebViewOutlet.evaluateJavaScript(javascript, completionHandler: nil)
            
            currentSession?.eDALogs = Mapper<EDALogs>().mapArray(JSONObject:edaLogs)
        } catch {
        }
        
        
        currentSession?.endTime = String(CommonUtils.getCurrentTime())
        delegate!(currentSession!)
        
        mBackBtn.layer.cornerRadius = 10
        mBackBtn.clipsToBounds = true
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.onClose()
    }
    
    
    func fromJSON(string: String) throws -> [[String: Any]] {
        let data = string.data(using: .utf8)!
        guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject] else {
            throw NSError(domain: NSCocoaErrorDomain, code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON"])
        }
        return jsonObject.map { $0 as! [String: Any] }
    }
}
