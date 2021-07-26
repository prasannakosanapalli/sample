//
//  MedlineSigninViewController.swift
//  XCTestSample
//
//  Created by Sunil Kumar Jaiswal on 15/82/21.
//

import UIKit
import PromiseKit
class MedlineLoginViewController: MedlineBaseViewController, UITextFieldDelegate {
    
    //MARK:- Outlet connections
    @IBOutlet weak var emailTextField: MedlineTextField!
    @IBOutlet weak var emailErrorView: MedlineErrorText!
    @IBOutlet weak var emailErrorLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var passwordTextField: MedlineTextField!
    @IBOutlet weak var passwordErrorView: MedlineErrorText!
    @IBOutlet weak var passwordErrorLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var passwordVisibleButton: UIButton!
        
    let loginViewModel = MedlineLoginViewModel()

    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomMedlineNavigationBar(withBack: false)
        accessibilityTextUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
        passwordVisibleButton.isHidden = true
        // Hiding error view
        email(isValid: true)
        password(isValid: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Dismissing keyboard
        dismissKeyboard()
    }
    
    //MARK:- Accessibility values
    fileprivate func accessibilityTextUpdate() {
        // ADA localized values
        emailTextField.accessibilityValue = localizedString("ADA_PLACEHOLDER_EMAIL")
        passwordTextField.accessibilityValue = localizedString("ADA_PLACEHOLDER_PASSWORD")
    }
    
    /// TextField Action - Method will call when textfield get change
    /// - Parameter textField: selected textfield
    @IBAction func textFieldDidChange(_ sender: MedlineTextField) {
        if sender == emailTextField {
            let isValidEmail = emailTextField.text?.isValidEmail()
            email(isValid: isValidEmail!)

        }
        if sender == passwordTextField {
            // password visible icon will appear, if textfield has text
            if passwordTextField.text!.count > 0 {
                passwordVisibleButton.isHidden = false
            } else {
                passwordVisibleButton.isHidden = true
            }
            let isValidPassword = passwordTextField.text?.isNotEmpty()//isValidPassword()
            password(isValid: isValidPassword!)

        }
    }
    
    /// Email Validation view  update
    /// - Email isValid: validation result
    func email(isValid: Bool) {
        let errorString = loginViewModel.emailErrorText(isValid: isValid, emailText:emailTextField.text!)

        emailTextField.isValidField = isValid
        emailErrorView.errorText.text = errorString
        emailErrorLabelHeight.constant = emailErrorView.height()
    }
    
    /// Password Validation view  update
    /// - Parameter isValid: validation result
    func password(isValid: Bool) {
        let errorString = loginViewModel.passwordErrorText(isValid: isValid)

        passwordTextField.isValidField = isValid
        passwordErrorView.errorText.text = errorString
        passwordErrorLabelHeight.constant = passwordErrorView.height()
    }
    
    /// Method is used to validate login and password textfields
    /// - Returns: Login button will work based on true/false result
     func isEmailPasswordValid() -> Bool {
        
        let isValidEmail = emailTextField.text?.isValidEmail()
        email(isValid: isValidEmail!)
        
        let isValidPassword = passwordTextField.text?.isNotEmpty()//isValidPassword()
        password(isValid: isValidPassword!)
        
        let isValid = isValidEmail! && isValidPassword!
        
        return isValid

    }
    
    //MARK:- Show / Hide password button action
    /// Method will call while tapping on show/hide password
    /// - Parameter sender
    @IBAction func showHidePasswordAction(_ sender: Any) {
        passwordVisibleButton.isSelected = !passwordVisibleButton.isSelected
        passwordTextField?.isSecureTextEntry = !passwordVisibleButton.isSelected
    }
    
    //MARK:- Login button action
    /// Method will call when tapping on login button
    /// - Parameter sender: login button
    @IBAction func loginAction(_ sender: Any) {
        // Dismissing keyboard
        dismissKeyboard()
        if isEmailPasswordValid() {
            //call login API atter email and password are valid
            connectLoginAPI()
        } else {
            // Redraw the layer as and when condition is not satisfied
            emailTextField.setNeedsLayout()
            passwordTextField.setNeedsLayout()
        }
    }
    
    //MARK:- Login API Call
    func connectLoginAPI() {
        let userEmailID = retrieveProperString(retrieveString: self.emailTextField.text!)
        firstly {
            self.startPromiseActivityIndicator()
        }.then {
            self.loginViewModel.callLoginAPI(email: userEmailID, password: self.passwordTextField.text!)
        }.done { (loginNavigation) in
            let _ = self.stopPromiseActivityIndicator()
            switch loginNavigation.0 {
            case .updatePassword:
                self.navigateToUpdatePasswordViewController(userEmailID: userEmailID)
            case .homeScreen:
                print("Navigate to Home screen")
                self.navigateToHomeScreen()
            case .error:
                self.showAlert(title: MedlineAppConstant.kError, message: loginNavigation.1, actionTitle: kOkay)
            }
        }.catch { (error) in
            let _ = self.stopPromiseActivityIndicator()
            self.showAlert(title: MedlineAppConstant.kError, message: error.localizedDescription, actionTitle: kOkay)
        }
    }
    
    //MARK:- Navigate to Reset / Update passsword based on login response
    func navigateToUpdatePasswordViewController(userEmailID: String) {
        let newViewController = UIStoryboard(name: retrieveStoryboardName(), bundle: nil).instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kResetPasswordViewControllerID)
        if let viewController = newViewController as? MedlineResetPasswordViewController {
            viewController.isCallFromLoginViewController = true
            viewController.loginUserEmailID = userEmailID
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    //MARK:- Navigate to Home screen after login successfull
    func navigateToHomeScreen() {
        let newViewController = UIStoryboard(name: StoryboardType.iphone, bundle: nil).instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kHomeViewControllerID)
        if let viewController = newViewController as? MedlineHomeViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    //MARK:- Forgot password button action
    /// Navigate to forgot password screen
    @IBAction func forgotPasswordSubmitAction(_ sender: Any) {
        navigateToForgotPassword()
    }
    
    /// Navigate to forgot password screen
    func navigateToForgotPassword() {
        let newViewController = UIStoryboard(name: retrieveStoryboardName(), bundle: nil).instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kForgotPasswordViewControllerID)
        if let viewController = newViewController as? MedlineForgotPasswordViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    //MARK:- Register Button Action
    /// Navigate to Register screen
    @IBAction func registerButtonAction(_ sender: Any) {
        navigateToRegistration()
    }
    
    /// Navigate to Registration screen
    func navigateToRegistration() {
        let newViewController = UIStoryboard(name: retrieveStoryboardName(), bundle: nil).instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kRegistrationViewControllerID)
        if let viewController = newViewController as? MedlineRegisterAccountViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
