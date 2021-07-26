//
//  MedlinePinViewModel.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
// 

import Foundation

class MedlinePinViewModel {
    
    var pinNumber1 : String
    var pinNumber2 : String
    var pinNumber3 : String
    var pinNumber4 : String
    
    init(pin1:String,pin2:String,pin3:String,pin4:String) {
        self.pinNumber1 = pin1
        self.pinNumber2 = pin2
        self.pinNumber3 = pin3
        self.pinNumber4 = pin4
    }
    
    
    //Validation for empty field
    func isValid() -> Bool {
        
        if (pinNumber1.isNotEmpty() && pinNumber2.isNotEmpty() && pinNumber3.isNotEmpty() && pinNumber4.isNotEmpty()) {
            return true
        } else {
            return false
        }
    
    }
    
}
