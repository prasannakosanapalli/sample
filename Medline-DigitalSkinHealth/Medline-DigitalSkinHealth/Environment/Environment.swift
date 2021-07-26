//
//  BuildConfiguration.swift
//  MultiSchemeProject
//
//  Created by Prashant Telangi on 11/13/18.
//  Copyright © 2018 Mobisoft Infotech. All rights reserved.
//

import Foundation

public enum EnvKey {
    
    case productName
    case productVersion
    case baseUrl
    case subscriptionKey
    case isLoggingEnabled
    case userActivationURL
    case userPasswordResetURL
    
    func value() -> String {
        switch self {
        case .productName:
            return "CFBundleName"
        case .productVersion:
            return "CFBundleShortVersionString"
        case .baseUrl:
            return "BaseURL"
        case .subscriptionKey:
            return "SubscriptionKey"
        case .isLoggingEnabled:
            return "IsLoggingEnabled"
        case .userActivationURL:
            return "UserActivationURL"
        case .userPasswordResetURL:
            return "UserPasswordResetURL"
    }
    }
}

public struct Environment {
    static func configuration(_ key: EnvKey) -> String {
        if let infoDict = Bundle.main.infoDictionary {
            switch key {
            case .productName:
                return infoDict[EnvKey.productName.value()] as? String ?? ""
            case .productVersion:
                return infoDict[EnvKey.productVersion.value()] as? String ?? ""
            case .baseUrl:
                return (infoDict[EnvKey.baseUrl.value()] as? String)?.replacingOccurrences(of: "\\", with: "") ?? ""
            case .subscriptionKey:
                return infoDict[EnvKey.subscriptionKey.value()] as? String ?? ""
            case .isLoggingEnabled:
                return infoDict[EnvKey.isLoggingEnabled.value()] as? String ?? ""
            case .userActivationURL:
                return (infoDict[EnvKey.userActivationURL.value()] as? String)?.replacingOccurrences(of: "\\", with: "") ?? ""
            case .userPasswordResetURL:
                return (infoDict[EnvKey.userPasswordResetURL.value()] as? String)?.replacingOccurrences(of: "\\", with: "") ?? ""
            }
        } else {
            fatalError("Unable to locate plist file")
        }
    }
}
