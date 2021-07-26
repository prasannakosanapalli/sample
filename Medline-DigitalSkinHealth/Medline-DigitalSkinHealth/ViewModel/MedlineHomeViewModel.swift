//
//  MedlineHomeViewModel.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
// 

import Foundation

class MedlineHomeViewModel {
    
    var carViewData : [CardViewData]
    var chipsData : [ChipViewData]
    
    init() {
        self.carViewData = [CardViewData(title:MedlineCardViewTitleConstants.kProductSelectors ),CardViewData(title:MedlineCardViewTitleConstants.kEducationalResources ),CardViewData(title:MedlineCardViewTitleConstants.kWoundManagement)]
        
        self.chipsData = [ChipViewData(title: "Quote an OR Pad"),ChipViewData(title: "Wound Measure"),ChipViewData(title: "Mini Nutritional Assesment"),ChipViewData(title: "Malnutrition Screening Tool"),ChipViewData(title: "Impact of Malnutrition"),ChipViewData(title: "Protien Needs Calculator")]
    }
}
