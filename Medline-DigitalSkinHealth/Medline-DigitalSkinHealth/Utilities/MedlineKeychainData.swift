//
//  MedlineKeychainData.swift
//  Medline-DigitalSkinHealth
//
//  Created by Sunil Kumar Jaiswal on 19/02/21.
//

import Foundation
import KeychainSwift

class MedlineKeychainData {
    
    private static let appUserMobileUniqueIDKey:String = "appUserMobileUniqueIDKey"
    private static let appUserLoginTokenKey:String = "appUserLoginTokenKey"
    
    open class func retrieveMobileUniqueIDKey() -> String {
        let keychain = KeychainSwift()
        var retrieveUDID:String? = ""
        if let retrieveValue = keychain.get(appUserMobileUniqueIDKey){
            retrieveUDID = retrieveProperString(retrieveString: retrieveValue)
            print("Device UDID - \(retrieveUDID ?? "")")
        }
        
        if retrieveProperString(retrieveString: retrieveUDID) == "" {
            if let udid = UIDevice.current.identifierForVendor?.uuidString {
                print(udid)
                retrieveUDID = retrieveProperString(retrieveString: udid)
                keychain.set(retrieveProperString(retrieveString:retrieveUDID ?? ""), forKey: appUserMobileUniqueIDKey)
            }else{
                retrieveUDID = retrieveProperString(retrieveString: retrieveUniqueString())
                keychain.set(retrieveProperString(retrieveString:retrieveUDID ?? ""), forKey: appUserMobileUniqueIDKey)
            }
        }
        return retrieveUDID ?? ""
    }
    
    //Store login token in keychain
    open class func storeUserLoginToken(token:String?) {
        let keychain = KeychainSwift()
        keychain.set(retrieveProperString(retrieveString:token ?? ""), forKey: appUserLoginTokenKey)
    }
    
    //Fetch login token from keychain
    open class func retrieveUserLoginToken() -> String {
        var retrieveToken:String? = ""
        let keychain = KeychainSwift()
        if let retrieveValue = keychain.get(appUserLoginTokenKey) {
            retrieveToken = retrieveProperString(retrieveString: retrieveValue)
        }
        return retrieveToken ?? ""
    }
    
    //Delete login token from keychain
    open class func deleteUserLoginToken(token:String?) -> Bool {
        let keychain = KeychainSwift()
        let retrieveToken = token
        if (retrieveToken != "") {
            keychain.delete(retrieveToken!)
            return true
        }
        else {
            return false
        }
    }
}
