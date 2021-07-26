//
//  MedlineResetPasswordResponse.swift
//  Medline-DigitalSkinHealth
//
//  Created by Sunil Kumar Jaiswal on 09/03/21.
//

import Foundation

// MARK: - MedlineResetPasswordResponse
struct MedlineResetPasswordResponse : Codable {
    let status : String?
    let data : ResetPasswordResponseData?
    let message : String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent(ResetPasswordResponseData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
    
    struct ResetPasswordResponseData : Codable {
        
    }
}



