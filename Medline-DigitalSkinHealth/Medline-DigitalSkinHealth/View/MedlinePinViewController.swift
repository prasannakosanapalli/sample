//
//  MedlinePinViewController.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
// 

import UIKit

class MedlinePinViewController: BaseViewController {
    
//MARK:- Outlet Connections
    @IBOutlet weak var pinTextField1: UITextField!
    @IBOutlet weak var pinTextField2: UITextField!
    @IBOutlet weak var pinTextField3: UITextField!
    @IBOutlet weak var pinTextField4: UITextField!
    @IBOutlet weak var errorLabel: MedlineLabel!
    @IBOutlet weak var currentUserButton: MedlineDropDownButton!
    @IBOutlet weak var continueButton: MedlineButton!
    @IBOutlet weak var loginLabel: UILabel!
    
    //variables
    var pinViewModel : MedlinePinViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pinTextField1.delegate = self
        pinTextField2.delegate = self
        pinTextField3.delegate = self
        pinTextField4.delegate = self
        
        //Textfields targets
        pinTextField1.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        pinTextField2.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        pinTextField3.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        pinTextField4.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
            
        errorLabel.isHidden = true
        //disabling button by defaulf have to enable later when PIN is correct
        continueButton.isEnabled = false
        continueButton.alpha = 0.5
        
        //Login Text highlight
        let attributedString = NSMutableAttributedString(string: loginLabel.text!, attributes: [
            .font: MedlineAppUtils.setRegularFont(font_size: 16)
        ])
        attributedString.addAttributes([
            .font: MedlineAppUtils.setBoldFont(font_size: 16),
          .foregroundColor: UIColor(red: 0.0, green: 82.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
        ], range: NSRange(location: 0, length: 5))
        
        self.loginLabel.attributedText = attributedString
    }
    
    //MARK:- Continue button Action
    @IBAction func continueButtonAction(_ sender: UIButton) {
        
        if let pin1Text = pinTextField1.text,
           let pin2Text = pinTextField2.text,
           let pin3text = pinTextField3.text,
           let pin4text = pinTextField4.text {
            self.pinViewModel = MedlinePinViewModel(pin1: pin1Text, pin2: pin2Text, pin3: pin3text, pin4: pin4text)
        }
        if (self.pinViewModel.isValid()) {
            print("Continue")
        } else {
            print("not valid")
        }

        
    }
    
    ///TextField value change
    /// - Parameter textField: input TextField
    @objc func textDidChange(textField:UITextField){
        
        let text = textField.text
        if (text?.count == 1) {
            switch textField {
            case pinTextField1:
                pinTextField2.becomeFirstResponder()
            case pinTextField2:
                pinTextField3.becomeFirstResponder()
            case pinTextField3:
                pinTextField4.becomeFirstResponder()
            case pinTextField4:
                pinTextField4.resignFirstResponder()
            default:
                break
            }
        }
        if (text?.count == 0) {
            switch textField {
            case pinTextField1:
                pinTextField1.becomeFirstResponder()
            case pinTextField2:
                pinTextField2.becomeFirstResponder()
            case pinTextField3:
                pinTextField3.becomeFirstResponder()
            case pinTextField4:
                pinTextField4.becomeFirstResponder()
            default:
                break
            }
        }
        else{
            print(text?.count ?? "No text")
        }
        
    }
    
    //MARK:- Set TextField Border Color and width
    func setTextFieldBorder(color:UIColor,width:CGFloat){
        
        self.pinTextField1.layer.borderColor = color.cgColor
        self.pinTextField1.layer.borderWidth = width
        
        self.pinTextField2.layer.borderColor = color.cgColor
        self.pinTextField2.layer.borderWidth = width
        
        self.pinTextField3.layer.borderColor = color.cgColor
        self.pinTextField3.layer.borderWidth = width
        
        self.pinTextField4.layer.borderColor = color.cgColor
        self.pinTextField4.layer.borderWidth = width
    }
    
    //MARK:- User selection Dropdown button action
    @IBAction func currentUserButtonAction(_ sender: MedlineDropDownButton) {
        self.currentUserButton.setupDropDownView(parentVC: self,dropDownData:[UserData(email: "user@medline.com"), UserData(email: "anotheruser@medline.com")])
    }
}

extension MedlinePinViewController : UITextFieldDelegate {
    
    //MARK:- TextField delegate methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let otpValue = "2637"
        if (textField == pinTextField4) {
            if let text1 = pinTextField1.text , let text2 =  pinTextField2.text , let text3 = pinTextField3.text, let text4 = pinTextField4.text {
                
                if otpValue == otpValue.retrieveFinalText(text1: text1, text2: text2, text3: text3, text4: text4) {
                    setTextFieldBorder(color: .green, width: 2.0)
                    self.errorLabel.isHidden = true
                    continueButton.isEnabled = true
                    continueButton.alpha = 1

                } else {
                    setTextFieldBorder(color: .red, width: 2.0)
                    self.errorLabel.isHidden = false
                    continueButton.isEnabled = false
                    continueButton.alpha = 0.5
                }
                
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text { //TextField to accepts only numbers and length one
           return text.isAllowed(text: text, range: range, replacingtring: string)
        }
        return false
    }
    
    
}

