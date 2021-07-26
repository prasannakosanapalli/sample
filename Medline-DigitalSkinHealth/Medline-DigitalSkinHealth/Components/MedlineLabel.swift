//
//  MedlineLabel.swift
//  MedlineOnBoardSample
//
//  Created by Vijay Guruju on 08/02/21.
//

import Foundation
import UIKit

class MedlineLabel: UILabel {
    
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
    
    //MARK:- Label layout
    private func layoutSetup() {
        self.numberOfLines = 0
        self.setDynamicFont(small: 14, medium: 16, big: 26)
    }
    
}

extension UILabel {
    
    /// Getting adaptive font size for device sizes
    /// - Parameters:
    ///   - small: font size for small screen size devices example: iPhone 6s,8,SE2
    ///   - medium: font size for medium screen size devices example: iPhone 6s plus, iPhone11,12,12Pro
    ///   - big: font size for Big screen size devices example: iPads
    func setDynamicFont(small: CGFloat, medium: CGFloat, big: CGFloat) {
        let fontSize =  Device.size(small: small, medium: medium, big: big)
        self.font = UIFont(name: FontFamily.kRegular, size: fontSize)

    }
}
