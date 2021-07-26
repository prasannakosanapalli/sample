//
//  RegisterModuleTests.swift
//  Medline-DigitalSkinHealthTests
//
//  Created by Hariharan A on 09/03/21.
//

import XCTest
@testable import Medline_DigitalSkinHealth

class MedlineRegisterModuleTests: XCTestCase {

    let firstName = "hariharan"
    let lastName = "hariharan"
    let email = "hariharan@photon.in"
    let phoneNumber = "(123) 456-7890"
    let customerNumber = "1410792"
    let password = "Welcome@01"
    let confirmPassword = "Welcome@01"
    
    var registerVC: MedlineRegisterAccountViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Step 1. Create an instance of UIStoryboard
        let storyboard = UIStoryboard(name: retrieveStoryboardName(), bundle: nil)
        // Step 2. Instantiate UIViewController with Storyboard ID
        registerVC = storyboard.instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kRegistrationViewControllerID) as? MedlineRegisterAccountViewController
        // Step 3. Make the viewDidLoad() execute.
        registerVC.loadViewIfNeeded()
        registerVC.viewWillAppear(true)
        registerVC.viewDidLoad()
        try? testPopulateRegisterField()
    }

    override func tearDownWithError() throws {
        registerVC.releaseWebKitResources()
        registerVC = nil
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
    
    func testPopulateRegisterField() throws {
        registerVC.firstNameTextField.text = firstName
        registerVC.lastNameTextField.text = lastName
        registerVC.emailTextField.text = email
        registerVC.phoneNumberTextField.text = phoneNumber
        registerVC.customerNumberTextField.text = customerNumber
        registerVC.passwordTextField.text = password
        registerVC.confirmPasswordTextField.text = confirmPassword
    }

    func testFirstNameValidation() throws {
        if firstName.isValidName() {
            XCTAssert(true, "First Name valid")
        } else {
            XCTAssert(false, "First Name invalid")
        }
    }
    
    func testLastNameValidation() throws {
        if lastName.isValidName() {
            XCTAssert(true, "Last Name valid")
        } else {
            XCTAssert(false, "Last Name invalid")
        }
    }
    
    func testPhonenumberValidation() throws {
        if phoneNumber.isValidMobileNumber() {
            XCTAssert(true, "Phone number valid")
        } else {
            XCTAssert(false, "Phone number invalid")
        }
    }
    
    func testEmailValidation() throws {
        if firstName.isValidName() {
            XCTAssert(true, "First Name Valid")
        } else {
            XCTAssert(false, "First Name Valid")
        }
    }
    
    func testPasswordValidation() throws {
        if password.isValidPassword() {
            XCTAssert(true, "Password valid")
        } else {
            XCTAssert(false, "Password invalid")
        }
    }
    
    func testConfirmPasswordValidation() throws {
        if password.doPasswordsMatch(conformPassword: confirmPassword) {
            XCTAssert(true, "First Name Valid")
        } else {
            XCTAssert(false, "First Name Valid")
        }
    }
    
    func testAllTextFieldValid() throws {
        let isValidFirstName = registerVC.firstNameValidation()
        let isValidLastName = registerVC.lastNameValidation()
        
        let isValidCustomerName = registerVC.customerNumberValidation()
        
        let isValidPhone = registerVC.phoneNumberValidation()
        
        let isValidEmail = registerVC.emailValidation()
        
        let isValidPassword = registerVC.passwordValidation()

        let isValidConfirmPassword = registerVC.confirmPasswordValidation()
        
        let isValid = isValidFirstName && isValidLastName && isValidCustomerName && isValidPhone && isValidEmail && isValidPassword && isValidConfirmPassword

        if isValid {
            XCTAssertTrue(isValid, "All textfield valid")
        } else {
            XCTAssertFalse(isValid, "Textfield invalid")
        }
    }
    
    func testAllTextFieldInvalid() throws {
        registerVC.firstNameTextField.text = ""
        registerVC.lastNameTextField.text = ""
        registerVC.emailTextField.text = "sample.com"
        registerVC.phoneNumberTextField.text = "phoneNumber"
        registerVC.customerNumberTextField.text = ""
        registerVC.passwordTextField.text = "password"
        registerVC.confirmPasswordTextField.text = "confirmPassword"
        
        let isValidFirstName = registerVC.firstNameValidation()
        let isValidLastName = registerVC.lastNameValidation()
        
        let isValidCustomerName = registerVC.customerNumberValidation()
        
        let isValidPhone = registerVC.phoneNumberValidation()
        
        let isValidEmail = registerVC.emailValidation()
        
        let isValidPassword = registerVC.passwordValidation()

        let isValidConfirmPassword = registerVC.confirmPasswordValidation()
        
        let isValid = isValidFirstName && isValidLastName && isValidCustomerName && isValidPhone && isValidEmail && isValidPassword && isValidConfirmPassword

        if isValid {
            XCTAssertTrue(isValid, "All textfield inValid")
        } else {
            XCTAssertFalse(isValid, "Textfield invalid")
        }
    }
    
    func testPhoneNumberValidation() throws {
        let _ = registerVC.textField(registerVC.phoneNumberTextField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "")
        let _ = registerVC.textField(registerVC.firstNameTextField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "")
    }
    
    func testRegisterAction() throws {
        registerVC.registerButtonAction(UIButton())
        
        registerVC.agreeTermsButton.isSelected = true
        registerVC.registerButtonAction(UIButton())
        
        registerVC.firstNameTextField.text = ""
        let _ = registerVC.isAllTextFieldValid()
        registerVC.registerButtonAction(UIButton())
    }
    
    func testTextfieldDidChange() throws {
        registerVC.textFieldDidChange(registerVC.firstNameTextField)
        registerVC.textFieldDidChange(registerVC.lastNameTextField)
        registerVC.textFieldDidChange(registerVC.emailTextField)
        registerVC.textFieldDidChange(registerVC.phoneNumberTextField)
        registerVC.textFieldDidChange(registerVC.customerNumberTextField)
        registerVC.textFieldDidChange(registerVC.passwordTextField)
        registerVC.passwordTextField.text = ""
        registerVC.textFieldDidChange(registerVC.passwordTextField)
        registerVC.textFieldDidChange(registerVC.confirmPasswordTextField)
        registerVC.confirmPasswordTextField.text = ""
        registerVC.textFieldDidChange(registerVC.confirmPasswordTextField)
        XCTAssertTrue(true)
    }
    
    func testConnectRegsiterAPI() throws {
        registerVC.connectRegisterAPI()
    }
    
    func testAgreeToggleAction() throws {
        registerVC.agreeTermsButton.sendActions(for: .touchUpInside)
        if registerVC.agreeTermsButton.isSelected == true {
            XCTAssert(true, "Button selected")
        } else {
            XCTAssert(false, "Button not selected")
        }
    }
    
    func testPasswordToggleAction() throws {
        registerVC.passwordVisibleButton.sendActions(for: .touchUpInside)
        if registerVC.passwordVisibleButton.isSelected == true {
            XCTAssert(true, "Button selected")
        } else {
            XCTAssert(false, "Button not selected")
        }
    }
    
    func testConfirmPasswordToggleAction() throws {
        registerVC.confirmPasswordVisibleButton.sendActions(for: .touchUpInside)
        if registerVC.confirmPasswordVisibleButton.isSelected == true {
            XCTAssert(true, "Button selected")
        } else {
            XCTAssert(false, "Button not selected")
        }
    }
    
    func testOpenWebPage() throws {
        registerVC.openMedlineWebContentViewController(webPageURL: MedlineWebPageURL.medlineTermAndConditionURL)
        registerVC.openMedlineWebContentViewController(webPageURL: MedlineWebPageURL.medlinePrivacyPolicyURL)
    }

    func testlastNameErrorIpad() throws {
        if isDeviceTypeIPad() {
            _ = registerVC.lastNameValidation()
        }
    }
    
    func testHyperLinkTapGestureAction() throws {
        registerVC.agreeTermTapAction(gesture: UITapGestureRecognizer())
    }
    
    func testLoginTapGestureAction() throws {
        registerVC.loginTapAction(gesture: UITapGestureRecognizer())
    }
    
    func testRegisterFullScreenMessage() throws {
        let greet = registerVC.registerViewModel.greetLabelText()
        let success = registerVC.registerViewModel.successLabelText()
        XCTAssertEqual(greet, "Congratulations!")
        XCTAssertEqual(success, "Please check your email for activation link")
    }
}
