//
//  MedlineResetPasswordRequest.swift
//  Medline-DigitalSkinHealth
//
//  Created by Sunil Kumar Jaiswal on 09/03/21.
//

import Foundation

// MARK: - MedlineResetPasswordRequest
class MedlineResetPasswordRequest: Codable {
    let email: String
    let password: String
    let token: String
    
    init(email: String, password: String, token: String) {
        self.email = email
        self.password = password
        self.token = token
    }
    
    func bodyParams() -> [String: Any]? {
        return ["email" : email, "password" : password, "token" : token]
    }
    
    func requestType() -> MedlineServiceHttpMethod {
        return .post
    }
}
