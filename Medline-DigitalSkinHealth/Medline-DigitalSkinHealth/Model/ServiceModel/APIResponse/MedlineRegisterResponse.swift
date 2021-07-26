//
//  MedlineRegisterResponse.swift
//  Medline-DigitalSkinHealth
//
//  Created by Hariharan A on 08/03/21.
//

import Foundation

// MARK: - MedlineRegisterResponse
struct MedlineRegisterResponse: Codable {
    let status: String?
    let data : MedlineRegisterResponseData?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent(MedlineRegisterResponseData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

    struct MedlineRegisterResponseData : Codable {

    }
}


