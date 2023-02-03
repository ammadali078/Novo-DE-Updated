//
//  File.swift
//  E-detailer
//
//  Created by Ammad on 8/25/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation


class BaseBL : NSObject {
    
    static let ROOT_DIR: String = Constants.RootDir
    static let DOWNLOAD_DIR: String = Constants.RootDir + "/" + Constants.DownloadDir
    
    func getType() -> String { return ""; }
    
    func getDownloadFile(fileNameToDownload fileName: String) -> String {
        return getDownloadDir()!.absoluteString + "/" + fileName + ".zip"
    }
    
    func getDownloadDir() -> URL? {
        return FileUtils.createFolder(folderName: BaseBL.DOWNLOAD_DIR)
    }
    
    func getRootDir() -> URL? {
        return FileUtils.createFolder(folderName: BaseBL.ROOT_DIR);
    }
}
