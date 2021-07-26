//
//  MedlineCardViewCollectionViewCell.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
// 

import UIKit

class MedlineCardViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: MedlineLabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backView.layer.borderWidth = 0.5
        self.backView.layer.borderColor = UIColor.gray.cgColor
        self.backView.layer.cornerRadius = 5
    }
    
}
