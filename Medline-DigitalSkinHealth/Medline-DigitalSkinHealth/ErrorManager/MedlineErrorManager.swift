//
// MedlineErrorHandler.swift
// Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
//

import Foundation

class MedlineErrorModel {
    
    // MARK: - Properties
    var title: String
    var description: String
    
    init(errorTitle: String, errorDescription: String) {
        title = localizedString(errorTitle)
        description = localizedString(errorDescription)
    }
}

enum GenericError: Error {
    case NoNetworkConnection
    case BadAPIRequest
    case InternalServerUnavailable
}


extension GenericError {
    public var error: MedlineErrorModel {
        switch self {
        case .NoNetworkConnection:
            return MedlineErrorModel(errorTitle: "ERR_CONNECTION_TITLE", errorDescription: "ERR_CONNECTION")
        case .InternalServerUnavailable:
            return MedlineErrorModel(errorTitle: "SERVICE_UNAVAILABLE_TITLE", errorDescription: "SERVICE_UNAVAILABLE_MSG")
        case .BadAPIRequest:
            return MedlineErrorModel(errorTitle: "BAD_API_REQUEST", errorDescription: "BAD_API_REQUEST")
        }
    }
}



