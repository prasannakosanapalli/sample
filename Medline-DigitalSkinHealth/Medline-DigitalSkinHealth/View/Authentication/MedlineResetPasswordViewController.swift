//
//  MedlineResetPasswordViewController.swift
//  XCTestSample
//
//  Created by Sunil Kumar Jaiswal on 15/02/21.
//

import UIKit
import PromiseKit

class MedlineResetPasswordViewController: MedlineBaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var resetPasswordTopLabel: UILabel!
    
    @IBOutlet weak var newPasswordTextField: MedlineTextField!
    @IBOutlet weak var newPasswordErrorView: MedlineErrorText!
    @IBOutlet weak var newPasswordErrorHeight: NSLayoutConstraint!
    
    @IBOutlet weak var newPasswordVisibleButton: UIButton!
    var newPasswordVisibleStatus: Bool = false
    
    @IBOutlet weak var confirmPasswordTextField: MedlineTextField!
    @IBOutlet weak var confirmPasswordErrorView: MedlineErrorText!
    @IBOutlet weak var confirmPasswordErrorHeight: NSLayoutConstraint!
    
    @IBOutlet weak var confirmPasswordVisibleButton: UIButton!
    var confirmPasswordVisibleStatus: Bool = false
    
    @IBOutlet weak var passwordValidationsView: MedlinePasswordValidationView!
    
    @IBOutlet weak var restPasswordButton: MedlineButton!
    
    var isCallFromLoginViewController : Bool = false
    var loginUserEmailID: String = ""
    var loginToken:String = ""
    let resetPasswordViewModel = MedlineResetPasswordViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        //addMedineNavigationBar(withBack: true)
        addCustomMedlineNavigationBar(withBack: true)
        setUILabelAndButtonTitle()
        accessibilityTextUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Disabling validations with empty text
        self.passwordValidationsView.highlightPasswordInstructions(text: "")
    }
        
    fileprivate func accessibilityTextUpdate() {
        // ADA localized values
        newPasswordTextField.accessibilityValue = localizedString("ADA_PLACEHOLDER_NEW_PASSWORD")
        confirmPasswordTextField.accessibilityValue = localizedString("ADA_PLACEHOLDER_CONFIRM_PASSWORD")
    }
    
    @IBAction func newPasswordToggleAction(_ sender: Any) {
        let isPasswordVisible = !newPasswordVisibleStatus
        if isPasswordVisible {
            newPasswordVisibleStatus = true
            newPasswordTextField?.isSecureTextEntry = false
            newPasswordVisibleButton.isSelected = true
        } else {
            newPasswordVisibleStatus = false
            newPasswordTextField?.isSecureTextEntry = true
            newPasswordVisibleButton.isSelected = false
        }
    }
    
    @IBAction func confirmPasswordToggleAction(_ sender: Any) {
        let isPasswordVisible = !confirmPasswordVisibleStatus
        if isPasswordVisible {
            confirmPasswordVisibleStatus = true
            confirmPasswordTextField?.isSecureTextEntry = false
            confirmPasswordVisibleButton.isSelected = true
        } else {
            confirmPasswordVisibleStatus = false
            confirmPasswordTextField?.isSecureTextEntry = true
            confirmPasswordVisibleButton.isSelected = false
        }
    }
    
    @IBAction func medlineResetPasswordAction(_ sender: Any) {
        dismissKeyboard()
        if isAllTextFieldValid() {
            connectResetPasswordAPI()
            
        } else {
            // Redraw the layer as and when condition is not satisfied
            newPasswordTextField.setNeedsLayout()
            confirmPasswordTextField.setNeedsLayout()
        }
    }
    
    func connectResetPasswordAPI() {
        loginToken = MedlineKeychainData.retrieveUserLoginToken()
        firstly {
            self.startPromiseActivityIndicator()
        }.then {
            self.resetPasswordViewModel.callResetPasswordAPI(email: self.loginUserEmailID, password: retrieveProperString(retrieveString: self.confirmPasswordTextField.text), token: self.loginToken)
        }.done { (message) in
            let _ = self.stopPromiseActivityIndicator()
            self.navigateToFullScreenMessageVC(message: message)
        }.catch { (error) in
            let _ = self.stopPromiseActivityIndicator()
            self.showAlert(title: MedlineAppConstant.kError, message: error.localizedDescription, actionTitle: kOkay)
        }
    }
    
    func navigateToFullScreenMessageVC(message: String) {
        if message == MedlineServiceConstant.kSuccess {
            let newViewController = UIStoryboard(name: retrieveStoryboardName(), bundle: nil).instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kFullScreenMessageViewControllerID)
            
            if let viewController = newViewController as? MedlineFullScreenMessageViewController {
                viewController.message = self.resetPasswordViewModel.successLabelText()
                viewController.greetTitle = self.resetPasswordViewModel.greetLabelText()
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        } else {
            self.showAlert(title: MedlineAppConstant.kError, message: message, actionTitle: kOkay)
        }
    }
    
    @IBAction func textFieldDidChange(_ textField: MedlineTextField) {
        
        if textField == newPasswordTextField {
            // password visible icon will appear, if textfield has text
            if textField.text!.count > 0 {
                newPasswordVisibleButton.isHidden = false
            } else {
                newPasswordVisibleButton.isHidden = true
            }
            //validation for highlighting instructions
            if let text = textField.text {
                self.passwordValidationsView.highlightPasswordInstructions(text: text)
            }
            let isValidPassword = newPasswordTextField.text?.isValidPassword()
            newPassword(isValid: isValidPassword!)
            
            if confirmPasswordTextField.text!.count > 0 {
                let isValidConfirmPassword = newPasswordTextField.text?.doPasswordsMatch(conformPassword: confirmPasswordTextField.text ?? "")
                let isEmptyConfirmPassword = confirmPasswordTextField.text?.isNotEmpty()
                confirmPassword(isValid: isValidConfirmPassword!, isEmpty: isEmptyConfirmPassword!)
                confirmPasswordTextField.setNeedsLayout()
            }
            
        } else if textField == confirmPasswordTextField {
            // password visible icon will appear, if textfield has text
            if textField.text!.count > 0 {
                confirmPasswordVisibleButton.isHidden = false
            } else {
                confirmPasswordVisibleButton.isHidden = true
            }
            let isValidConfirmPassword = newPasswordTextField.text?.doPasswordsMatch(conformPassword: confirmPasswordTextField.text ?? "")
            let isEmptyConfirmPassword = confirmPasswordTextField.text?.isNotEmpty()
            confirmPassword(isValid: isValidConfirmPassword!, isEmpty: isEmptyConfirmPassword!)
        }
    }
    
    func setUILabelAndButtonTitle() {
        if isCallFromLoginViewController {
            resetPasswordTopLabel.text = localizedString("RESET_PASSWORD_LABEL_TEXT")
            
            let controlStates: Array<UIControl.State> = [.normal, .highlighted, .selected, .focused]
            for controlState in controlStates {
                restPasswordButton.setTitle(localizedString("RESET_PASSWORD_LABEL_TEXT"), for: controlState)
            }
        }
    }
    
    func isAllTextFieldValid() -> Bool {
        let isValidPassword = newPasswordTextField.text?.isValidPassword()
        newPassword(isValid: isValidPassword!)
        
        let isValidConfirmPassword = newPasswordTextField.text?.doPasswordsMatch(conformPassword: confirmPasswordTextField.text ?? "")
        let isEmptyConfirmPassword = confirmPasswordTextField.text?.isNotEmpty()
        confirmPassword(isValid: isValidConfirmPassword!, isEmpty: isEmptyConfirmPassword!)
        return isValidPassword! && isValidConfirmPassword!
    }
    
    func newPassword(isValid: Bool) {
        let isNotEmpty = newPasswordTextField.text?.isNotEmpty()
        let errorString = resetPasswordViewModel.newPasswordErrorText(isValid: isValid,isNotEmpty:isNotEmpty!)
        newPasswordTextField.isValidField = isValid
        newPasswordErrorView.errorText.text = errorString
        
        //removing space 16 below password textfield setting 0
        if (newPasswordTextField.isValidField) {
            newPasswordErrorHeight.constant = MedlineErrorTextConstant.hideErrorZero

        } else {
            newPasswordErrorHeight.constant = newPasswordErrorView.height()
        }
    }
    
    func confirmPassword(isValid: Bool, isEmpty: Bool){
        let errorString = resetPasswordViewModel.confirmPasswordErrorText(isValid:isValid, isEmpty: isEmpty)
        confirmPasswordTextField.isValidField = isValid
        confirmPasswordErrorView.errorText.text = errorString
        confirmPasswordErrorHeight.constant = newPasswordErrorView.height()

    }
}
