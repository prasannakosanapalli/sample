//
//  ImageSliderCollectionViewCell.swift
//  MedlineOnBoardSample
//
//  Created by Vijay Guruju on 28/01/21.
//

import UIKit

class MedlineImageSliderCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var bgView : UIView!
    @IBOutlet weak var imgView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //Imageview layout
        imgView.layer.cornerRadius = 10
    }
    
    

}
