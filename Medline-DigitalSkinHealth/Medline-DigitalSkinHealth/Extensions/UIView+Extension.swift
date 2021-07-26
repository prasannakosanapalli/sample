//
//  UIView+Extension.swift
//  Medline-DigitalSkinHealth
//
//  Created by Hariharan A on 02/03/21.
//

import Foundation
import UIKit

extension UIView {
    /// Eventhough we already set the file owner in the xib file, where we are setting the file owner again because sending nil will set existing file owner to nil.
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        let nibName : String = (Device.isPad ? NibName.ipad : NibName.iphone)
        guard let contentView = Bundle(for: type(of: self))
            .loadNibNamed(nibName, owner: self, options: nil)?.first as? T else {
                return nil
        }
        return contentView
    }
}
