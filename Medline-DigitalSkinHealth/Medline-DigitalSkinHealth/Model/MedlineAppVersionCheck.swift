//
//  Appversioncheck.swift
//  UserAlertsForVersionchanges
//
//  Created by Chaitanya Kumari U on 16/02/21.
//

import Foundation
import UIKit

class MedlineAppVersionCheck {
    
    var userdatamodel = MedlineUserManagement()
    
    // Get user data from bundle json file
    
    func retrievedatafromjson()-> NSDictionary {
        
        if let path = Bundle.main.path(forResource: "versionupdate", ofType: "json") {
            
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let userData = jsonResult as? [String : Any] {
                    if let registartion : NSDictionary = userData["VersionData"] as? NSDictionary {
                        return registartion
                    }
                }
                
            } catch {
            }
        }
        return [:]
    }
    
    // Getting current version of the app
    
    func version() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        // let build = dictionary["CFBundleVersion"] as! String
        return version
    }
    
    // version comparision based on ignored user
    
    func checkversions(userID : String) -> (Bool,Bool,String,String,String , Bool) {
      
        let versionval = version()
        let jsondata = retrievedatafromjson()
        let showAlert = retrieveUserDetails(user_ID: userID)
        let versiontitle = jsondata["Title"]as! String
        let versioninfo = jsondata["messege"]as! String
        let storelink = jsondata["iosAppLink"]as! String
        
        let forceupdateval = jsondata["Isforceupdate"]as! Bool
        
        if let storeversion = jsondata["StoreVersion"]as? String {
            
            if(versionval.compare(storeversion, options: .numeric) == .orderedSame){
                
                return(false,forceupdateval,versiontitle,versioninfo,storelink , showAlert)
                
            } else if(storeversion.compare(versionval, options: .numeric) == .orderedDescending){
                    return(true,forceupdateval,versiontitle,versioninfo,storelink , showAlert)
              
                
            }
               
        }
        return(false,false,versiontitle,versioninfo,storelink, showAlert)
        
        
        
    }
    
  //  getting user details from local file path
    
    func retrieveUserDetails(user_ID : String) -> Bool {
        
        userdatamodel.loadData()
        let usersData = userdatamodel.userlist
        let index = userdatamodel.retrieveIndex(of: "uid", for: user_ID, in: usersData)
        if index != -1 {
        let isupdateboolval = usersData[index].Isuserignoredversion
        let timestampvalue = usersData[index].timestamp
        if(isupdateboolval == true){
            return checkTimeStampComparision(storedTimeStamp: timestampvalue)
        }
            
        }
        return false
    }
    
    // time stam comparision for version update ignored user
    
    func checkTimeStampComparision(storedTimeStamp : String) -> Bool {
        if(userdatamodel.checkTimeStamp(date: storedTimeStamp) == true){
            return true
        }
        return false
        
    }
    
    // To get version from store
    
    func retrieveStorevVersionofApp() {
        
        guard let bundleId = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String else { return }
        guard let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(bundleId)&country=br") else { return }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data)
                    guard let json = jsonObject as? [String: Any] else {
                        print("The received that is not a Dictionary")
                        return
                    }
                    let results = json["results"] as? [[String: Any]]
                    let firstResult = results?.first
                    let currentVersion = firstResult?["version"] as? String
                    print("currentVersion: ", currentVersion)
                } catch let serializationError {
                    print("Serialization Error: ", serializationError)
                }
            } else if let error = error {
                print("Error: ", error)
            } else if let response = response {
                print("Response: ", response)
            } else {
                print("Unknown error")
            }
        }
        task.resume()
    }
}
