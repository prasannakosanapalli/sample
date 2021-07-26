//
//  Common.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit
import Alamofire

/// Font Family with custom font files
struct FontFamily {
    static let kBold = "Roboto-Bold"
    static let kRegular = "OpenSans"
}


/// Method is used to get device type
func isDeviceTypeIPad() -> Bool {
    var isIPad:Bool = false
    if UIDevice.current.userInterfaceIdiom == .pad {
        isIPad = true
    }
    return isIPad
}

/// Method is used to return the story board name

/// - Returns: Story board name

func retrieveStoryboardName() -> String {
    if isDeviceTypeIPad() {
        return StoryboardType.ipad
    } else {
        return StoryboardType.iphone
    }
}

// Check Network reachablility
func isConnectedToInternet() ->Bool {
    return NetworkReachabilityManager()!.isReachable
}

// method is used to check range 
func checkRange(_ range: NSRange, contain index: Int) -> Bool {
    return index > range.location && index < range.location + range.length
}

/// Method is used to get actual string from Localized String
/// - Parameter value: key string 
/// - Returns: actual string
func localizedString(_ value: String) -> String {
    return NSLocalizedString(value, comment: "")
}

func setRegularFont(font_size: CGFloat) -> UIFont {
    return UIFont(name: "OpenSans-Regular", size: font_size) ?? UIFont.systemFont(ofSize: font_size)
}

func setSemiboldFont(font_size:CGFloat) -> UIFont {
    return  UIFont(name: "OpenSans-SemiBold", size: font_size) ?? UIFont.systemFont(ofSize: font_size, weight: .semibold)
}

func setBoldFont(font_size:CGFloat) ->UIFont {
    return UIFont(name: "OpenSans-Bold", size: font_size) ?? UIFont.systemFont(ofSize: font_size, weight: .bold)
}

func setGloberBoldFont(font_size:CGFloat) ->UIFont {
    return UIFont(name: "Glober-Bold", size: font_size) ?? UIFont.systemFont(ofSize: font_size, weight: .bold)
}

func retrieveProperString(retrieveString:Any?) -> String {
    var proper_string: String? = ""
    do{
        try proper_string = returnProperString(object: retrieveString)
    }catch{
        proper_string = ""
    }
    return proper_string!
}

func returnProperString(object:Any?) throws -> String {
    var proper_string: String? = ""
    if (object == nil || object is NSNull){
        proper_string = ""
    }else{
        if let object_type_string = object as? String {
            if (object_type_string.caseInsensitiveCompare("(null)") == ComparisonResult.orderedSame || object_type_string.caseInsensitiveCompare("<null>") == ComparisonResult.orderedSame){
                proper_string = ""
            } else {
                proper_string = object_type_string.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }else{
            proper_string = ""
        }
    }
    return proper_string!
}

func retrieveUniqueString() -> String{
    let uuid = UUID().uuidString
    return uuid
}

/// Function to enable the print only in development environment
/// - Parameters:
///   - items: Default items
///   - separator: Default separator
///   - terminator: Default terminator
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    let isLoggingEnabled = Environment.configuration(EnvKey.isLoggingEnabled)
    if isLoggingEnabled == "YES" {
        Swift.print(items)
    }
}
