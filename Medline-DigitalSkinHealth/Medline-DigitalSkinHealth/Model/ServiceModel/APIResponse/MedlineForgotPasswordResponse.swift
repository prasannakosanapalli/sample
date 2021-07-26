//
//  MedlineForgotPasswordResponse.swift
//  Medline-DigitalSkinHealth
//
//  Created by Indela Venkata Mahesh Reddy on 09/03/21.
//

import Foundation

// MARK: - MedlineForgotPasswordResponse
struct MedlineForgotPasswordResponse : Codable {
    let status : String?
    let data : ForgotPasswordResponseData?
    let message : String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent(ForgotPasswordResponseData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
    
    struct ForgotPasswordResponseData : Codable {
        
    }
}
