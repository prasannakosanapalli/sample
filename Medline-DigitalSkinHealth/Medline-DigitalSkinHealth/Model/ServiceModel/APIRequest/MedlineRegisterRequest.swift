//
//  MedlineBaseRequest.swift
//  Medline-DigitalSkinHealth
//
//  Created by Hariharan A on 08/03/21.
//

import Foundation

// MARK: - MedlineRegisterRequest
class MedlineRegisterRequest: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let customerNumber: String
    let password: String
    
    init(firstName: String,
         lastName: String,
         email: String,
         phone: String,
         customerNumber: String,
         password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.customerNumber = customerNumber
        self.password = password
    }
    
    func bodyParams() -> [String: Any]? {
        return ["firstName" : firstName,
                "lastName" : lastName,
                "email" : email,
                "phone" : phone,
                "customerNumber" : customerNumber,
                "password" : password,
                "usertype" : "intadmin",
                "isprivacypolicyagreed" : 1,
                "istermsandconditionagreed" : 1,
                "useractivationURL": MedlineService.kUserActivationURL]
    }
    
    func requestType() -> MedlineServiceHttpMethod {
        return .post
    }
}
