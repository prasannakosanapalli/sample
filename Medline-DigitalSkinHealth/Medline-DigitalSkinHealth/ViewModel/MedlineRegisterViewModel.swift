//
//  MedlineRegisterViewModel.swift
//  Medline-DigitalSkinHealth
//
//  Created by Hariharan A on 08/02/21.
//

import Foundation
import UIKit
import PromiseKit

class MedlineRegisterViewModel {
    
    func firstNameErrorText(name: String) -> String {
        var errorText = ""
        if name.isEmpty {
            errorText = localizedString("REGISTER_ACCOUNT_FIRST_NAME_VALIDATION")
        }
        return errorText
    }
    
    func lastNameErrorText(name: String) -> String {
        var errorText = ""
        if name.isEmpty {
            errorText = localizedString("REGISTER_ACCOUNT_LAST_NAME_VALIDATION")
        }
        return errorText
    }
    
    func customerIdErrorText(customer: String) -> String {
        var errorText = ""
        if customer.isEmpty {
            errorText = localizedString("REGISTER_ACCOUNT_CUSTOMER_NUMBER_VALIDATION")
        }
        return errorText
    }
    
    func phoneNumberErrorText(phoneNumber: String) -> String {
        var errorText = ""
        if phoneNumber.isEmpty {
            errorText = localizedString("REGISTER_ACCOUNT_PHONENUMBER_VALIDATION")
        } else if phoneNumber.isValidMobileNumber() == false {
            errorText = localizedString("PHONENUMBER_FORMAT_VALIDATION")
        }
        return errorText
    }
    
    func emailErrorText(email: String) -> String {
        var errorText = ""
        if email.isEmpty {
            errorText = localizedString("REGISTER_ACCOUNT_EMAIL_VALIDATION")
        } else if email.isValidEmail() == false {
            errorText = localizedString("EMAIL_FORMAT_VALIDATION")
        }
        return errorText
    }
    
    func passwordErrorText(password: String) -> String {
        var errorText = ""
        if password.isEmpty {
            errorText = localizedString("REGISTER_ACCOUNT_PASSWORD_VALIDATION")
        } else if password.isValidPassword() == false {
            errorText = localizedString("PASSWORD_FORMAT_VALIDATION")
        }
        return errorText
    }

    func confirmPasswordErrorText(conformPassword: String, password: String) -> String {
        var errorText = ""
        if conformPassword.isEmpty {
            return localizedString("REGISTER_ACCOUNT_CONFIRM_PASSWORD_VALIDATION")
        }
        if password.doPasswordsMatch(conformPassword: conformPassword) == false {
            errorText = localizedString("NEW_PASSWORD_NOTEQUAL_TO_CONFIRM_PASSWORD")
        }
        return errorText
    }
    
    func agreeTermErrorMessage() -> String {
        return localizedString("TERMCONDITION_PRIVACYPOLICY_VALIDATION")
    }
    
    func greetLabelText() -> String {
        return localizedString("CONGRATULATIONS_LABEL_TEXT")
    }
    
    func successLabelText() -> String {
        return localizedString("REGISTER_ACCOUNT_SUCCESS_LABEL_TEXT")
    }
    
    func callRegisterAPI(firstName: String,
                         lastName: String,
                         email: String,
                         phone: String,
                         customerNumber: String,
                         password: String) -> Promise<String> {
        let registerRequest = MedlineRegisterRequest(firstName: firstName,
                                                     lastName: lastName,
                                                     email: email,
                                                     phone: phone,
                                                     customerNumber: customerNumber,
                                                     password: password)
        return Promise { seal in
            firstly {
                MedlineServiceManager.callNewUserRegisterService(requestObject: registerRequest)
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

