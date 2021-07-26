//
//  MedlineForgotPasswordTests.swift
//  Medline-DigitalSkinHealthTests
//
//  Created by Indela Venkata Mahesh Reddy on 10/03/21.
//

import XCTest
@testable import Medline_DigitalSkinHealth

class MedlineForgotPasswordTests: XCTestCase {

    let email:String? = "indelavenkata.m@photon.in"
    let falseEmail:String? = "indelavenkata@photon"
    var forgotPasswordVC: MedlineForgotPasswordViewController!
    var forgotPasswordVM: MedlineForgotPasswordViewModel!
    fileprivate let apiForgotPasswordSuccessResponse = "{\"status\":\"success\",\"data\":null,\"message\":null}"
    fileprivate let apiForgotPasswordErrorResponse = "{\"status\":\"error\",\"data\":null,\"message\":\"\"}"
    fileprivate let successInSuccessTag = "You got success in status tag"
    fileprivate let errorInErrorTag = "You got error in status tag"
    fileprivate let errorInReadingData = "Error in reading data"
    
    override func setUpWithError() throws {
        forgotPasswordVM = MedlineForgotPasswordViewModel()
        let storyboard = UIStoryboard(name: retrieveStoryboardName(), bundle: nil)
        forgotPasswordVC = storyboard.instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kForgotPasswordViewControllerID) as? MedlineForgotPasswordViewController
        forgotPasswordVC.loadViewIfNeeded()
        forgotPasswordVC.viewWillAppear(true)
        forgotPasswordVC.viewDidLoad()
        try? testPopulateForgotPasswordField()
    }

    func testPopulateForgotPasswordField() throws {
        forgotPasswordVC.forgotPasswordEmailTextField.text = email
    }
    
    func testForgotPasswordInputValidation() throws {
        if ((email?.isValidEmail()) != nil) {
            XCTAssertTrue(true, localizedString("EMAIL_IS_VALID"))
        } else {
            XCTAssertFalse(false, localizedString("EMAIL_TEXTFIELD_VALIDATION"))
        }
        
    }
    
    func testTextFieldEditing() throws {
        if email != nil {
            forgotPasswordVC.forgotPasswordEmailTextField.text = email
            forgotPasswordVC.textFieldEditing(forgotPasswordVC.forgotPasswordEmailTextField)
        } else {
            XCTAssertFalse(false, localizedString("EMAIL_TEXTFIELD_VALIDATION"))
        }
    }
    
    func testTextFieldEditingWithInvalidEmail() throws {
        forgotPasswordVC.forgotPasswordEmailTextField.text = ""
        forgotPasswordVC.textFieldEditing(forgotPasswordVC.forgotPasswordEmailTextField)
    }
    
    func testEmailTextFieldValidation() throws {
        XCTAssertTrue(forgotPasswordVC.isEmailTextFieldValid())
    }
    
    func testEmailTextFieldFalseValidation() throws {
        if ((email?.isValidEmail()) != nil) {
            XCTAssertTrue(true, localizedString("EMAIL_IS_VALID"))
        } else {
            forgotPasswordVC.forgotPasswordEmailTextField.text = ""
            _ = forgotPasswordVC.isEmailTextFieldValid()
        }
        
    }
    
    func testForgotPasswordAction() throws {
        forgotPasswordVC.forgotPasswordSubmitAction(UIButton())
        forgotPasswordVC.forgotPasswordEmailTextField.text = ""
        let _ = forgotPasswordVC.isEmailTextFieldValid()
        forgotPasswordVC.forgotPasswordSubmitAction(UIButton())
    }
    
    func testConnectForgotPasswordAPI() throws {
        forgotPasswordVC.forgotPasswordEmailTextField.text = email
        forgotPasswordVC.connectForgotPassowrdAPI()
    }
    
    func testAccessibilityTextUpdateValidation() throws {
        forgotPasswordVC.accessibilityTextUpdate()
    }
    
    func testShowErrorTextValidation() throws {
        //forgotPasswordVC.showErrorText()
    }
    
    func testHideErrorTextValidation() throws {
       // forgotPasswordVC.hideErrorText()
    }
    
    func testEmailErrorTextValidation() throws {
        _ = forgotPasswordVM.emailErrorText(isValid: false, emailText: email!)
    }
    
    func testGreetLabelTextValidation() throws {
        _ = forgotPasswordVM.greetLabelText()
    }
    
    func testSuccessLabelTextValidation() throws {
        _ = forgotPasswordVM.successLabelText()
    }
    
    func testCallForgotPasswordAPI() throws {
        _ = forgotPasswordVM.callForgotPasswordAPI(email: email ?? "indelavenkata.m@photon.in")
    }
    
    func testSuccessNavigationValidation() throws {
        forgotPasswordVC.successNavigation(message: MedlineServiceConstant.kSuccess)
    }
    
    func testSuccessNavigationFalseValidation() throws {
        forgotPasswordVC.successNavigation(message: MedlineAppConstant.kError)
    }
    
    func testForgotPasswordSuccessResponse() {
        let data = Data(apiForgotPasswordSuccessResponse.utf8)
        let decoder = JSONDecoder()

        if let jsonData = try? decoder.decode(MedlineForgotPasswordResponse.self, from: data) {

            if jsonData.status == MedlineServiceConstant.kSuccess {
                XCTAssertTrue(true, successInSuccessTag)
            }
        } else {
            XCTFail(errorInReadingData)
        }
    }

    func testForgotPasswordErrorResponse() {
        let data = Data(apiForgotPasswordErrorResponse.utf8)
        let decoder = JSONDecoder()

        if let jsonData = try? decoder.decode(MedlineForgotPasswordResponse.self, from: data) {

            if jsonData.status == MedlineAppConstant.kError.lowercased() {
                XCTAssertTrue(true, errorInErrorTag)
            }
        } else {
            XCTFail(errorInReadingData)
        }
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        forgotPasswordVM = nil
        forgotPasswordVC = nil
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

}
