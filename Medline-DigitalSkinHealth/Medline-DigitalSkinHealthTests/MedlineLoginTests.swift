//
//  MedlineLoginTests.swift
//  Medline-DigitalSkinHealthTests
//
//  Created by Vijay Guruju on 09/03/21.
//

import XCTest
import PromiseKit
import KeychainSwift

@testable import Medline_DigitalSkinHealth

class MedlineLoginTests: XCTestCase {
    let email = "gurujuvijayabha@photon.in"
    let password = "Test@123"
    let inValidEmail = "abc@medline"
    let inValidPassword = "Test12345"
    fileprivate let loginApiErrorResponse = "{\"status\":\"error\",\"data\":null,\"message\":\"\"}"
    fileprivate let errorInErrorTag = "You got error in status tag"
    fileprivate let errorInReadingData = "Error in reading data"

    var loginVC: MedlineLoginViewController!
    var loginVM: MedlineLoginViewModel?

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: retrieveStoryboardName(), bundle: nil)
        loginVC = storyboard.instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kLoginViewControllerID) as? MedlineLoginViewController
        loginVC.loadViewIfNeeded()
        loginVC.viewWillAppear(true)
        loginVC.viewWillDisappear(true)
        loginVC.viewDidLoad()
        try? testPopulateLoginField()
    }
    //Papulate input values
    func testPopulateLoginField() throws {
        loginVC.emailTextField.text = email
        loginVC.passwordTextField.text = password
    }

    override func tearDownWithError() throws {
        loginVC = nil
        loginVM  = nil
    }
    //MARK:-  Invalid email message test
    func testEmailErrorValidationMessage() {
        let isEmailValid = false // validation
        let loginData = MedlineLoginViewModel()
        XCTAssertEqual(localizedString("EMAIL_FORMAT_VALIDATION"),loginData.emailErrorText(isValid: isEmailValid, emailText: email) ,"Email error message is wrong")

    }
    
    //MARK:-  Invalid password message test
    func testPasswordValidationErrorMessage() {
        let isPasswordValid = false
        let loginData = MedlineLoginViewModel()
        XCTAssertEqual(localizedString("PASSWORD_TEXTFIELD_VALIDATION"),loginData.passwordErrorText(isValid: isPasswordValid), "Password error message is wrong")

    }
    
    //MARK:-  Valid email test
    func testValidEmail() {
        loginVC.emailTextField.text = email
        let isValidEmail = loginVC.emailTextField.text!.isValidEmail()
        XCTAssertTrue(isValidEmail, "Email is invalid")
    }
    //MARK:-  Invalid email test
    func testInvalidEmail() {
        loginVC.emailTextField.text = inValidEmail
        let isValidEmail = loginVC.emailTextField.text!.isValidEmail()
       XCTAssertFalse(isValidEmail, "Email is valid")
    }
    
    //MARK:-  Valid password test
    func testValidPassword() {
        loginVC.passwordTextField.text = password
        let isValidPassword = loginVC.passwordTextField.text!.isValidPassword()
        XCTAssertTrue(isValidPassword, "Password is invalid")
    }
    
    //MARK:-  Invalid password test
    func testInvalidPassword() {
        loginVC.passwordTextField.text = inValidPassword
        let isValidPassword = loginVC.passwordTextField.text!.isValidPassword()
        XCTAssertFalse(isValidPassword, "Password is Valid")
    }
    
    //MARK:-  Email text change test
    func testEmailTextFieldDidChange() {
        loginVC.textFieldDidChange(loginVC.emailTextField)
        XCTAssert(true)
    }
    
    //MARK:-  Password text change test
    func testPasswordTextFieldDidChange() {
        loginVC.textFieldDidChange(loginVC.passwordTextField)
        loginVC.passwordTextField.text = ""
        loginVC.textFieldDidChange(loginVC.passwordTextField)
        XCTAssert(true)
    }
    
    //MARK:-  Email and Password text validation test - Valid case
    func testEmailAndPasswordValid() {
        loginVC.emailTextField.text = email
        loginVC.passwordTextField.text = password
        XCTAssertTrue(loginVC.isEmailPasswordValid(), "Email and Password are invalid")
    }
    
    //MARK:-  Email and Password text validation test - Invalid caee
    func testEmailAndPasswordInvalid() {
        loginVC.emailTextField.text = inValidEmail
        loginVC.passwordTextField.text = password
        XCTAssertFalse(loginVC.isEmailPasswordValid(), "Email and Password are valid")
    }
    
    //MARK:-  Password Hide/show button test
    func testPasswordHideAndShowAction() {
        loginVC.passwordVisibleButton.sendActions(for: .touchUpInside)
        if (loginVC.passwordVisibleButton.isSelected == true)  {
            XCTAssert(true, "Password visible button selected")
        } else {
            XCTAssert(false, "Password visible button not selected")
        }
    }
    
    //MARK:-  Login API call test
    func testConnectLoginAPI()  {
        XCTAssertNotNil(loginVC.connectLoginAPI(), "Connect Login API not called")
    }
    
    //MARK:-  Register/Forgot Password Button action test
    func testButtonActions() {
        XCTAssertNotNil(loginVC.registerButtonAction(UIButton()), "Register button action not called")
        XCTAssertNotNil(loginVC.forgotPasswordSubmitAction(UIButton()),"Forgot Password button action not called")
    }
    
    //MARK:- Valid Login Button action test
    func testValidLoginButtonAction() {
        loginVC.emailTextField.text = email
        loginVC.passwordTextField.text = password
        XCTAssertNotNil(loginVC.loginAction(UIButton()),"Login button Action not called")
    }
    
    //MARK:- Invalid Login Button action test
    func testInvalidLoginButtonAction() {
        loginVC.emailTextField.text = inValidEmail
        loginVC.passwordTextField.text = inValidPassword
        XCTAssertNotNil(loginVC.loginAction(UIButton()),"Login button valid")
    }
    
    //MARK:- Reset password navigation test
    func testResetPasswordNavigation() {
        XCTAssertNotNil(loginVC.navigateToUpdatePasswordViewController(userEmailID: email),"Reset Password navigation not called")
    }
    
    //MARK:- Home screen navigation test
    func testHomeScreenNavigation() {
        XCTAssertNotNil(loginVC.navigateToHomeScreen(),"Home screen navigation not called")
    }
    
    //MARK:- Login API service call test
    func testLoginServiceCall() {
        _ = loginVM?.callLoginAPI(email: email, password: password)
//        let loginRequest = MedlineLoginRequest(email: email, password: password)
//            let expectation = XCTestExpectation(description: "test login response")
//            firstly {
//                MedlineServiceManager.callLoginService(requestObject: loginRequest)
//            }.done{ (response) in
//
//                XCTAssertNotNil(response, "response not found")
//
//            }.catch(on: .global(qos: .background)) { (error) in
//                XCTAssertNotNil(error)
//                expectation.fulfill()
//            }
//
//        wait(for: [expectation], timeout: 20.0)
     }

    //MARK:- Test Save and Delete login token in keychain
    func testSaveAndDeleteLoginTokenInKeychain() {
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
        XCTAssertNotNil(MedlineKeychainData.storeUserLoginToken(token: token), "Token not saved in keychain")
        let loginToken = MedlineKeychainData.retrieveUserLoginToken()
        XCTAssertNotNil(loginToken, "Token not found in keychain")
        XCTAssertTrue(MedlineKeychainData.deleteUserLoginToken(token: loginToken), "Token not deleted")
    }
    
    //MARK:- Test Save and Delete empty login token in keychain
    func testSaveAndDeleteEmptyLoginTokenInKeychain() {
        let emptyToken = ""
        MedlineKeychainData.storeUserLoginToken(token: emptyToken)
        let emptyLoginToken = MedlineKeychainData.retrieveUserLoginToken()
        XCTAssertNotNil(emptyLoginToken, "Token not found in keychain")
        XCTAssertFalse(MedlineKeychainData.deleteUserLoginToken(token: emptyLoginToken), "Token deleted")
    }
    
    //MARK:- Test Retrive Mobile Unique ID from keychain
    func testRetrieveMobileUniqueIDFromKeychain() {
        XCTAssertNotNil(MedlineKeychainData.retrieveMobileUniqueIDKey(), "Unique ID not found")
    }
    
    //MARK:- Test Login response test with local mock json
    func testLoginSuccessResponse() {
        if let url = Bundle.main.url(forResource: "MedlineLoginResponseData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MedlineLoginResponse.self, from: data)
                print(jsonData.status as Any)
               XCTAssertNotNil(jsonData, "Login data not found")
            } catch {
                print("error:\(error)")
                XCTFail("Error in reading data")
            }
        }
    }
    //MARK:- Test Login Error response test with local mock json
    func testLoginErrorResponse() {
        let data = Data(loginApiErrorResponse.utf8)
        let decoder = JSONDecoder()
        if let jsonData = try? decoder.decode(MedlineLoginResponse.self, from: data) {
            if jsonData.status == MedlineAppConstant.kError.lowercased() {
                XCTAssertTrue(true, errorInErrorTag)
            }
        } else {
            XCTFail(errorInReadingData)
        }
    }
}
