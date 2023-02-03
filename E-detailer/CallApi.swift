//
//  CallApi.swift
//  E-detailer
//
//  Created by Ammad on 9/1/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class CallApi :BaseBL {
    
    static let API_DIR: String = Constants.RootDir + "/" + Constants.TypeApi

    override func getType() -> String {
        return Constants.TypeApi;
    }
    
    func getApiDir() -> URL {
        return FileUtils.createFolder(folderName: CallApi.API_DIR)!
    }
    
    func hasApiFile(url: String) -> String? {
        let apiName = (url as NSString).lastPathComponent + ".txt"
        let exists = FileUtils.hasFile(dir: getApiDir(), fileName: apiName)
        return (exists) ? getApiDir().absoluteString + apiName : nil;
    }
    
    func getApiFile(url: String) -> String? {
        let apiName = (url as NSString).lastPathComponent + ".txt"
        return apiName
    }
    
    func getAllDoctors (url: String, completionHandler: @escaping (DoctorModel?, String?) -> Void) {
        let filePath = hasApiFile(url: url)
        var params = Dictionary<String, String>()
        params["EmployeeId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);
        if (CommonUtils.isConnectedToNetwork()){
            Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: nil)
                .responseString(completionHandler: {(response) in
                    if (response.error != nil) {
                        completionHandler(nil, (response.error?.localizedDescription)!)
                        return
                    }
                    //On Dialog Close
                    print(response.value)
                    let doctorModel = Mapper<DoctorModel>().map(JSONString: response.value!) //JSON to model
                    
                    let isSuccess = FileUtils.writeDataToFile(logsPath: self.getApiDir(), file: self.getApiFile(url: url)!, data: response.value!)
                    
                    completionHandler(doctorModel, nil)
            })
        } else if (filePath != nil) {
            //reading
            do {
                let url = URL.init(string: filePath!)!;
                let savedText = try String(contentsOf: url)
                //On Dialog Close
                let doctorModel = Mapper<DoctorModel>().map(JSONString: savedText) //JSON to model
                completionHandler(doctorModel, nil)
            }
            catch {
                completionHandler(nil, "Unable to read the file!")
            }
        } else {
            completionHandler(nil, "Please connect the device with internet!")
        }
    }
    
    func getAllPlannedDoctors (url: String, completionHandler: @escaping (PlannedDoctorModel?, String?) -> Void) {
        let filePath = hasApiFile(url: url)
        var params = Dictionary<String, String>()
        params["EmployeeId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);
        if (CommonUtils.isConnectedToNetwork()){
            Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: nil)
                .responseString(completionHandler: {(response) in
                    if (response.error != nil) {
                        completionHandler(nil, (response.error?.localizedDescription)!)
                        return
                    }
                    //On Dialog Close
                    print(response.value)
                    let plannedDoctorModel = Mapper<PlannedDoctorModel>().map(JSONString: response.value!) //JSON to model
                    
                    let isSuccess = FileUtils.writeDataToFile(logsPath: self.getApiDir(), file: self.getApiFile(url: url)!, data: response.value!)
                    
                    completionHandler(plannedDoctorModel, nil)
            })
        } else if (filePath != nil) {
            //reading
            do {
                let url = URL.init(string: filePath!)!;
                let savedText = try String(contentsOf: url)
                //On Dialog Close
                let plannedDoctorModel = Mapper<PlannedDoctorModel>().map(JSONString: savedText) //JSON to model
                completionHandler(plannedDoctorModel, nil)
            }
            catch {
                completionHandler(nil, "Unable to read the file!")
            }
        } else {
            completionHandler(nil, "Please connect the device with internet!")
        }
    }
    
    func getAllManagers (url: String, completionHandler: @escaping (ManagerModel?, String?) -> Void) {
        
        let filePath = hasApiFile(url: url)
        var params = Dictionary<String, String>()
        
        params["EmployeeId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);
        
        if (CommonUtils.isConnectedToNetwork()){
            Alamofire.request(Constants.ManagerApi, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: nil)
                .responseString(completionHandler: {(response) in
                    
                    if (response.error != nil) {
                        completionHandler(nil, (response.error?.localizedDescription)!)
                        return
                    }
                    //On Dialog Close
                    let managerModel = Mapper<ManagerModel>().map(JSONString: response.value!) //JSON to model
                    
                    let isSuccess = FileUtils.writeDataToFile(logsPath: self.getApiDir(), file: self.getApiFile(url: url)!, data: response.value!)
                    
                    completionHandler(managerModel, nil)
                })
        } else if (filePath != nil) {
            //reading
            do {
                let url = URL.init(string: filePath!)!;
                let savedText = try String(contentsOf: url)
                //On Dialog Close
                let managerModel = Mapper<ManagerModel>().map(JSONString: savedText) //JSON to model
                completionHandler(managerModel, nil)
            }
            catch {
                completionHandler(nil, "Unable to read the file!")
            }
        } else {
            completionHandler(nil, "Please connect the device with internet!")
        }
        
    
    
    
    }
    
   
    
    func getAllPatient (url: String, completionHandler: @escaping (GetPatientDataModel?, String?) -> Void) {
           
           let filePath = hasApiFile(url: url)
//           var params = Dictionary<String, String>()
//
//           params["EmployeeId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);
           
           if (CommonUtils.isConnectedToNetwork()){
               Alamofire.request(Constants.GetPatientDataApi, method: .get, encoding: URLEncoding(destination: .queryString), headers: nil)
                   .responseString(completionHandler: {(response) in
                       
                       if (response.error != nil) {
                           completionHandler(nil, (response.error?.localizedDescription)!)
                           return
                       }
                       //On Dialog Close
                       let getPatientDataModel = Mapper<GetPatientDataModel>().map(JSONString: response.value!) //JSON to model
                       
                       let isSuccess = FileUtils.writeDataToFile(logsPath: self.getApiDir(), file: self.getApiFile(url: url)!, data: response.value!)
                       
                       completionHandler(getPatientDataModel, nil)
                   })
           } else if (filePath != nil) {
               //reading
               do {
                   let url = URL.init(string: filePath!)!;
                   let savedText = try String(contentsOf: url)
                   //On Dialog Close
                   let getPatientDataModel = Mapper<GetPatientDataModel>().map(JSONString: savedText) //JSON to model
                   completionHandler(getPatientDataModel, nil)
               }
               catch {
                   completionHandler(nil, "Unable to read the file!")
               }
           } else {
               completionHandler(nil, "Please connect the device with internet!")
           }
           
       
       
       
       }
    
    func getSampleAndExpense(url: String,isRequiredNetworkCall: Bool, completionHandler: @escaping (SampleAndExpenseModel?, String?) -> Void) {
           
           let filePath = hasApiFile(url: url)
           var paramses = Dictionary<String, String>()
           
           paramses["empId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);
           
           if ((isRequiredNetworkCall && CommonUtils.isConnectedToNetwork()) || filePath == nil) {
            Alamofire.request(Constants.SampleAndExpenseApi, method: .get, parameters: paramses, encoding: URLEncoding(destination: .queryString), headers: nil)
                           .responseString(completionHandler:{(response) in
                       let sampleAndExpenseModel = Mapper<SampleAndExpenseModel>().map(JSONString: response.value!) //JSON to model
                       
                       if (response.error != nil) {
                           completionHandler(nil, (response.error?.localizedDescription)!)
                           return
                       }
                       //On Dialog Close
                       
                       let isSuccess = FileUtils.writeDataToFile(logsPath: self.getApiDir(), file: self.getApiFile(url: url)!, data: response.value!)
                       
                       completionHandler(sampleAndExpenseModel, nil)
                   })
           } else if (filePath != nil) {
               //reading
               do {
                   let url = URL.init(string: filePath!)!;
                   let savedText = try String(contentsOf: url)
                   //On Dialog Close
                   let sampleAndExpenseModel = Mapper<SampleAndExpenseModel>().map(JSONString: savedText) //JSON to model
                   completionHandler(sampleAndExpenseModel, nil)
               }
               catch {
                   completionHandler(nil, "Unable to read the file!")
               }
           } else {
               completionHandler(nil, "Please connect the device with internet!")
           }
       }
    
    func getAllContacts(url: String, completionHandler: @escaping (ContactModel?, String?) -> Void) {
        
        let filePath = hasApiFile(url: url)
        var params = Dictionary<String, String>()
        
        params["EmployeeId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);
        
        if (CommonUtils.isConnectedToNetwork()){
            Alamofire.request(Constants.ContactApi, method: .get, encoding: JSONEncoding.default, headers: nil)
                .responseString(completionHandler: {(response) in
                    let contactModel = Mapper<ContactModel>().map(JSONString: response.value!) //JSON to model

                    if (response.error != nil) {
                        completionHandler(nil, (response.error?.localizedDescription)!)
                        return
                    }
                    //On Dialog Close
                    
                    let isSuccess = FileUtils.writeDataToFile(logsPath: self.getApiDir(), file: self.getApiFile(url: url)!, data: response.value!)
                    
                    completionHandler(contactModel, nil)
                })
        } else if (filePath != nil) {
            //reading
            do {
                let url = URL.init(string: filePath!)!;
                let savedText = try String(contentsOf: url)
                //On Dialog Close
                let contactModel = Mapper<ContactModel>().map(JSONString: savedText) //JSON to model
                completionHandler(contactModel, nil)
            }
            catch {
                completionHandler(nil, "Unable to read the file!")
            }
        } else {
            completionHandler(nil, "Please connect the device with internet!")
        }
        
        
        
        
    }
    
    
    func getAllStatistics(url: String, completionHandler: @escaping (StatisticsModel?, String?) -> Void) {
        
        let filePath = hasApiFile(url: url)
        var params = Dictionary<String, String>()
        
        params["EmployeeId"] = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EMP_ID);
        
        if (CommonUtils.isConnectedToNetwork()){
            Alamofire.request(Constants.StatisticsApi, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: nil)
                .responseString(completionHandler: {(response) in
                    let statisticsModel = Mapper<StatisticsModel>().map(JSONString: response.value!) //JSON to model
                    
                    if (response.error != nil) {
                        completionHandler(nil, (response.error?.localizedDescription)!)
                        return
                    }
                    //On Dialog Close
                    
                    let isSuccess = FileUtils.writeDataToFile(logsPath: self.getApiDir(), file: self.getApiFile(url: url)!, data: response.value!)
                    
                    completionHandler(statisticsModel, nil)
                })
        } else if (filePath != nil) {
            //reading
            do {
                let url = URL.init(string: filePath!)!;
                let savedText = try String(contentsOf: url)
                //On Dialog Close
                let statisticsModel = Mapper<StatisticsModel>().map(JSONString: savedText) //JSON to model
                completionHandler(statisticsModel, nil)
            }
            catch {
                completionHandler(nil, "Unable to read the file!")
            }
        } else {
            completionHandler(nil, "Please connect the device with internet!")
        }
        
        
        
        
    }
    
   
    
    
    
    
    
}
