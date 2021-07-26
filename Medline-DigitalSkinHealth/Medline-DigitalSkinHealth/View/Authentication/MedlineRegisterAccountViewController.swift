//
//  MedlineRegisterAccountViewController.swift
//  XCTestSample
//
//  Created by Sunil Kumar Jaiswal on 15/02/21.
//

import UIKit
import WebKit
import PromiseKit

class MedlineRegisterAccountViewController: MedlineBaseViewController {
    
    @IBOutlet weak var alreadyAccountLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: MedlineTextField!
    @IBOutlet weak var lastNameTextField: MedlineTextField!
    @IBOutlet weak var nameErrorView: MedlineErrorText!
    @IBOutlet weak var nameErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var lastNameErrorView: MedlineErrorText!
    @IBOutlet weak var lastNameErrorHeight: NSLayoutConstraint!
    
    @IBOutlet weak var customerNumberTextField: MedlineTextField!
    @IBOutlet weak var customerNumberErrorView: MedlineErrorText!
    @IBOutlet weak var customerNumberErrorHeight: NSLayoutConstraint!
    
    @IBOutlet weak var phoneNumberTextField: MedlineTextField!
    @IBOutlet weak var phoneNumberErrorView: MedlineErrorText!
    @IBOutlet weak var phoneNumberErrorHeight: NSLayoutConstraint!
    
    @IBOutlet weak var emailTextField: MedlineTextField!
    @IBOutlet weak var emailErrorView: MedlineErrorText!
    @IBOutlet weak var emailErrorHeight: NSLayoutConstraint!
    
    @IBOutlet weak var passwordTextField: MedlineTextField!
    @IBOutlet weak var passwordVisibleButton: UIButton!
    @IBOutlet weak var passwordErrorView: MedlineErrorText!
    @IBOutlet weak var passwordErrorHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var confirmPasswordTextField: MedlineTextField!
    @IBOutlet weak var confirmPasswordVisibleButton: UIButton!
    @IBOutlet weak var confirmPasswordErrorView: MedlineErrorText!
    @IBOutlet weak var confirmPasswordErrorHeight: NSLayoutConstraint!
    
    @IBOutlet weak var agreeTermsButton: UIButton!
    
    @IBOutlet weak var termConditionPrivacyPolicyLabel: UILabel!
    
    @IBOutlet weak var passwordValidationsView: MedlinePasswordValidationView!
    
    @IBOutlet weak var termConditionPrivacyPolicyView: UIView!
    @IBOutlet weak var termConditionPrivacyPolicyWebView: WKWebView!
    
    let haveAccount = localizedString("HAVE_ACCOUNT_LOGIN")
    let agreeText = localizedString("PRIVACYPOLICY_AND_TERMCONDITION")
    let privacyPolicy = localizedString("PRIVACY_POLICY")
    let termCondition = localizedString("TERMS_CONDITION")
    
    let registerViewModel = MedlineRegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMedineNavigationBar(withBack: true)
        updateHyperLinklabel()
        updateActiveLoginlabel()
        addCustomMedlineNavigationBar(withBack: true)
        accessibilityTextUpdate()
        //Disabling validations with empty text
        self.passwordValidationsView.highlightPasswordInstructions(text: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        termConditionPrivacyPolicyView.isHidden = true
    }
    
    fileprivate func accessibilityTextUpdate() {
        // ADA localized values
        firstNameTextField.accessibilityValue = localizedString("ADA_PLACEHOLDER_FIRSTNAME")
        lastNameTextField.accessibilityValue = localizedString("ADA_PLACEHOLDER_LASTNAME")
        customerNumberTextField.accessibilityValue = localizedString("ADA_PLACEHOLDER_CUSTOMER_NUMBER")
        phoneNumberTextField.accessibilityValue = localizedString("ADA_PLACEHOLDER_PHONE_NUMBER")
        emailTextField.accessibilityValue = localizedString("ADA_PLACEHOLDER_EMAIL")
        passwordTextField.accessibilityValue = localizedString("ADA_PLACEHOLDER_PASSWORD")
        confirmPasswordTextField.accessibilityValue = localizedString("ADA_PLACEHOLDER_CONFIRM_PASSWORD")
    }
    
    
    //Method is used to set hyper link for Agree Terms and Condition text
    func updateHyperLinklabel() {
        let text = isDeviceTypeIPad() ? agreeText.replacingOccurrences(of: "\n", with: "") : agreeText
        termConditionPrivacyPolicyLabel.attributedText = String.formatForActiveLabel(strings: [privacyPolicy, termCondition], inString: text)
        let tap = UITapGestureRecognizer(target: self, action: #selector(agreeTermTapAction))
        termConditionPrivacyPolicyLabel.addGestureRecognizer(tap)
    }
    
    // Method is used to create active Login label
    func updateActiveLoginlabel() {
        alreadyAccountLabel.attributedText = String.formatForActiveLabel(strings: ["Login"], inString: haveAccount)
        let tap = UITapGestureRecognizer(target: self, action: #selector(loginTapAction))
        alreadyAccountLabel.addGestureRecognizer(tap)
    }
    
    func releaseWebKitResources() {
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
        print("Release Resources Of Controller")
    }
    
    func openMedlineWebContentViewController(webPageURL: String) {
        if isConnectedToInternet() {
            view.bringSubviewToFront(termConditionPrivacyPolicyView)
            termConditionPrivacyPolicyView.isHidden = false
            let url = NSURL (string: retrieveProperString(retrieveString: webPageURL))
            let requestObj = NSURLRequest(url: url! as URL)
            termConditionPrivacyPolicyWebView.clearsContextBeforeDrawing = true
            termConditionPrivacyPolicyWebView.navigationDelegate = self
            termConditionPrivacyPolicyWebView.load(requestObj as URLRequest)
        } else {
            showNetworkUnavailableAlert()
        }
    }
    
    @IBAction func textFieldDidChange(_ textField: MedlineTextField) {
        if textField == firstNameTextField {
            _ = firstNameValidation()
        } else if textField == lastNameTextField {
            _ = lastNameValidation()
        } else if textField == customerNumberTextField {
            _ = customerNumberValidation()
        } else if textField == phoneNumberTextField {
            _ = phoneNumberValidation()
        } else if textField == emailTextField {
            _ = emailValidation()
        } else if textField == passwordTextField {
            // password visible icon will appear, if textfield has text
            if textField.text!.count > 0 {
                passwordVisibleButton.isHidden = false
            } else {
                passwordVisibleButton.isHidden = true
            }
            
            //validation for highlighting instructions
            if let text = textField.text {
                self.passwordValidationsView.highlightPasswordInstructions(text: text)
            }

            _ = passwordValidation()
            
            if confirmPasswordTextField.text!.count > 0 {
                _ = confirmPasswordValidation()
                confirmPasswordTextField.setNeedsLayout()
            }
        } else if textField == confirmPasswordTextField {
            // password visible icon will appear, if textfield has text
            if textField.text!.count > 0 {
                confirmPasswordVisibleButton.isHidden = false
            } else {
                confirmPasswordVisibleButton.isHidden = true
            }
            _ = confirmPasswordValidation()
        }
    }
    
    // Method will call while tap on 'Login' active label in 'Already have an account? Login'
    @objc func loginTapAction(gesture: UITapGestureRecognizer) {
        let haveAcc = haveAccount as NSString
        let loginRange = haveAcc.range(of: "Login")

        let tapLocation = gesture.location(in: alreadyAccountLabel)
        let index = alreadyAccountLabel.indexOfAttributedTextCharacterAtPoint(point: tapLocation)

        if checkRange(loginRange, contain: index) == true {
            navigationController?.popViewController(animated: true)
        }
    }
    
    // Method will call while tap on Terms and Condition in Agree text
    @objc func agreeTermTapAction(gesture: UITapGestureRecognizer) {
        let termString = agreeText as NSString
        let termRange = termString.range(of: termCondition)
        let policyRange = termString.range(of: privacyPolicy)

        let tapLocation = gesture.location(in: termConditionPrivacyPolicyLabel)
        let index = termConditionPrivacyPolicyLabel.indexOfAttributedTextCharacterAtPoint(point: tapLocation)

        if checkRange(termRange, contain: index) == true {
            openMedlineWebContentViewController(webPageURL: MedlineWebPageURL.medlineTermAndConditionURL)
            return
        }

        if checkRange(policyRange, contain: index) {
            openMedlineWebContentViewController(webPageURL: MedlineWebPageURL.medlinePrivacyPolicyURL)
            return
        }
    }
    
    func isAllTextFieldValid() -> Bool {
        
        let isValidFirstName = firstNameValidation()

        let isValidLastName = lastNameValidation()
        
        let isValidCustomerName = customerNumberValidation()
        
        let isValidPhone = phoneNumberValidation()
        
        let isValidEmail = emailValidation()
        
        let isValidPassword = passwordValidation()

        let isValidConfirmPassword = confirmPasswordValidation()
        
        let isValid = isValidFirstName && isValidLastName && isValidCustomerName && isValidPhone && isValidEmail && isValidPassword && isValidConfirmPassword
        
        return isValid
    }
    
    func privacyPolicyAndTermConditionValidation() {
        showAlert(title: MedlineAppConstant.kError, message: registerViewModel.agreeTermErrorMessage(), actionTitle: kOkay)
    }
    
    func firstNameValidation() -> Bool {
        let errorString = registerViewModel.firstNameErrorText(name: firstNameTextField.text ?? "")
        let isValid = errorString == "" ? true : false

        firstNameTextField.isValidField = isValid
        nameErrorView.errorText.text = errorString
        nameErrorHeight.constant = nameErrorView.height()
        if lastNameErrorView.errorText.text != "" {
            nameErrorHeight.constant = lastNameErrorView.height()
        }
        return isValid
    }
    
    func lastNameValidation() -> Bool {
        let errorString = registerViewModel.lastNameErrorText(name: lastNameTextField.text ?? "")
        let isValid = errorString == "" ? true : false
        
        lastNameTextField.isValidField = isValid
        lastNameErrorView.errorText.text = errorString
        let height = lastNameErrorView.height()
        if isDeviceTypeIPad() {
            lastNameErrorHeight.constant = isValid ? MedlineErrorTextConstant.defaultError : height
        } else {
            nameErrorHeight.constant = height
            if nameErrorView.errorText.text != "" {
                nameErrorHeight.constant = nameErrorView.height()
            }
        }
        return isValid
    }
    
    func customerNumberValidation() -> Bool {
        let errorString = registerViewModel.customerIdErrorText(customer: customerNumberTextField.text ?? "")
        let isValid = errorString == "" ? true : false

        customerNumberTextField.isValidField = isValid
        customerNumberErrorView.errorText.text = errorString
        customerNumberErrorHeight.constant = customerNumberErrorView.height()
        return isValid
    }
    
    func phoneNumberValidation() -> Bool {
        let errorString = registerViewModel.phoneNumberErrorText(phoneNumber: phoneNumberTextField.text ?? "")
        let isValid = errorString == "" ? true : false

        phoneNumberTextField.isValidField = isValid
        phoneNumberErrorView.errorText.text = errorString
        phoneNumberErrorHeight.constant = phoneNumberErrorView.height()
        return isValid
    }
    
    func emailValidation() -> Bool {
        let errorString = registerViewModel.emailErrorText(email: emailTextField.text ?? "")
        let isValid = errorString == "" ? true : false

        emailTextField.isValidField = isValid
        emailErrorView.errorText.text = errorString
        emailErrorHeight.constant = emailErrorView.height()
        return isValid
    }
    
    func passwordValidation() -> Bool {
        let errorString = registerViewModel.passwordErrorText(password: passwordTextField.text ?? "")
        let isValid = errorString == "" ? true : false

        passwordTextField.isValidField = isValid
        passwordErrorView.errorText.text = errorString
        
        //removing space 16 below password textfield setting 0
        if (passwordTextField.isValidField) {
            passwordErrorHeight.constant = MedlineErrorTextConstant.hideErrorZero
        } else {
            passwordErrorHeight.constant = passwordErrorView.height()
        }
        return isValid
    }
    
    func confirmPasswordValidation() -> Bool {
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        let errorString = registerViewModel.confirmPasswordErrorText(conformPassword: confirmPassword, password: password)
        let isValid = errorString == "" ? true : false

        confirmPasswordTextField.isValidField = isValid
        confirmPasswordErrorView.errorText.text = errorString
        confirmPasswordErrorHeight.constant = confirmPasswordErrorView.height()
        return isValid
    }
    
    /// Method will execute when tap on password hide/ show button
    /// - Parameter sender: 
    @IBAction func passwordToggleAction(_ sender: Any) {
        passwordVisibleButton.isSelected = !passwordVisibleButton.isSelected
        passwordTextField?.isSecureTextEntry = !passwordVisibleButton.isSelected
    }
    
    /// Method will execute when tap on confirm password hide/ show button
    /// - Parameter sender:
    @IBAction func confirmPasswordToggleAction(_ sender: Any) {
        confirmPasswordVisibleButton.isSelected = !confirmPasswordVisibleButton.isSelected
        confirmPasswordTextField?.isSecureTextEntry = !confirmPasswordVisibleButton.isSelected
    }
    
    /// Method will execute when tap on register button
    /// - Parameter sender:
    @IBAction func registerButtonAction(_ sender: Any) {
        dismissKeyboard()
        if isAllTextFieldValid() {
            guard agreeTermsButton.isSelected == true else {
                privacyPolicyAndTermConditionValidation()
                return
            }
            connectRegisterAPI()
        } else {
            // Redraw the layer as and when condition is not satisfied
            firstNameTextField.setNeedsLayout()
            lastNameTextField.setNeedsLayout()
            customerNumberTextField.setNeedsLayout()
            phoneNumberTextField.setNeedsLayout()
            emailTextField.setNeedsLayout()
            passwordTextField.setNeedsLayout()
            confirmPasswordTextField.setNeedsLayout()
        }
    }
    
    // ToDo : need to optimise this logic
    @IBAction func checkUncheckToggleAction(_ sender: Any) {
        agreeTermsButton.isSelected = !agreeTermsButton.isSelected
    }
    
    /// Method is used to connect RegisterAPI via Viewmodel
    func connectRegisterAPI() {
        firstly {
            self.startPromiseActivityIndicator()
        }.then {
            self.registerViewModel.callRegisterAPI(firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!,
                                                   email: self.emailTextField.text!, phone: self.phoneNumberTextField.text!,
                                                   customerNumber: self.customerNumberTextField.text!, password: self.passwordTextField.text!)
        }.done { (message) in
            let _ = self.stopPromiseActivityIndicator()
            if message == MedlineServiceConstant.kSuccess {
                let newViewController = UIStoryboard(name: retrieveStoryboardName(), bundle: nil).instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kFullScreenMessageViewControllerID)
                
                if let viewController = newViewController as? MedlineFullScreenMessageViewController {
                    viewController.message = self.registerViewModel.successLabelText()
                    viewController.greetTitle = self.registerViewModel.greetLabelText()
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            } else {
                self.showAlert(title: MedlineAppConstant.kError, message: message, actionTitle: kOkay)
            }
        }.catch { (error) in
            let _ = self.stopPromiseActivityIndicator()
            self.showAlert(title: MedlineAppConstant.kError, message: error.localizedDescription, actionTitle: kOkay)
        }
    }
    @IBAction func closeWebView(_ sender: UIButton) {
        termConditionPrivacyPolicyView.isHidden = true
        releaseWebKitResources()
    }
}


extension MedlineRegisterAccountViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if (textField == phoneNumberTextField) {
            // To format the phone number as (XXX) XXX-XXXX
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)

            let decimalString = components.joined(separator: "") as NSString
            let length = decimalString.length
            let hasLeadingOne = false //length > 0 && decimalString.hasPrefix("1")

            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int

                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()

            if (length - index) > 3 {
                let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("(%@) ", areaCode)
                index += 3
            }
            if length - index > 3 {
                let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }

            let remainder = decimalString.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            _ = phoneNumberValidation()
            return false
        } else {
            return true
        }
    }
}

extension MedlineRegisterAccountViewController: WKNavigationDelegate {
    // MARK: Webview delegate methods
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error){
        print(error.localizedDescription)
        stopActivityIndicator()
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        print("Start to load")
        startActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        print("Finish Loading")
        stopActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        print("Error in Loading")
        stopActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
           let trust = challenge.protectionSpace.serverTrust!
           let exceptions = SecTrustCopyExceptions(trust)
           SecTrustSetExceptions(trust, exceptions)
           completionHandler(.useCredential, URLCredential(trust: trust))
    }
}

