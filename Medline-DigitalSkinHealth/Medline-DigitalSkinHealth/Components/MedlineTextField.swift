//
//  MedlineTextField.swift
//  MedlineOnBoardSample
//
//  Created by Vijay Guruju on 08/02/21.
//

import Foundation
import UIKit

class MedlineTextField: UITextField {
    
    var isValidField = true
    var padding = UIEdgeInsets(top: 0, left: isDeviceTypeIPad() ? 18 : 12, bottom: 0, right: isDeviceTypeIPad() ? 21 : 18)

    //MARK:- Initilisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let fontSize =  isDeviceTypeIPad() ? FontSizes.fontSizeTwentyTwo : FontSizes.fontSizeSixteen
        
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [
            .foregroundColor: UIColor.init(named: MedlineColor.kPlaceholderTextColor) ?? UIColor.gray,
            .font: setRegularFont(font_size: fontSize)
        ])
        
        borderStyle = .roundedRect
        layer.borderWidth = isDeviceTypeIPad() ? 1.4 : 1.0
        layer.cornerRadius = isDeviceTypeIPad() ? 5.6 : 2.0
        tintColor = UIColor.init(named: MedlineColor.kBlackShade)
        font = setRegularFont(font_size: fontSize)
        autocorrectionType = .no
        
        if let placeholderString = placeholder, placeholderString.contains("Password") {
            // right side padding password show/hide icon
            padding = UIEdgeInsets(top: 0, left: isDeviceTypeIPad() ? 18 : 12, bottom: 0, right: isDeviceTypeIPad() ? 60 : 40)
        }
        
        layoutSetup()
    }
    
    
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    //MARK:- Layout updates
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSetup()
    }
    
    //MARK:- Disable Copy/Paste view
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            return false
    }
    
    //MARK:- TextField Layout setup
    func layoutSetup() {
        layer.borderColor = isValidField == true ? UIColor.init(named: MedlineColor.kBorderColor)?.cgColor :
            UIColor.init(named: MedlineColor.kRedError)?.cgColor
    }
}

extension UITextField{
    
    /// Getting adaptive font size for device sizes
    /// - Parameters:
    ///   - small: font size for small screen size devices example: iPhone 6s,8,SE2
    ///   - medium: font size for medium screen size devices example: iPhone 6s plus, iPhone11,12,12Pro
    ///   - big: font size for Big screen size devices example: iPads
    func setDynamicFont(small: CGFloat, medium: CGFloat, big: CGFloat) {
        let fontSize =  Device.size(small: small, medium: medium, big: big)
        font = UIFont(name: FontFamily.kRegular, size: fontSize)
    }
}
