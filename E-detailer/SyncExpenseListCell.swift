//
//  SyncExpenseListCell.swift
//  E-detailer
//
//  Created by macbook on 15/12/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//
//
//  SyncExpenseCellView.swift
//  Himont
//
//  Created by Macbook Air on 15/03/2021.
//  Copyright © 2021 Ammad. All rights reserved.
//

import Foundation
import UIKit

class SyncExpenseListCell: NSObject, UICollectionViewDataSource{
    var list:[ExpenseModel] = []
    var deleteCallback: ((Int) -> Void)? = nil
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SyncExpenseListCell", for: indexPath) as! SyncExpenseListCellView
        
        let getCode = list[indexPath.item].code
        cell.index = indexPath.row;
        cell.deleteCallback = deleteCallback;
        
        
        if getCode == "OA" {
            cell.AmountLabelView.isHidden = true
            cell.FromLabelView.isHidden = false
            cell.toLabelView.isHidden = false
            cell.FromLabelsView.isHidden = false
            cell.toLabelsViews.isHidden = false
            
            cell.expTypeLabelView.text =  "Expense"
//            cell.AmountLabelView.text = "\(list[indexPath.item].amount ?? 0)"
//            cell.DateLabelView.text = "\(list[indexPath.item].date ?? 0)"
            cell.DateLabelView.text = list[indexPath.item].date
            cell.nameLabelView.text = list[indexPath.item].expenseType
            cell.FromLabelView.text = list[indexPath.item].emp_City
            cell.toLabelView.text = list[indexPath.item].desName
            cell.noteLabelView.text = list[indexPath.item].notes
         
        }else {
            
            cell.expTypeLabelView.text =  "Expense"
            cell.AmountLabelView.text = "\(list[indexPath.item].amount ?? 0)"
//            cell.DateLabelView.text = "\(list[indexPath.item].date ?? 0)"
            cell.DateLabelView.text = list[indexPath.item].date
            cell.nameLabelView.text = list[indexPath.item].expenseType
//           cell.FromLabelView.text = list[indexPath.item].emp_City
//           cell.toLabelView.text = list[indexPath.item].desName
            cell.noteLabelView.text = list[indexPath.item].notes
        }
        
        return cell
    }
}
class SyncExpenseListCellView: UICollectionViewCell {
    
    
    @IBOutlet weak var expTypeLabelView: UILabel!
    @IBOutlet weak var nameLabelView: UILabel!
    @IBOutlet weak var noteLabelView: UILabel!
    @IBOutlet weak var AmountLabelView: UILabel!
    @IBOutlet weak var DateLabelView: UILabel!
    @IBOutlet weak var FromLabelView: UILabel!
    @IBOutlet weak var FromLabelsView: UILabel!
    @IBOutlet weak var toLabelsViews: UILabel!
    @IBOutlet weak var toLabelView: UILabel!
    
    
    var deleteCallback: ((Int) -> Void)? = nil
    var index: Int?

    @IBAction func DeleteBtnView(_ sender: Any) {
        self.deleteCallback!(index!)
    }
    
}
