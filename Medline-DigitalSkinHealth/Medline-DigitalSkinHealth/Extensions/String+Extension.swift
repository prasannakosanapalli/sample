//
//  MedlineServiceManager.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /// Method is used validate the email
    /// - Returns: will returrn true if email is valid else false
    func isValidEmail() -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", MedlineRegex.emailRegex)
        return emailPred.evaluate(with: self)
    }
    
    /// Method is used validate the password
    /// - Returns: will returrn true if password is valid else false
    func isValidPassword() -> Bool {
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", MedlineRegex.passwordRegex)
        return passwordPred.evaluate(with: self)
    }
    
    /// Method is used validate the phonenumber
    /// - Returns: will returrn true if phonenumber is valid else false
    func isValidMobileNumber() -> Bool {
        //"+1 (123) 456-7890"  "(\\([0-9]{3}\\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}"
        let mobileNumber = NSPredicate(format:"SELF MATCHES %@", MedlineRegex.phoneNumberRegex)
        return mobileNumber.evaluate(with: self)
    }
    
    /// Method is used to validate string is empty or not
    func isNotEmpty() -> Bool {
        if (self.trimmingCharacters(in: .whitespaces).isEmpty == true) {
            return false
        } else {
            return true
        }
    }
    
    /// Get Final string from all textfields
    /// - Parameters:
    ///   - text1: Pin1 text
    ///   - text2: Pin2 text
    ///   - text3: Pin3 text
    ///   - text4: Pin4 text
    /// - Returns: sum of all inputs
    func retrieveFinalText(text1:String, text2:String, text3:String, text4:String) -> String {
        let finalString = text1 + text2 + text3 + text4
        return finalString
    }
    
    /// Alllowing charecters for PIN TesfFields
    /// - Parameters:
    ///   - text: textField's text
    ///   - range: string range
    ///   - replacingtring:user entered text
    /// - Returns: is allowed or not (true or false)
    func isAllowed(text:String,range:NSRange,replacingtring:String) -> Bool {
        
        let allowedCharacters = "1234567890"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: replacingtring)
        let numbers = allowedCharacterSet.isSuperset(of: typedCharacterSet)
        let newRange = range.length + range.location > text.count

        if (newRange == false && numbers == false) {
            return false
        }
        let NewLength = text.count + replacingtring.count - range.length
            return NewLength <= 1
    }
    
    //To validate the entered number of charecters in text field
    func isValidName() -> Bool {
        return self.count > 4
    }
    
    //To verify the password while reset
    func doPasswordsMatch(conformPassword:String) -> Bool {
        guard self.count != 0 && conformPassword.count != 0 else {
            return false
        }
        return self == conformPassword
    }
    
    // Method is used to create attributed text for HyperLink label
    static func formatForActiveLabel(strings: [String],
                       inString string: String) -> NSAttributedString {
        var fontSize =  FontSizes.fontSizeSixteen
        var hyperlinkFont: UIFont = UIFont(name: "OpenSans-Semibold", size: fontSize)!

        if strings.contains("Login") {
            fontSize = isDeviceTypeIPad() ? FontSizes.fontSizeTwentyTwo : FontSizes.fontSizeSixteen
            hyperlinkFont = UIFont(name: "OpenSans-Bold", size: fontSize)!
        }
        let hyperlinkColor: UIColor = UIColor.init(named: MedlineColor.kBlueMedline)!

        let blackTextFont: UIFont = UIFont(name: "OpenSans-Regular", size: fontSize)!
        let blackColor: UIColor = UIColor.init(named: MedlineColor.kBlackShade)!
        
        let attributedString =
            NSMutableAttributedString(string: string,
                                      attributes: [
                                        NSAttributedString.Key.font: blackTextFont,
                                        NSAttributedString.Key.foregroundColor: blackColor])
        let boldFontAttribute = [NSAttributedString.Key.font: hyperlinkFont,
                                 NSAttributedString.Key.foregroundColor: hyperlinkColor]
        for bold in strings {
            attributedString.addAttributes(boldFontAttribute, range: (string as NSString).range(of: bold))
        }
        return attributedString
    }
    
    var isNumber: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    var isIntegerOrdDouble: Bool {
        return Int(self) != nil || Double(self) != nil
    }
        
    func containStringIgnoringCase(_ find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    var stringToDouble: Double {
        return Double(self) ?? 0.0
    }

    func toInt() -> Int64 {
        if let num = NumberFormatter().number(from: self) {
            return num.int64Value
        } else {
            return 0
        }
    }
    
    func containsNumbers() -> Bool {
        let numberRegEx = MedlinePasswordRegex.oneNumberRegex
        let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return testCase.evaluate(with: self)
    }
     func containsUpperCase() -> Bool {
        let upperCaseRegEx = MedlinePasswordRegex.oneUpperCaseRegex
        let testCase = NSPredicate(format:"SELF MATCHES %@", upperCaseRegEx)
        return testCase.evaluate(with: self)
    }
    func containsSpecialCharacter() -> Bool {
        let specialCharacterRegEx = MedlinePasswordRegex.oneSpecialCharacterRegex
        let testCase = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        return testCase.evaluate(with: self)
    }
    func containsMinimumEightCharacters() -> Bool {
        let minimumEightNumbersRegEx  = MedlinePasswordRegex.minimumEightCharactersRegex
        let testCase = NSPredicate(format:"SELF MATCHES %@", minimumEightNumbersRegEx)
        return testCase.evaluate(with: self)
    }
}
