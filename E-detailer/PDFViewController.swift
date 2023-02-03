//
//  PDFViewController.swift
//  E-detailer
//
//  Created by Ammad on 8/18/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PDFViewController: UIViewController {
    
    var pdfList: [Documents] = []
    @IBOutlet weak var pdfLayout: UIView!
    @IBOutlet weak var pdfCollectionView: UICollectionView!
    var pdfListDataSource: PDFListCell!
    var pdfBl: PdfBL = PdfBL()
    var openPdfPath: String? = nil
    
    override func viewDidLoad() {
        pdfListDataSource = PDFListCell()
        pdfListDataSource.pdfList = pdfList;
        
        pdfListDataSource.onClick = {(selectedModel: Documents) in
            let dir = self.pdfBl.getPdfDir()
            let url = selectedModel.path!.replacingOccurrences(of: "~/", with: Constants.BaseUrl)
            let fileName = NSString.init(string: url).lastPathComponent
            
            if (FileUtils.hasFile(dir: dir, fileName: fileName))  {
                self.openPdf(dir: dir, fileName: fileName)
            } else {
                self.downloadPdf(url: url, fileName: fileName)
            }
        }
        pdfCollectionView.dataSource = pdfListDataSource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var id: String = segue.identifier!
        if (id == "pdf") {
            var viewer: PdfDetailViewController = segue.destination as! PdfDetailViewController
            viewer.pdf = openPdfPath!
        }
    }
    
    func openPdf (dir: URL, fileName: String) {
        openPdfPath = dir.absoluteString + fileName
        performSegue(withIdentifier: "pdf", sender: nil)
    }
    
    func downloadPdf (url: String, fileName:String) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            
            var documentsURL = self.pdfBl.getPdfDir().absoluteString + fileName;
            return (URL.init(string: documentsURL.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let downloadUrl = url.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        
        Alamofire.download(
            downloadUrl,
            method: .get,
            to: destination
        )
            .downloadProgress(closure: {(progress) in
                //            let per = Int(progress.fractionCompleted * 100)
                //            self.activitiyViewController.text(text: "Progress: \(per)%")
            })
            .response(completionHandler: {(downloadHandler) in
                self.openPdf(dir: self.pdfBl.getPdfDir(), fileName: fileName)
            })
        
    }
    
    @IBAction func onBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
