//
//  EmpCityViewCell.swift
//  E-detailer
//
//  Created by macbook on 15/12/2022.
//  Copyright © 2022 Ammad. All rights reserved.
//

import Foundation
import UIKit

protocol EmpCityTableViewDelegate: class {
    func onLblPress(position: Int)
}

class EmpCityViewCell: UITableViewCell{
    
    @IBOutlet weak var cityLbl: UILabel!
    weak var delegate: EmpCityTableViewDelegate? = nil
    var position = 0
    
    override func awakeFromNib() {
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(onLblClick))
       cityLbl.addGestureRecognizer(tap1)
        cityLbl.isUserInteractionEnabled = true
    }
    
    @objc func onLblClick(){
        delegate?.onLblPress(position: position)
    }
}
