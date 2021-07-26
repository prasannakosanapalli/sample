//
//  MedlineLoginResponse.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
//

import Foundation

// MARK: - Medline Login Response
struct MedlineLoginResponse: Codable {
    let status: String?
    let message: String?
    let data : MedlineLoginResponseData?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent(MedlineLoginResponseData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
    
    // MARK: - Response
    struct MedlineLoginResponseData : Codable {
        let token: String
        let lastLogOn: String?
    }
}

