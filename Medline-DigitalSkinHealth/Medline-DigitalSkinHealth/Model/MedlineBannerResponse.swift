//
//  MedlineModelSample.swift
//  MedlineOnBoardSample
//
//  Created by Vijay Guruju on 29/01/21.
//

import Foundation
import UIKit


///Images data for Banner
struct MedlineData{
    
    static let images = [UIImage(named: MedlineAssetConstant.kSample_0),UIImage(named: MedlineAssetConstant.kSample_1),UIImage(named:MedlineAssetConstant.kSample_2),UIImage(named: MedlineAssetConstant.kSample_3)]
}

///Tabbar items data
class TabBarItem {
    var itemTitle:String
    var itemImage:String
    var storyBoardId:String
    
    init(itemTitle:String,itemImage:String,storyBoardId:String) {
        self.itemTitle = itemTitle
        self.itemImage = itemImage
        self.storyBoardId = storyBoardId
    }
}

/// Card view data
class CardViewData {
    var title:String
    
    init(title:String) {
        self.title = title
    }
}

///Chip view data
class ChipViewData {
    var chipTitle:String
    
    init(title:String) {
        self.chipTitle = title
    }
}
