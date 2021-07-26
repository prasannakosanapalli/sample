//
//  MLLoginViewModel.swift
//  MedLine-SkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
//

import Foundation
import PromiseKit

class MedlineLoginViewModel {
    enum LoginNavigation {
        case updatePassword
        case homeScreen
        case error
    }
    //MARK:- Email validation
    /// Email validation message
    /// - Parameter isValid: Email validation message
    /// - Returns: Error message
    func emailErrorText(isValid: Bool, emailText:String) -> String {
        var errorText = ""
        if isValid == false {
            errorText = localizedString("EMAIL_TEXTFIELD_VALIDATION")
        }
        if emailText.isNotEmpty() && !isValid {
            errorText = localizedString("EMAIL_FORMAT_VALIDATION")
        }
        return errorText
    }
    
    //MARK:- Password validation
    /// Password validation message
    /// - Parameter isValid: password validation result
    /// - Returns: Error message
    func passwordErrorText(isValid: Bool) -> String {
        var errorText = ""
        if isValid == false {
            errorText = localizedString("PASSWORD_TEXTFIELD_VALIDATION")
        }
        return errorText
    }

    //MARK:- Login API Service call
    /// Login API call
    /// - Parameters:
    ///   - email: user email
    ///   - password: User password
    /// - Returns: API response to View controller
    func callLoginAPI(email: String, password: String) -> Promise<(LoginNavigation, String)> {
        let loginRequest = MedlineLoginRequest(email: email, password: password)
        return Promise { seal in
            firstly {
                MedlineServiceManager.callLoginService(requestObject: loginRequest)
            }.done { (response) in
                if response.status == MedlineServiceConstant.kSuccess {
                    if let token = response.data?.token {
                        MedlineKeychainData.storeUserLoginToken(token:token)
                    }
                    if (response.data?.lastLogOn) != nil {
                        seal.fulfill((.homeScreen, MedlineServiceConstant.kSuccess)) // returns last log on if not null
                    } else {
                        seal.fulfill((.updatePassword, MedlineServiceConstant.kSuccess)) // returs only success if last log on is null
                    }
                } else {
                    seal.fulfill((.error, response.message ?? localizedString("SERVICE_RESPONSE_NULL_MESSAGE"))) // returns message -> expected error
                }
            }.catch { (error) in
                if error is GenericError {
                    let genError = error as! GenericError
                    seal.fulfill((.error, genError.error.description))
                } else {
                    seal.reject(error)
                }
            }
        }
    }
   
}
