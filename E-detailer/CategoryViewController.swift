//
//  PDFViewController.swift
//  E-detailer
//
//  Created by Ammad on 12/31/04.
//  Copyright © 2004 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var categoryListLayout: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var dataIndex: Int = 0;
    var dataList: [CategoryTree] = []
    var categoryListDataSource: CategoryListCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryListDataSource = CategoryListCell()
        categoryListDataSource.onClick = {(selectedModel: CategoryTree) in
            if selectedModel.childCategories != nil && !(selectedModel.childCategories?.isEmpty)! {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
                newViewController.dataList = selectedModel.childCategories!
                self.present(newViewController, animated: true, completion: nil)
                
            } else if selectedModel.documents != nil && !(selectedModel.documents?.isEmpty)!{
                // open pdf viewcontroller
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "PdfViewController") as! PDFViewController
                newViewController.pdfList = selectedModel.documents!
                self.present(newViewController, animated: true, completion: nil)
            } else {
                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "eDetailer", withMessage: "No PDFs found")
            }
        }
        
        if !dataList.isEmpty {
            categoryListDataSource.setItems(items: dataList)
        } else {
            callApi()
        }
        categoryCollectionView.dataSource = categoryListDataSource
    }
    
    func callApi() {
        
        var params = Dictionary<String, String>()
        
        params["EmployeeId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);
        
        Alamofire.request(Constants.CategoryApi, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                //On Dialog Close
                if (response.error != nil) {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: (response.error?.localizedDescription)!)
                    return
                }
                let categoryModel = Mapper<CategoryModel>().map(JSONString: response.value!) //JSON to model
                if categoryModel != nil && self.dataIndex < (categoryModel?.categoryTree?.count)! {
                    
                    self.categoryListDataSource.setItems(items: categoryModel?.categoryTree?[self.dataIndex].childCategories)
                    
                    self.categoryCollectionView.reloadData()
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Error", withMessage: "No Data Found")
                }
            })
    }
    @IBAction func onBackClick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}


