//
//  MedlineResetPasswordViewModel.swift
//  Medline-DigitalSkinHealth
//
//  Created by Sunil Kumar Jaiswal on 09/03/21.
//

import Foundation
import UIKit
import PromiseKit

class MedlineResetPasswordViewModel {
    
    func newPasswordErrorText(isValid: Bool, isNotEmpty: Bool) -> String {
        var errorText = ""
        if isValid == false {
            errorText = localizedString("REGISTER_ACCOUNT_PASSWORD_VALIDATION")
        }
        if isValid == false && isNotEmpty == true {
            errorText = localizedString("PASSWORD_FORMAT_VALIDATION")
        }
        return errorText
    }

    func confirmPasswordErrorText(isValid: Bool, isEmpty: Bool) -> String {
        var errorText = ""
        if isEmpty == false {
            return localizedString("REGISTER_ACCOUNT_CONFIRM_PASSWORD_VALIDATION")
        }
        if isValid == false {
            errorText = localizedString("NEW_PASSWORD_NOTEQUAL_TO_CONFIRM_PASSWORD")
        }
        

        return errorText
    }
    
    func passwordValidation(password: String?) -> Bool {
        var isValid: Bool = false
            
        if retrieveProperString(retrieveString: password) != "" {
            isValid = retrieveProperString(retrieveString: password).isValidPassword()
        }
        return isValid
    }
        
    func newPasswordAndConfirmPasswordValidation(newPassword: String?, confirmPassword: String?) -> Bool {
        var isValid: Bool = false
        if retrieveProperString(retrieveString: newPassword) != "" && retrieveProperString(retrieveString: confirmPassword) != "" {
            if retrieveProperString(retrieveString: newPassword).isValidPassword() && retrieveProperString(retrieveString: confirmPassword).isValidPassword() {
                isValid = retrieveProperString(retrieveString: newPassword).doPasswordsMatch(conformPassword: retrieveProperString(retrieveString: confirmPassword))
            }
        }
        return isValid
    }
    
    func greetLabelText() -> String {
        return localizedString("SUCCESS_LABEL_TEXT")
    }
    
    func successLabelText() -> String {
        return localizedString("RESET_PASSWORD_SUCCESS_LABEL_TEXT")
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - email: email description
    ///   - password: password
    ///   - token: login token
    /// - Returns: success
    func callResetPasswordAPI(email: String, password: String, token: String) -> Promise<String> {
        let resetPasswordRequest = MedlineResetPasswordRequest(email: email, password: password, token: token)
        return Promise { seal in
            firstly {
                MedlineServiceManager.callResetPasswordService(requestObject: resetPasswordRequest)
            }.done { (response) in
                if response.status == MedlineServiceConstant.kSuccess {
                    seal.fulfill(MedlineServiceConstant.kSuccess)
                } else {
                    seal.fulfill(response.message ?? localizedString("SERVICE_RESPONSE_NULL_MESSAGE"))
                }
            }.catch { (error) in
                if error is GenericError {
                    let genError = error as! GenericError
                    seal.fulfill(genError.error.description)
                } else {
                    seal.reject(error)
                }
            }
        }
    }
}
