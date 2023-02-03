//
//  PdfBL.swift
//  E-detailer
//
//  Created by Ammad on 8/31/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation

class PdfBL: BaseBL {
    
    static let PDF_DIR: String = Constants.RootDir + "/" + Constants.TypePdf;
    
    override func getType() -> String {
        return Constants.TypePdf;
    }
    
    func getPdfDir() -> URL {
        return FileUtils.createFolder(folderName: PdfBL.PDF_DIR)!
    }


}
