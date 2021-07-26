//
//  MedlineForgotPasswordViewModel.swift
//  Medline-DigitalSkinHealth
//
//  Created by Indela Venkata Mahesh Reddy on 09/03/21.
//

import Foundation
import UIKit
import PromiseKit

class MedlineForgotPasswordViewModel {
    
    func emailErrorText(isValid:Bool, emailText: String) -> String {
        var errorText = ""
        if isValid == false {
            errorText = localizedString("EMAIL_TEXTFIELD_VALIDATION")
        }
        if isValid == false && emailText.isNotEmpty() {
            errorText = localizedString("EMAIL_FORMAT_VALIDATION")
        }
        return errorText
    }
        
    func greetLabelText() -> String {
        return localizedString("CONGRATULATIONS_LABEL_TEXT")
    }
    
    func successLabelText() -> String {
        return localizedString("REGISTER_ACCOUNT_SUCCESS_LABEL_TEXT")
    }
    
    func callForgotPasswordAPI(email: String) -> Promise<String> {
    
        let forgotPasswordRequest = MedlineForgotPasswordRequest(email: email)
        return Promise { seal in
            firstly {
                MedlineServiceManager.callForgotPasswordService(requestObject: forgotPasswordRequest)
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
