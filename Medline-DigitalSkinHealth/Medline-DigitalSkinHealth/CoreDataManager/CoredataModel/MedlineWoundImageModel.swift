//
//  MedlineWoundImageModel.swift
//  Medline-DigitalSkinHealth
//
//  Created by Sunil Kumar Jaiswal on 22/02/21.
//

import Foundation

struct MedlineWoundImageModel {
    var isUploadedOnServer: Int16 = 0
    var imageCaptureDateTime: Int64 = 0
    var imageID: Int64 = Int64(MedlineAppUtils.retrieveUniqueNumber())
    var imageStayInLocalUpToDateTime: Int64 = 0
    var imageUploadedOnServerDateTime: Int64 = 0
    
    var userID: String? = nil
    var woundImage: Data? = nil
}
