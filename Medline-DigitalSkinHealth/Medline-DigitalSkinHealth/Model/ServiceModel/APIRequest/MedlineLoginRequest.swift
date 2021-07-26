//
//  MedlineLoginRequest.swift
//  Medline-DigitalSkinHealth
//
//  Created by Vijay Guruju on 08/03/21.
//

import Foundation

//MARK:- Login Request Model
class MedlineLoginRequest: Codable {
    let email: String
    let password: String
    
    init(email: String,password: String) {
        self.email = email
        self.password = password
    }
    
    func bodyParams() -> [String: Any]? {
        return [
                "email" : email,
                "password" : password
               ]
                
    }
    
    func requestType() -> MedlineServiceHttpMethod {
        return .post
    }
}
