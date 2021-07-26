//
//  UITableview+extension.swift
//  Medline-DigitalSkinHealth
//
//  Created by Hariharan A on 09/02/21.
//

import Foundation
import UIKit

extension UITableView {
    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)

        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
}
