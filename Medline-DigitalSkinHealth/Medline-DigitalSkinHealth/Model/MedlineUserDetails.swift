//
//  Userdetailsmodel.swift
//  UserAlertsForVersionchanges
//
//  Created by Chaitanya Kumari U on 16/02/21.
//

import Foundation

struct ResponseData: Codable {
    var person: [Person]
}

struct Person : Codable {
    var Username: String
    var Password: String
    var uid: String
    var Isuserignoredversion : Bool
    var timestamp : String
}

class MedlineUserManagement {
    
    var userlist = [Person]()
        
    //Mark :- Get and update data from bundle local json
    
    func loadData() {
        
        guard let mainUrl = Bundle.main.url(forResource: "Userdata", withExtension: "json") else { return }
        do {
                    let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                    let subUrl = documentDirectory.appendingPathComponent("Myfile.json")
                    loadFile(bundleUrL: mainUrl, filemanagerUrl: subUrl)
        } catch {
            print(error)
        }
    }
    
    //MARK :-  checking for local file path is nil if it is nil load data fromm bundle url
    
    func loadFile(bundleUrL: URL, filemanagerUrl: URL){
        if FileManager.default.fileExists(atPath: filemanagerUrl.path){
            
            decodeData(pathName: filemanagerUrl,isfromfilemanager : true)
            
            if userlist.isEmpty{
                decodeData(pathName: bundleUrL,isfromfilemanager : false)
            }
        }else{
            decodeData(pathName: bundleUrL,isfromfilemanager : false)
        }
        
    }
    
    //MARK :-  get the data from json file
    
    func decodeData(pathName: URL ,isfromfilemanager: Bool){
        print(pathName)
        do{
            
            if(isfromfilemanager){
                
                let jsonData = try Data(contentsOf: pathName)
                let decoder = JSONDecoder()
                userlist = try decoder.decode([Person].self, from: jsonData)
                
            }else{
            
            let data = try Data(contentsOf: pathName)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(ResponseData.self, from: data)
                userlist = jsonData.person
            print(jsonData)
                
               
            }
            
        } catch {}
    }
    
    //MARK :-  save the data from json to local file
    
    func SaveToFile(){
        
        let file = "Myfile.json"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            
            do {
                let jsonData = try JSONEncoder().encode(userlist)
                try jsonData.write(to: fileURL)
                
                let myJSON = try String(contentsOf: fileURL, encoding: .utf8)
                print("JSONLoad : \(myJSON)")
                print("JSONPath: \(fileURL)")
                
            }
            catch {/* error handling here */}
        }
    }
    
    //Mark :- checking userid details from local json
    
    func Updateuserdetails(userid : String){
        loadData()
        let index = retrieveIndex(of: "uid", for: userid, in: userlist)
        print(index)
        
        if(index != -1) {
            
            userlist[index].Isuserignoredversion = true
            userlist[index].timestamp =  retrieveNextDate()
            self.SaveToFile()
        }
        
    }
    
    //Mark :- getting the index of the array in the json
    
    func retrieveIndex(of key: String, for value: String, in dictionary : [Person]) -> Int{
        
        var count = 0
        for dictElement in dictionary{
            
            if  dictElement.uid  == value{
                return count
            }
            else{
                count = count + 1
            }
        }
        return -1
        
    }
    
    
    
    
    //MARK :- Time stamp code setting for ignored user
    
    func retrieveNextDate() -> String {
        
        let today = Date()
        print(today)
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: today)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: nextDate ??  Date())
        
        return dateString
        
    }
    
    //MARK :- checking Time stamp with current time stamp
    
    func checkTimeStamp(date: String) -> Bool {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")
        let datecomponents = dateFormatter.date(from: date)
        let now = Date()
        if (datecomponents! >= now) {
            return true
        } else {
            return false
        }
    }
    
    
    
    
}

