//
//  MedlineForgotPasswordViewController.swift
//  XCTestSample
//
//  Created by Sunil Kumar Jaiswal on 15/02/21.
//

import UIKit
import PromiseKit

class MedlineForgotPasswordViewController: MedlineBaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var forgotPasswordEmailTextField: MedlineTextField!
    @IBOutlet weak var emailErrorText: MedlineErrorText!
    @IBOutlet weak var errorViewHeight: NSLayoutConstraint!
    
    let forgotPasswordViewModel = MedlineForgotPasswordViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomMedlineNavigationBar(withBack: true)
        accessibilityTextUpdate()
    }
    
    @IBAction func textFieldEditing(_ sender: MedlineTextField) {
        validateEmail()
    }
    
     func accessibilityTextUpdate() {
        // ADA localized values
        forgotPasswordEmailTextField.accessibilityValue = localizedString("ADA_PLACEHOLDER_EMAIL")
    }
    
    func isEmailTextFieldValid() -> Bool {
        var isAllDataValid: Bool = false
        validateEmail()
        if forgotPasswordEmailTextField.text?.isValidEmail() == true{
            isAllDataValid = true
        }
        return isAllDataValid
    }
    
    //MARK:- Validate email textfield and show respective error message
    func validateEmail(){
        let isValidEmail = forgotPasswordEmailTextField.text?.isValidEmail()
        let errorText = forgotPasswordViewModel.emailErrorText(isValid:isValidEmail!, emailText: forgotPasswordEmailTextField.text!)
        forgotPasswordEmailTextField.isValidField = isValidEmail!
        emailErrorText.errorText.text =  errorText
        errorViewHeight.constant = emailErrorText.height()
        
    }
    
    @IBAction func forgotPasswordSubmitAction(_ sender: Any) {
        dismissKeyboard()
        
        if isEmailTextFieldValid() {
            connectForgotPassowrdAPI()
        } else {
            // Redraw the layer as and when condition is not satisfied
            forgotPasswordEmailTextField.setNeedsLayout()
        }
    }
    
    func connectForgotPassowrdAPI() {
        firstly {
            self.startPromiseActivityIndicator()
        }.then {
            self.forgotPasswordViewModel.callForgotPasswordAPI(email: self.forgotPasswordEmailTextField.text!)
        }.done { (message) in
            self.successNavigation(message: message)
        }.catch { (error) in
            let _ = self.stopPromiseActivityIndicator()
            self.showAlert(title: MedlineAppConstant.kError, message: error.localizedDescription, actionTitle: kOkay)
        }
    }
    
    func successNavigation(message: String) {
        let _ = self.stopPromiseActivityIndicator()
        if message == MedlineServiceConstant.kSuccess {
            let newViewController = UIStoryboard(name: retrieveStoryboardName(), bundle: nil).instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kFullScreenMessageViewControllerID)
            
            if let viewController = newViewController as? MedlineFullScreenMessageViewController {
                viewController.message = self.forgotPasswordViewModel.successLabelText()
                viewController.greetTitle = self.forgotPasswordViewModel.greetLabelText()
                self.navigationController?.pushViewController(viewController, animated: true)
            }

        } else {
            self.showAlert(title: MedlineAppConstant.kError, message: message, actionTitle: kOkay)
        }
    }
}
