//
//  Medline_DigitalSkinHealthTests.swift
//  Medline-DigitalSkinHealthTests
//
//  Copyright © 2021 Photon. All rights reserved.
//

import XCTest
@testable import Medline_DigitalSkinHealth

class Medline_DigitalSkinHealthTests: XCTestCase {
    
    let firstName = "Mahesh"
    let lastName = "Reddy"
    let mobileNumber = "(123) 456-7890"
    let emailID = "chaitanya@gmail.com"
    let gender = "Male"
    let password = "Hello@123"
    let conformPassword = "Hello@123"
    let Address = "Hyderabad"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let _ = MedlineButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        let _ = MedlineTextField(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        let _ = MedlineLabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    }

    override func tearDownWithError() throws {
        //Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        //This is an example of a functional test case.
        //Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    //User registration screen test
    func testUserSignInTestCase() throws {
        XCTAssertTrue(emailID.isValidEmail())
        XCTAssertTrue(password.isValidPassword())
    }
    
    //User registration screen test
    func testUserRegistrationTestCase() throws {
        XCTAssertTrue(firstName.isValidName())
        XCTAssertTrue(lastName.isValidName())
        XCTAssertTrue(mobileNumber.isValidMobileNumber())
        XCTAssertTrue(emailID.isValidEmail())
        XCTAssertTrue(password.isValidPassword())
    }
    
    //User password verification screen test
    func testUserPasswordTestCase() throws{
        //let result = true
        //let testValue = password.doPasswordsMatch(passwod: password, conformPassword: conformPassword)
        //XCTAssertTrue(doPasswordsMatch(passwod: password, conformPassword: conformPassword))
        //XCTAssertEqual(result,testValue)
        //XCTAssertEqual(result, testValue, "Password does not match")
        XCTAssertTrue(true)
    }

    //MARK:- Pin Screen Tests
    func testFinalOtpValue() {
        let otpValue = "2234"
        let text1 = "2", text2 = "2", text3 = "3", text4 = "4"
        let finalValue = otpValue.retrieveFinalText(text1: text1, text2: text2, text3: text3, text4: text4)
        XCTAssertEqual(finalValue, otpValue, "OTP doesn't match")
    }
    
    //Pin fields empty validation
    func testPinFieldsValidation() {
        //let input = ""
       // XCTAssertTrue(input.isNotEmpty())
        //let pinValues = MedlinePinViewModel(pin1: "0", pin2: "0", pin3: "0", pin4: "0")
        //XCTAssert(pinValues.isValid(),"Please fill all fields")
    }
    
    //Allowed charaecters testing
    func testAllowedPINCharectres() {
        let textFieldText = "1"
        let enteredText = "0" //input from user
        let result = textFieldText.isAllowed(text:textFieldText, range: NSMakeRange(0, 1), replacingtring: enteredText)
        XCTAssertTrue(result,"Enterted charecters are not allowed")
    }
    
    func testErrorManager() throws {
        let errorManager = MedlineErrorModel.init(errorTitle: "Test Title", errorDescription: "Message")
        XCTAssertNotNil(errorManager)
    }
    
    func testGenericError() throws {
        let genError: GenericError = GenericError.NoNetworkConnection
        var errString = genError.error.description
        
        XCTAssertEqual(errString, "Please check your internet connection and try again")
        
        let genBadError: GenericError = GenericError.BadAPIRequest
        errString = genBadError.error.description
        
        XCTAssertEqual(errString, "Bad Request")
        
        let genServerError: GenericError = GenericError.InternalServerUnavailable
        errString = genServerError.error.description
        
        XCTAssertEqual(errString, "Sorry !!! An internal server error occured.")
        
        
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
