//
//  MedlineErrorText.swift
//  Medline-DigitalSkinHealth
//
//  Created by Hariharan A on 02/03/21.
//

import UIKit

struct MedlineErrorTextConstant {
    static let defaultError = CGFloat(16)
    static let showError = CGFloat(35)
    static let hideError = CGFloat(16)
    static let hideErrorZero = CGFloat(0)
}

class MedlineErrorText: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var errorText: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "MedlineErrorText", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func height() -> CGFloat {
        errorText.numberOfLines = 0
        errorText.lineBreakMode = NSLineBreakMode.byWordWrapping
        errorText.text = errorText.text
        errorText.sizeToFit()
        return MedlineErrorTextConstant.defaultError + errorText.frame.height
    }

}
