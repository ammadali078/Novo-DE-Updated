//
//  PdfDetailViewController.swift
//  E-detailer
//
//  Created by Ammad on 8/31/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit
class PdfDetailViewController : UIViewController {
    var pdf: String = ""
    
    override func viewDidLoad() {
    }
    @IBAction func onBackClick(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
