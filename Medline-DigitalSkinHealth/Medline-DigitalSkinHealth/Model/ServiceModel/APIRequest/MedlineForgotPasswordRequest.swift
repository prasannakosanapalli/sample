//
//  MedlineForgotPasswordRequest.swift
//  Medline-DigitalSkinHealth
//
//  Created by Indela Venkata Mahesh Reddy on 09/03/21.
//

import Foundation

// MARK: - MedlineForgotPasswordRequest
class MedlineForgotPasswordRequest: Codable {
    let email: String
   
    init(email: String) {
        self.email = email
    }
    
    func bodyParams() -> [String: Any]? {
        return ["email" : email,
                "userPasswordResetURL": MedlineService.kUserPasswordResetURL,"isResendRequest": 0]
    }
    
    func requestType() -> MedlineServiceHttpMethod {
        return .post
    }
}
