//
//  MedlineChipCollectionViewCell.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
// 

import UIKit

class MedlineChipCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleLabel.layer.borderWidth = 1.0
        self.titleLabel.layer.borderColor = UIColor.gray.cgColor
    }
}
