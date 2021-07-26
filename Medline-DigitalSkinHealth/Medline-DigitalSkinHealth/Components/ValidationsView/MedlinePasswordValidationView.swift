//
//  MedlinePasswordValidationView.swift
//  Medline-DigitalSkinHealth
//
//  Created by Vijay Guruju on 26/02/21.
//

import UIKit

class MedlinePasswordValidationView: UIView {

    @IBOutlet weak var passwordInstructionsView: UIView!
    @IBOutlet weak var eightCharacterMinimumImageView: UIImageView!
    @IBOutlet weak var eightCharacterMinimumLabel: UILabel!
    @IBOutlet weak var oneSpecialCharacterImageView: UIImageView!
    @IBOutlet weak var oneSpecialCharacterLabel: UILabel!
    @IBOutlet weak var oneNumberImageView: UIImageView!
    @IBOutlet weak var oneNumberLabel: UILabel!
    @IBOutlet weak var oneUpperCaseImageView: UIImageView!
    @IBOutlet weak var oneUpperCaseLabel: UILabel!
    
    /// It is used when the view is created from storyboard/xib. It means setting custom class of a View in storyboard/xib to "CustomView"
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
  /*  /// It is used when you create the view programmatically.
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
 */
    
    private func commonInit() {
        /// Loading the nib
        guard let contentView = self.fromNib()
            else { fatalError("View could not load from nib") }
        addSubview(contentView)
       
    }
}

extension MedlinePasswordValidationView {
    /// HighLight Password instructions with respect to entered text
    /// - Parameter text: Textfield's text
     func highlightPasswordInstructions(text:String) {
        let labelHightlightColor = UIColor(named: MedlineColor.kBlackShade)
        let hightlightImage = UIImage(named: "validationDotActive")
        let labelDisabledColor = UIColor(named: MedlineColor.kGrayedOut)
        let disabledImage = UIImage(named: "velidationDOtDefault")
        //Minimum 8 Character
        if (text.containsMinimumEightCharacters()) {
            self.eightCharacterMinimumImageView.image = hightlightImage
            self.eightCharacterMinimumLabel.textColor = labelHightlightColor
            
        } else {
            self.eightCharacterMinimumImageView.image = disabledImage
            self.eightCharacterMinimumLabel.textColor = labelDisabledColor
        }
        //One special charecter
        if (text.containsSpecialCharacter()) {
            self.oneSpecialCharacterImageView.image = hightlightImage
            self.oneSpecialCharacterLabel.textColor = labelHightlightColor
        } else {
            self.oneSpecialCharacterImageView.image = disabledImage
            self.oneSpecialCharacterLabel.textColor = labelDisabledColor
        }
        //One number
        if (text.containsNumbers()) {
            self.oneNumberImageView.image = hightlightImage
            self.oneNumberLabel.textColor = labelHightlightColor
        } else {
            self.oneNumberImageView.image = disabledImage
            self.oneNumberLabel.textColor = labelDisabledColor
        }
        //One upper case
        if text.containsUpperCase() {
            self.oneUpperCaseImageView.image = hightlightImage
            self.oneUpperCaseLabel.textColor = labelHightlightColor
        } else {
            self.oneUpperCaseImageView.image = disabledImage
            self.oneUpperCaseLabel.textColor = labelDisabledColor
        }
        
    }

}
