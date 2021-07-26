//
//  MedlineResetPasswordTests.swift
//  Medline-DigitalSkinHealthTests
//
//  Created by Sunil Kumar Jaiswal on 09/03/21.
//

import XCTest
@testable import Medline_DigitalSkinHealth

class MedlineResetPasswordTests: XCTestCase {
    
    fileprivate let email = "sunilkumarjaisw@photon.in"
    fileprivate let newPassword:String? = "Testing@123"
    fileprivate let confirmPassword:String? = "Testing@123"
    fileprivate let token = "nzzb7uSTE0AUn7UhJmmR3POW+a9BUaEat9DATcLRHhc="
    
    fileprivate let apiResetPasswordSuccessResponse = "{\"status\":\"success\",\"data\":null,\"message\":null}"
    fileprivate let apiResetPasswordErrorResponse = "{\"status\":\"error\",\"data\":null,\"message\":\"\"}"
    fileprivate let haveValidNewPassword = "New Password is valid"
    fileprivate let haveValidConfirmPassword = "Confirm password is valid"
    fileprivate let newPasswordEqualToConfirmPassword = "New password and confirm password equal"
    
    fileprivate let newPasswordTextIsMasked = "New Password text is masked"
    fileprivate let newPasswordTextIsUnmasked = "New Password text is unmasked"
    fileprivate let confirmPasswordTextIsMasked = "Confirm Password text is masked"
    fileprivate let confirmPasswordTextIsUnmasked = "Confirm Password text is unmasked"
    fileprivate let provideAllTheRequestParameter = "Please provide all request parameter"
    fileprivate let appInputIsValid = "All input is valid"
    fileprivate let appInputNotValid = "All input is not valid"
    
    fileprivate let successInSuccessTag = "You got success in status tag"
    fileprivate let errorInErrorTag = "You got error in status tag"
    fileprivate let errorInReadingData = "Error in reading data"
    
    
    fileprivate var resetPasswordVM: MedlineResetPasswordViewModel?
    fileprivate var resetPasswordVC: MedlineResetPasswordViewController?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        resetPasswordVM = MedlineResetPasswordViewModel()
        
        let storyboard = UIStoryboard(name: retrieveStoryboardName(), bundle: nil)
        // Step 2. Instantiate UIViewController with Storyboard ID
        resetPasswordVC = storyboard.instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kResetPasswordViewControllerID) as? MedlineResetPasswordViewController
        // Step 3. Make the viewDidLoad() execute.
        resetPasswordVC?.loadViewIfNeeded()
        resetPasswordVC?.viewWillAppear(true)
        resetPasswordVC?.viewDidLoad()
        try? testResetPasswordFields()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        resetPasswordVM = nil
        resetPasswordVC = nil
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testResetPasswordFields() throws {
        if (retrieveProperString(retrieveString: newPassword) == "") {
            XCTAssertFalse(false, localizedString("PASSWORD_RESET_NEW_PASSWORD_TEXTFIELD_VALIDATION"))
            
        } else if (retrieveProperString(retrieveString: confirmPassword) == "") {
            XCTAssertFalse(false, localizedString("PASSWORD_RESET_CONFIRM_PASSWORD_TEXTFIELD_VALIDATION"))
            
        } else {
            resetPasswordVC?.newPasswordTextField.text = newPassword
            resetPasswordVC?.confirmPasswordTextField.text = confirmPassword
        }
    }
    
    func testResetPasswordInputValidation() throws {
        if (retrieveProperString(retrieveString: newPassword) == "") {
            XCTAssertFalse(false, localizedString("PASSWORD_RESET_NEW_PASSWORD_TEXTFIELD_VALIDATION"))
            
        } else if (retrieveProperString(retrieveString: confirmPassword) == "") {
            XCTAssertFalse(false, localizedString("PASSWORD_RESET_CONFIRM_PASSWORD_TEXTFIELD_VALIDATION"))
            
        } else {
            resetPasswordVC?.newPasswordTextField.text = newPassword
            resetPasswordVC?.confirmPasswordTextField.text = confirmPassword
            
            let newPasswordTextFieldText = retrieveProperString(retrieveString: resetPasswordVC?.newPasswordTextField.text)
            
            if (newPasswordTextFieldText == "") {
                XCTAssertFalse(false, localizedString("REGISTER_ACCOUNT_PASSWORD_VALIDATION"))
                
            } else {
                let isNewPasswordValid = resetPasswordVM?.passwordValidation(password: newPasswordTextFieldText)
                
                if (isNewPasswordValid == true) {
                    XCTAssertTrue(true, haveValidNewPassword)
                    
                } else {
                    let failPasswordMessage:String = (resetPasswordVM?.newPasswordErrorText(isValid: false, isNotEmpty: email.isNotEmpty()))!
                    XCTAssertFalse(false, failPasswordMessage)
                }
            }
            
            let confirmPasswordTextFieldText = retrieveProperString(retrieveString: resetPasswordVC?.confirmPasswordTextField.text)
            
            if (confirmPasswordTextFieldText == "") {
                let confirmPasswordMessage:String = (resetPasswordVM?.confirmPasswordErrorText(isValid: false, isEmpty: true))!
                XCTAssertFalse(false, confirmPasswordMessage)
                
            } else {
                let isConfirmPasswordValid = resetPasswordVM?.passwordValidation(password: confirmPassword)
                
                if (isConfirmPasswordValid == true) {
                    let successPasswordMessage:String = (resetPasswordVM?.confirmPasswordErrorText(isValid: true, isEmpty: false))!
                    XCTAssertTrue(true, successPasswordMessage)
                    
                } else {
                    let failPasswordMessaget:String = (resetPasswordVM?.confirmPasswordErrorText(isValid: false, isEmpty: false))!
                    XCTAssertFalse(false, failPasswordMessaget)
                }
            }
            
            if ((newPasswordTextFieldText != "") && (confirmPasswordTextFieldText != "")) {
                checkNewPasswordEqualToConfirmPassword(newPassword: retrieveProperString(retrieveString: newPasswordTextFieldText), confirmPassword: retrieveProperString(retrieveString: confirmPasswordTextFieldText))
            }
            
            if (resetPasswordVC?.isAllTextFieldValid() == true) {
                XCTAssertTrue(true, appInputIsValid)
            } else {
                XCTAssertFalse(false, appInputNotValid)
            }
        }
    }
    
    func checkNewPasswordEqualToConfirmPassword(newPassword: String, confirmPassword: String) {
        let isNewPasswordValid = resetPasswordVM?.passwordValidation(password: newPassword)
        let isConfirmPasswordValid = resetPasswordVM?.passwordValidation(password: confirmPassword)
        
        if ((isNewPasswordValid == true) && (isConfirmPasswordValid == true)) {
            let isNewPassEquConfirm = resetPasswordVM?.newPasswordAndConfirmPasswordValidation(newPassword: newPassword, confirmPassword: confirmPassword)
            
            if (isNewPassEquConfirm == true) {
                XCTAssertTrue(true, newPasswordEqualToConfirmPassword)
            } else {
                XCTAssertFalse(false, localizedString("NEW_PASSWORD_NOTEQUAL_TO_CONFIRM_PASSWORD"))
            }
        } else {
            if (isNewPasswordValid == true) {
                XCTAssertTrue(true, haveValidNewPassword)
            } else {
                XCTAssertFalse(false, localizedString("PASSWORD_RESET_NEW_PASSWORD_TEXTFIELD_VALIDATION"))
            }
            
            if (isConfirmPasswordValid == true) {
                XCTAssertTrue(true, haveValidConfirmPassword)
            } else {
                XCTAssertFalse(false, localizedString("PASSWORD_RESET_CONFIRM_PASSWORD_TEXTFIELD_VALIDATION"))
            }
        }
    }
    
    func testNewPasswordAndConfirmPasswordToggleAction() throws {
        resetPasswordVC?.newPasswordToggleAction(UITapGestureRecognizer())
        if (resetPasswordVC?.newPasswordVisibleStatus == false) {
            XCTAssert(true, newPasswordTextIsMasked)
        } else {
            resetPasswordVC?.newPasswordVisibleStatus = true
            XCTAssert(true, newPasswordTextIsUnmasked)
        }
        
        resetPasswordVC?.confirmPasswordToggleAction(UITapGestureRecognizer())
        if (resetPasswordVC?.confirmPasswordVisibleStatus == false) {
            XCTAssert(true, confirmPasswordTextIsMasked)
        } else {
            resetPasswordVC?.confirmPasswordVisibleStatus = true
            XCTAssert(true, confirmPasswordTextIsUnmasked)
        }
    }
    
    func testMedlineResetPasswordAction() throws {
        if ((retrieveProperString(retrieveString: email) == "") || (retrieveProperString(retrieveString: confirmPassword) == "") || (retrieveProperString(retrieveString: MedlineKeychainData.retrieveUserLoginToken()) == "")) {
            
            XCTAssert(false, provideAllTheRequestParameter)
            
        } else {
            resetPasswordVC?.loginUserEmailID = email
            resetPasswordVC?.confirmPasswordTextField.text = confirmPassword
            resetPasswordVC?.loginToken = MedlineKeychainData.retrieveUserLoginToken()
            resetPasswordVC?.medlineResetPasswordAction(UIButton())
        }
    }
    
    func testTextfieldDidChange() throws {
        resetPasswordVC?.newPasswordTextField.text = ""
        resetPasswordVC?.textFieldDidChange(resetPasswordVC?.newPasswordTextField ?? MedlineTextField())
        
        resetPasswordVC?.confirmPasswordTextField.text = ""
        resetPasswordVC?.textFieldDidChange(resetPasswordVC?.confirmPasswordTextField ?? MedlineTextField())
        XCTAssertTrue(true)
    }
    
    func testSetUILabelAndButtonTitle() throws {
        resetPasswordVC?.isCallFromLoginViewController = true
        resetPasswordVC?.setUILabelAndButtonTitle()
    }
    
    func testNewPasswordErrorText() throws {
        _ = resetPasswordVM?.newPasswordErrorText(isValid: false, isNotEmpty: email.isNotEmpty())
    }
    
    func testGreetLabelText() throws {
        _ = resetPasswordVM?.greetLabelText()
    }
    
    func testSuccessLabelText() throws {
        _ = resetPasswordVM?.successLabelText()
    }
    
    func testCallResetPasswordAPI() throws {
        _ = resetPasswordVM?.callResetPasswordAPI(email: email, password: confirmPassword ?? "", token: MedlineKeychainData.retrieveUserLoginToken())
    }
    
    func testConnectResetPasswordAPI() throws {
        resetPasswordVC?.loginUserEmailID = email
        resetPasswordVC?.confirmPasswordTextField.text = confirmPassword
        resetPasswordVC?.connectResetPasswordAPI()
    }
    
    func testNavigateToFullScreenMessageVC() throws {
        resetPasswordVC?.navigateToFullScreenMessageVC(message: MedlineServiceConstant.kSuccess)
    }
    
    func testFailToNavigateToFullScreenMessageVC() throws {
        resetPasswordVC?.navigateToFullScreenMessageVC(message: MedlineAppConstant.kError.lowercased())
    }
    
    func testResetPasswordSuccessResponse() {
        let data = Data(apiResetPasswordSuccessResponse.utf8)
        let decoder = JSONDecoder()
        if let jsonData = try? decoder.decode(MedlineResetPasswordResponse.self, from: data) {
            if jsonData.status == MedlineServiceConstant.kSuccess {
                XCTAssertTrue(true, successInSuccessTag)
            }
        } else {
            XCTFail(errorInReadingData)
        }
    }
    
    func testResetPasswordErrorResponse() {
        let data = Data(apiResetPasswordErrorResponse.utf8)
        let decoder = JSONDecoder()
        if let jsonData = try? decoder.decode(MedlineResetPasswordResponse.self, from: data) {
            if jsonData.status == MedlineAppConstant.kError.lowercased() {
                XCTAssertTrue(true, errorInErrorTag)
            }
        } else {
            XCTFail(errorInReadingData)
        }
    }
}
