//
//  ServiceConstant.swift
//  MedLine-SkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
//

import Foundation

struct MedlineService {
    static var kBaseURL: String = {
        Environment.configuration(EnvKey.baseUrl)
    }()
    
    static let kSubscriptionKey: String = {
        Environment.configuration(EnvKey.subscriptionKey)
    }()
    
    static let kUserActivationURL: String = {
        Environment.configuration(EnvKey.userActivationURL)
    }()
    
    static let kUserPasswordResetURL: String = {
        Environment.configuration(EnvKey.userPasswordResetURL)
    }()
    
    static let kLoginPath: String = "userlogin"
    static let kRegisterPath: String = "registeruser"
    static let kResetPasswordPath: String = "resetpassword"
    static let kForgotPasswordPath: String = "forgotpassword"

}

struct MedlineServiceConstant {
    static let kSuccess = "success"
    static let k200StatusCode = "200"
    static let contentType = "application/json; charset=utf-8"
    static let accept = "application/json"
}

enum MedlineServiceHttpMethod: String {
    case post = "post"
    case get  = "get"
}
