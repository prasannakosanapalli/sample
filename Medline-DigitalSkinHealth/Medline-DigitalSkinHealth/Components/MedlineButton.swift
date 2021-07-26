//
//  Button.swift
//  MedlineOnBoardSample
//
//  Created by Vijay Guruju on 29/01/21.
//

import UIKit

class MedlineButton: UIButton {
    
    //MARK:- Initilisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutSetup()
        
    }
    
    //MARK:- Layout updates
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSetup()
    }
    
    //MARK:- Button layout
    private func layoutSetup() {
        self.layer.cornerRadius = self.bounds.height / 2
        let controlStates: Array<UIControl.State> = [.normal, .highlighted, .selected, .focused]
        
        if (self.tag == 11) {//Sign in here Button with no background color
            self.backgroundColor = .white
            layer.borderWidth = 1
            layer.borderColor = UIColor(named: MedlineColor.kWhiteButtonBorderColor)?.cgColor
            for controlState in controlStates {
                self.setTitleColor(UIColor(named: MedlineColor.kBlackShade), for: controlState)
            }
        } else {
            self.backgroundColor = UIColor(named: MedlineColor.kBlueMedline)
            layer.borderWidth = 1
            layer.borderColor = UIColor(named: MedlineColor.kBlueMedline)?.cgColor
            for controlState in controlStates {
                self.setTitleColor(.white, for: controlState)
            }
        }
        
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom:10, right: 10)
        self.setDynamicFont()
    }
}

extension UIButton {
    
    /// Getting adaptive font size for device sizes
    /// - Parameters:
    ///   - small: font size for small screen size devices example: iPhone 6s,8,SE2
    ///   - medium: font size for medium screen size devices example: iPhone 6s plus, iPhone11,12,12Pro
    ///   - big: font size for Big screen size devices example: iPads
    func setDynamicFont() {
        //let fontSize = Device.size(small: small, medium: medium, big: big)
        let fontSize = isDeviceTypeIPad() ? FontSizes.fontSizeTwentyFive : FontSizes.fontSizeEighteen
        self.titleLabel?.font = setSemiboldFont(font_size: fontSize)

    }
}
