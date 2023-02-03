//
//  FileUtils.swift
//  E-detailer
//
//  Created by Ammad on 8/25/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation


class FileUtils : NSObject {
    
    static func createFolder(folderName: String) -> URL? {
        let fileManager = FileManager.default
        // Get document directory for device, this should succeed
        if let documentDirectory = fileManager.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first {
            // Construct a URL with desired folder name
            let folderURL = documentDirectory.appendingPathComponent(folderName)
            // If folder URL does not exist, create it
            if !fileManager.fileExists(atPath: folderURL.path) {
                do {
                    // Attempt to create folder
                    try fileManager.createDirectory(atPath: folderURL.path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
                } catch {
                    // Creation failed. Print error & return nil
                    print(error.localizedDescription)
                    return nil
                }
            }
            // Folder either exists, or was created. Return URL
            return folderURL
        }
        // Will only be called if document directory not found
        return nil
    }
    
    
    static func createFile (url: String) {
        
        // First create a FileManager instance
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let filePath = (documentDirectory?.appendingPathComponent(url).absoluteString)!
        if(!fileManager.fileExists(atPath:filePath)){
            fileManager.createFile(atPath: url, contents: nil, attributes: nil)
        }else{
            print("File is already created")
        }
    }
    
    static func fileList (documentsUrl: URL) -> [URL] {
        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
           
            return directoryContents
        } catch {
            print(error.localizedDescription)
        }
        return [];
    }
    
    
    
    static func hasFile (dir:URL, fileName: String) -> Bool {
        let filePath = dir.appendingPathComponent(fileName).path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            return true
        } else {
            return false
        }
    }
    
    static func writeDataToFile(logsPath: URL?, file: String, data: String)-> Bool {
        do {
            try FileManager.default.createDirectory(atPath: logsPath!.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            NSLog("Unable to create directory \(error.debugDescription)")
        }
        
        let fileName = logsPath?.appendingPathComponent(file)
        
        do {
            try data.write(to: fileName!, atomically: false, encoding: String.Encoding.utf8)
            return true
        } catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
            return false
        }
    }
}
