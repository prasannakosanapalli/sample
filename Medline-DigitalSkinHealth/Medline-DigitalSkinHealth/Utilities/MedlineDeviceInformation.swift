//
//  Device.swift
//  MedlineOnBoardSample
//
//  Created by Vijay Guruju on 05/02/21.
//

import Foundation
import UIKit

public enum Type: String {
    case phone
    case pad
    case pod
    case simulator
    case unknown
}
/// Exact device version
public enum Version: String {
    case phone4
    case phone4S
    case phone5
    case phone5C
    case phone5S
    case phone6
    case phone6Plus
    case phone6S
    case phone6SPlus
    case phoneSE
    case phone7
    case phone7Plus
    case phone8
    case phone8Plus
    case phoneX
    case phoneXS
    case phoneXSMax
    case phoneXR
    case phone11
    case phone11Pro
    case phone11ProMax
    case phoneSE2
    case phone12
    case phone12Pro
    case phone12ProMax
    case phone12Mini

    case pad1
    case pad2
    case padMini
    case pad3
    case pad4
    case pad5
    case pad6
    case pad7
    case padAir
    case padMini2
    case padAir2
    case padMini3
    case padMini4
    case padMini5
    case padAir3
    case padPro9_7
    case padPro12_9
    case padPro12_9_2th
    case padPro10_5
    case padPro11
    case padPro12_9_3th
    case padPro11_2th
    case padPro12_9_4th

    case podTouch1
    case podTouch2
    case podTouch3
    case podTouch4
    case podTouch5
    case podTouch6
    case podTouch7

    case simulator

    case unknown
    
    //MARK:- Screen Size
    /// Return device screen
    ///
    /// - seealso: Screen
    public var screen: Screen {
        switch self {
        case .podTouch1,
             .podTouch2,
             .podTouch3,
             .podTouch4,
             .phone4,
             .phone4S:
            return .inches_3_5
            
        case .podTouch5,
             .podTouch6,
             .podTouch7,
             .phone5,
             .phone5C,
             .phone5S,
             .phoneSE:
            return .inches_4_0
            
        case .phone6,
             .phone6S,
             .phone7,
             .phone8:
            return .inches_4_7
            
        case .phone6Plus,
             .phone6SPlus,
             .phone7Plus,
             .phone8Plus:
            return .inches_5_5

        case .phoneX,
             .phoneXS:
            return .inches_5_8

        case .phoneXR:
            return .inches_6_1

        case .phoneXSMax:
            return .inches_6_5
            
        case .phone11:
            return .inches_6_1
        case .phone11Pro:
            return .inches_5_8
        case .phone11ProMax:
            return .inches_6_5
        case .phoneSE2:
            return .inches_4_7
        case .phone12:
            return .inches_6_1
        case .phone12Pro:
            return .inches_5_8
        case .phone12ProMax:
            return .inches_6_5
        case .phone12Mini:
            return .inches_5_4
            
        case .padMini,
             .padMini2,
             .padMini3,
             .padMini4,
             .padMini5:
            return .inches_7_9
            
        case .pad1,
             .pad2,
             .pad3,
             .pad4,
             .pad5,
             .pad6,
             .padAir,
             .padAir2,
             .padPro9_7:
            return .inches_9_7
        case .pad7:
            return .inches_4_7
            
        case .padPro12_9,
             .padPro12_9_2th,
             .padPro12_9_3th,
             .padPro12_9_4th:
            return .inches_12_9
            
        case .padPro10_5,
             .padAir3:
            return .inches_10_5;
            
        case .padPro11, .padPro11_2th:
            return .inches_11
        case .unknown, .simulator:
            return .unknown
        }
    }
}
   
    /// - parameter unknown:
    /// - parameter inches_3_5:    Representing screens for iPhone 4, 4S
    /// - parameter inches_4_0:    Representing screens for iPhone 5, 5S
    /// - parameter inches_4_7:    Screens for iPhone 6, 6S
    /// - parameter inches_5_5:    Screens for iPhone 6Plus
    /// - parameter inches_7_9:    Screens for iPad Mini
    /// - parameter inches_9_7:    Screens for iPad
    /// - parameter inches_12_9:   Screens for iPad Pro

    public enum Screen: CGFloat {
    case unknown     = 0
    case inches_3_5  = 3.5
    case inches_4_0  = 4.0
    case inches_4_7  = 4.7
    case inches_5_4  = 5.4
    case inches_5_5  = 5.5
    case inches_5_8  = 5.8 // iPhone X diagonal
    case inches_6_1  = 6.1
    case inches_6_5  = 6.5
    case inches_6_7  = 6.7
    case inches_7_9  = 7.9
    case inches_9_7  = 9.7
    case inches_10_2 = 10.2
    case inches_10_5 = 10.5
    case inches_10_9 = 10.9
    case inches_11 = 11.0
    case inches_12_9 = 12.9
        
    //MARK:- Screen size Family
    /// Return screen family
    public var family: ScreenFamily {
        switch self {
        case .inches_3_5, .inches_4_0:
            return .old
            
        case .inches_4_7:
            return .small

        case .inches_5_4, .inches_5_5, .inches_7_9, .inches_5_8, .inches_6_1, .inches_6_5, .inches_6_7:
            return .medium

        case .inches_9_7, .inches_10_2, .inches_10_5, .inches_10_9, .inches_11, .inches_12_9:
            return Device.isLandscape ? .landscape : .big

        case .unknown:
            return .unknown
        }
    }
    }

    /// These parameters are used to groups device screens into 4 groups:
    ///
    /// - parameter unknown:
    /// - parameter old:       In the case Apple stops to produce 3.5 and 4.0 inches devices this will represent it
    /// - parameter small:     Include 4.7 inches iPhone 6 size
    /// - parameter medium:    Include devices with screen resolution 5.5, 7.9 inches (iPhone 6Plus and iPad mini)
    /// - parameter big:       Include devices with biger screen resolutions (Regular iPad and iPad Pro)
    public enum ScreenFamily: String {
        case unknown = "unknown"
        case old     = "old"
        case small   = "small"
        case medium  = "medium"
        case big     = "big"
        case landscape = "landscape"
    }

    //MARK:- Screen size scales
    /// Different types of screen scales
    ///
    /// - parameter x1:
    /// - parameter x2:
    /// - parameter x3:
    /// - parameter unknown:
    public enum Scale: CGFloat, Comparable, Equatable {
        case x1      = 1.0
        case x2      = 2.0
        case x3      = 3.0
        case unknown = 0
    }

    public func ==(lhs: Scale, rhs: Scale) -> Bool {
        guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
        return lhs.rawValue == rhs.rawValue
    }

    public func <(lhs: Scale, rhs: Scale) -> Bool {
        guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
        return lhs.rawValue < rhs.rawValue
    }

    public func >(lhs: Scale, rhs: Scale) -> Bool {
        guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
        return lhs.rawValue > rhs.rawValue
    }

    public func <=(lhs: Scale, rhs: Scale) -> Bool {
        guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
        return lhs.rawValue <= rhs.rawValue
    }

    public func >=(lhs: Scale, rhs: Scale) -> Bool {
        guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
        return lhs.rawValue >= rhs.rawValue
    }

//MARK:- Device Orientation
/// Detecting device state
    extension Device {
    /// Return `true` for landscape interface orientation
    static public var isLandscape: Bool {
        return ( UIApplication.shared.statusBarOrientation == .landscapeLeft
            || UIApplication.shared.statusBarOrientation == .landscapeRight )
    }

    /// Return `true` for portrait interface orientation
    static public var isPortrait: Bool {
        return !Device.isLandscape
    }
    }

    //MARK:- Device
    public struct Device{
        
        // get all device related information
        //Type - iPhone, iPad, iPod, with notch or without notch
        //Screen size and family
        // Current app running device inlcudeing simulator
        //Screen tye - Retina or Normal
    }

//MARK:- Device Screen
    /// Detecting screen properties
    extension Device {

    /// Detect device screen.
    ///
    /// - seealso: Screen
    static public var screen: Screen {
        let size = UIScreen.main.bounds.size
        let height = max(size.width, size.height)

        switch height {
        case 480:
            return .inches_3_5

        case 568:
            return .inches_4_0

        case 667:
            return ( scale == .x3 ? .inches_5_5 : .inches_4_7 )

        case 736:
            return .inches_5_5

        case 812:
            return .inches_5_8

        case 844, 834:
            return .inches_5_4

        case 896:
            return ( scale == .x3 ? .inches_6_5 : .inches_6_1 )
            
        case 926:
            return .inches_6_7

        case 1024:
            switch version {
            case .padMini, .padMini2, .padMini3, .padMini4:
                return .inches_7_9

            default:
                return .inches_9_7
            }        case 1366:
            return .inches_12_9

        default:
            return .unknown
        }
    }


    /// Detect screen resolution scale.
    ///
    /// - Seealso: Scale
    static public var scale: Scale {
        let scale = UIScreen.main.scale

        switch scale {
        case 1.0:
            return .x1

        case 2.0:
            return .x2

        case 3.0:
            return .x3

        default:
            return .unknown
        }
    }

    /// Return `true` for retina displays
    static public var isRetina: Bool {
        return scale > Scale.x1
    }
    }

    /// Work with sizes
    extension Device {
        /* Edit:- made landscaoe as optional for now as per the requirement */
        static public func size<T: Any>(old: T? = nil, small: T, medium: T, big: T,landscape:T? = nil ) -> T {
        let family = Device.screen.family

        switch family {
        case .old:
            return old ?? small
            
        case .small:
            return small

        case .medium:
            return medium

        case .big:
            return big
            
        case  .landscape:
            return landscape ?? big

        case .unknown:
            return medium
        }
    }

    /// Return value for specific screen size. Incoming parameter should be a screen size. If it is not defined
    /// nearest value will be used. Code example:
    ///
    /// ```
    /// let sizes: [Screen:AnyObject] = [
    ///     .inches_3_5: 12,
    ///     .inches_4_0: 13,
    ///     .inches_4_7: 14,
    ///     .inches_9_7: 15
    ///    ]
    /// let exactSize = Device.size(sizes: sizes) as! Int
    /// let _ = UIFont(name: "Arial", size: CGFloat(exactSize))
    /// ```
    ///
    /// After that your font will be:
    /// * 12 for 3.5" inches (older devices)
    /// * 13 for iPhone 5, 5S
    /// * 14 for iPhone 6, 6Plus and iPad mini
    /// * and 15 for other iPads
    ///
    /// - seealso: Screen
    static public func size<T: Any>(sizes: [Screen : T]) -> T? {
        let screen = Device.screen
        var nearestValue: T?
        var distance = CGFloat.greatestFiniteMagnitude

        for (key, value) in sizes {
            // Prevent from iterating whole array
            if (key == screen) {
                return value
            }

            let actualDistance = abs(key.rawValue - screen.rawValue)
            if actualDistance < distance {
                nearestValue = value
                distance = actualDistance
            }
        }

        return nearestValue
    }
    }

extension Device {
    
    /// Return raw device version code string or empty string if any problem appears.
    static public var versionCode: String {
        var systemInfo = utsname()
        uname(&systemInfo)

        if  let info = NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue),
            let code = String(validatingUTF8: info.utf8String!) {
            return code
        }

        return ""
    }

    /// Return device type
    ///
    /// - seealso: Type
    static public var type: Type {
        let versionCode = Device.versionCode
        if versionCode.starts(with: "iPhone") {
            return .phone
        } else if versionCode.starts(with: "iPad") {
            return .pad
        } else if versionCode.starts(with: "iPod") {
            return .pod
        } else if versionCode == "i386" || versionCode == "x86_64" {
            return .simulator
        }
        return .unknown
    }

    /// Return `true` for iPad-s
    static public var isPad: Bool {
        return ( UIDevice.current.userInterfaceIdiom == .pad )
    }

    /// Return `true` for iPhone-s
    static public var isPhone: Bool {
        return !isPad
    }

    /// Return `true` for iPhoneX
    @available(*, deprecated, message: ".isPhoneX deprecated. Use .isNotched instead")
    static public var isPhoneX: Bool {
        return isPhone && screen == .inches_5_8
    }

    /// Return `true` for iPadPro
    static public var isPadPro: Bool {
        return isPad && screen == .inches_12_9
    }

    /// Return `true` for Simulator
    static public var isSimulator: Bool {
        return type == .simulator
    }

    /// Return `true` if device has a notch
    static public var isNotched: Bool {
        return isPhone && (screen == .inches_5_8 || screen == .inches_6_1 || screen == .inches_6_5 || screen == .inches_5_4 || screen == .inches_5_5 || screen == .inches_6_7)
    }
    
    // MARK: Version

    static public var version: Version {
        let versionCode = Device.versionCode

        switch versionCode {
        // Phones
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            return .phone4

        case "iPhone4,1", "iPhone4,2", "iPhone4,3":
            return .phone4S

        case "iPhone5,1", "iPhone5,2":
            return .phone5

        case "iPhone5,3", "iPhone5,4":
            return .phone5C

        case "iPhone6,1", "iPhone6,2":
            return .phone5S

        case "iPhone7,2":
            return .phone6

        case "iPhone7,1":
            return .phone6Plus

        case "iPhone8,1":
            return .phone6S

        case "iPhone8,2":
            return .phone6SPlus

        case "iPhone8,4":
            return .phoneSE

        case "iPhone9,1", "iPhone9,3":
            return .phone7

        case "iPhone9,2", "iPhone9,4":
            return .phone7Plus

        case "iPhone10,1", "iPhone10,4":
            return .phone8

        case "iPhone10,2", "iPhone10,5":
            return .phone8Plus

        case "iPhone10,3", "iPhone10,6":
            return .phoneX

        case "iPhone11,2":
            return .phoneXS

        case "iPhone11,4", "iPhone11,6":
            return .phoneXSMax

        case "iPhone11,8":
            return .phoneXR
            
        case "iPhone12,1":
            return .phone11
        case "iPhone12,3":
            return .phone11Pro
        case "iPhone12,5":
            return .phone11ProMax
        case "iPhone12,8":
            return .phoneSE2

        // Pads
        case "iPad1,1":
            return .pad1

        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
            return .pad2

        case "iPad3,1", "iPad3,2", "iPad3,3":
            return .pad3

        case "iPad3,4", "iPad3,5", "iPad3,6":
            return .pad4
            
        case "iPad6,11", "iPad6,12":
            return .pad5
            
        case "iPad4,1", "iPad4,2", "iPad4,3":
            return .padAir

        case "iPad5,3", "iPad5,4":
            return .padAir2

        case "iPad2,5", "iPad2,6", "iPad2,7":
            return .padMini

        case "iPad4,4", "iPad4,5", "iPad4,6":
            return .padMini2

        case "iPad4,7", "iPad4,8", "iPad4,9":
            return .padMini3

        case "iPad5,1", "iPad5,2":
            return .padMini4

        case "iPad6,3", "iPad6,4":
            return .padPro9_7
            
        case "iPad6,7", "iPad6,8":
            return .padPro12_9
            
        case "iPad7,1", "iPad7,2":
            return .padPro12_9_2th
            
        case "iPad7,3", "iPad7,4":
            return .padPro10_5
            
        case "iPad7,5", "iPad7,6":
            return .pad6
            
        case "iPad7,11", "iPad7,12":
            return .pad7
            
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":
            return .padPro11
            
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":
            return .padPro12_9_3th
            
        case "iPad8,9", "iPad8,10":
            return .padPro11_2th
            
        case "iPad8,11", "iPad8,12":
            return .padPro12_9_4th
            
        case "iPad11,1", "iPad11,2":
            return .padMini5
            
        case "iPad11,3", "iPad11,4":
            return  .padAir3
            
        // Pods
        case "iPod1,1":
            return .podTouch1

        case "iPod2,1":
            return .podTouch2

        case "iPod3,1":
            return .podTouch3

        case "iPod4,1":
            return .podTouch4

        case "iPod5,1":
            return .podTouch5

        case "iPod7,1":
            return .podTouch6
        case "iPod9,1":
            return .podTouch7

        // Simulator
        case "i386", "x86_64":
            return .simulator

        // Unknown
        default:
            return .unknown
        }
    }
}
