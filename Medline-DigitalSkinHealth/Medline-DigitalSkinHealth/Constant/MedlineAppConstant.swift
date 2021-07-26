//
//  AppConstant.swift
//  MedLine-SkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
//

import Foundation
import UIKit

let kSnapshotViewTag = 111
let kOkay = "OK"

///App Constants
struct MedlineAppConstant {
    static let kError = "Error"
    static let kImageCollectionViewCellId = "MedlineImageSliderCollectionViewCell"
    static let kCardViewCollectionViewCellId = "MedlineCardViewCollectionViewCell"
    static let kSearchTextField = "searchField"
    static let kChipCollectionVieCellId = "MedlineChipCollectionViewCell"
    static let kDropDownCellId = "DropDownCell"
    static let kUseAnotherAccount = "Use another account"
    static let kDropdownRowHeight = 49
    static let kDropdownFooterHeight = 52
    static let kDropdownXPosition = 37
    static let kDropdownShadowXPosition = 5
    static let kDropdownShadowYPosition = 3
    static let kDropdownShadowBlur = 7
    static let kDropdownShadowSpread = 0
    static let kWebPageTopSpace = CGFloat(175)
    static let kLogout = "Logout"
}

///Asset Constants
struct MedlineAssetConstant {
    static let kDot = "dot"
    static let kNotification = "notification"
    static let kMenu = "more"
    static let kBarcode = "barcode"
    static let kSample_0 = "sample_0"
    static let kSample_1 = "sample_1"
    static let kSample_2 = "sample_2"
    static let kSample_3 = "sample_3"
    static let kPlus = "iconsPlus"
    static let kCircle = "circle"
    static let kTickmark = "iconsTick"
    static let kDropdown = "dropdown"
    static let kBack = "back"
    static let kBackIpad = "back_ipad"
    static let kHeaderLogo = "header_logo"
    static let kHeaderLogoIpad = "header_logo_ipad"
}

///CardView title constants
struct MedlineCardViewTitleConstants {
    static let kProductSelectors = "Product Selector"
    static let kEducationalResources = "Education Resources"
    static let kWoundManagement = "Wound Management"
}

///TabBar Items Constants
struct MedlineTabBarItemsConstant {
    static let kHome = "Home"
    static let kFormulary = "Formulary"
    static let kFindCare = "Find Care"
    static let kFeedback = "Feedback"
    static let kHotline = "Hotline"

}

///Storyboard Id Constants
struct MedlineStoryboardIDConstant {
    static let kHomeViewControllerID = "MedlineHomeVC"
    static let kNotificationViewControllerID = "MedlineNotificationVC"
    static let kMenuViewControllerID = "MedlineMenuVC"
    static let kFormularyViewControllerID = "MedlineFormularyVC"
    static let kFindCareViewControllerID = "MedlineFindCareVC"
    static let kFeedbakViewControllerID = "MedlineFeedbackVC"
    static let kHotlineViewControllerID = "MedlineHotlineVC"
    static let kResetPasswordViewControllerID = "MedlineResetPasswordVC"
    static let kRegistrationViewControllerID = "MedlineRegisterAccountVC"
    static let kForgotPasswordViewControllerID = "MedlineForgotPasswordVC"
    static let kWebContentViewControllerID = "MedlineWebContentVC"
    static let kFullScreenMessageViewControllerID = "MedlineFullScreenMessageViewController"
    static let kSuccessViewControllerID = ""
    static let kLoginViewControllerID = "MedlineLoginVC"

}

struct MedlineColor {
    static let kBlueMedline = "medline_theme"
    static let kNewUserButton = "NewUserButton"
    static let kDropdownSeperator = "dropdown_seperator"
    static let kBorderColor = "gray_border"
    static let kDropdownButtonBorder = "dropdown_shadow"
    static let kDropdownUnselected = "dropdown_unselected_text"
    static let kBlackShade = "black_shade"
    static let kGreenSuccess = "green_success"
    static let kGrayedOut = "disabled_grayedout"
    static let kRedError = "red_error"
    static let kPlaceholderTextColor = "placeholder_text"
    static let kWhiteButtonBorderColor = "white_button_border"
}

struct StoryboardType {
    static let iphone = "Main"
    static let ipad = "Main_iPad"
}
struct NibName {
    static let iphone = "MedlinePasswordValidationView"
    static let ipad = "MedlinePasswordValidationView_iPad"
}
struct DeviceType {
    static let iOS = "ios"
}

struct Color {
    static let appColor:CUnsignedLongLong = 0x0053CC
    static let screenTextColor:CUnsignedLongLong = 0x333333
    
    static let whiteColor:CUnsignedLongLong = 0xFFFFFF
    static let grayColor:CUnsignedLongLong = 0x808080
    static let blackColor:CUnsignedLongLong = 0x000000
    static let redColor:CUnsignedLongLong = 0xDE350B
    static let greenColor:CUnsignedLongLong = 0x36B37E
    static let tAndPColor:CUnsignedLongLong = 0x0052CC
    
    static let buttonBackgroundColor:CUnsignedLongLong = 0x0052CC
    static let buttonBorderColor:CUnsignedLongLong = 0x000000
    static let flatButtonTextColor:CUnsignedLongLong = 0x333333
    
    static let medlineMaterialTextFieldPlaceHolderColor:CUnsignedLongLong = 0x505F79
    static let medlineMaterialTextFieldBorderColor:CUnsignedLongLong = 0xC1C7D0
    static let medlineMaterialTextFieldText:CUnsignedLongLong = 0x333333
}

struct FontSizes {
    static let fontSizeTen: CGFloat = 10.0
    static let fontSizeEleven: CGFloat = 11.0
    static let fontSizeTwelve: CGFloat = 12.0
    static let fontSizeThirteen: CGFloat = 13.0
    static let fontSizeFourteen: CGFloat = 14.0
    static let fontSizeFifteen: CGFloat = 15.0
    static let fontSizeSixteen: CGFloat = 16.0
    static let fontSizeSeventeen: CGFloat = 17.0
    static let fontSizeEighteen: CGFloat = 18.0
    static let fontSizeNineteen: CGFloat = 19.0
    static let fontSizeTwenty: CGFloat = 20.0
    static let fontSizeTwentyOne: CGFloat = 21.0
    static let fontSizeTwentyTwo: CGFloat = 22.0
    static let fontSizeTwentyThree: CGFloat = 23.0
    static let fontSizeTwentyFour: CGFloat = 24.0
    static let fontSizeTwentyFive: CGFloat = 25.0
    static let fontSizeTwentyEight: CGFloat = 28.0
    static let fontSizeThirtyOne: CGFloat = 31.0
}

struct FontType {
    static let regular: String = "REGULAR"
    static let semibold: String = "SEMIBOLD"
    static let bold: String = "BOLD"
}

struct KeyboardType {
    static let string: String = "STRING"
    static let number: String = "NUMBER"
    static let mobile: String = "MOBILE"
    static let email: String = "EMAIL"
    static let lowerCase: String = "LOWER_CASE"
    static let upperCase: String = "UPPER_CASE"
    static let titleCase: String = "TITLE_CASE"
}

struct BooleanTypeInInteger {
    static let zero: Int = 0
    static let one: Int = 1
    static let two: Int = 2
    static let three: Int = 3
    static let nintynine: Int = 99
}

struct Opacity {
    static let zeroPointTen: Float = 0.10
    static let zeroPointTwenty: Float = 0.20
    static let zeroPointThirty: Float = 0.30
    static let zeroPointFourty: Float = 0.40
    static let zeroPointFifty: Float = 0.50
    static let zeroPointSixty: Float = 0.60
    static let zeroPointSeventy: Float = 0.70
    static let zeroPointEighty: Float = 0.80
    static let zeroPointNinty: Float = 0.90
    static let onePointZero: Float = 1.0
}

struct CornerRadius {
    static let thirty: CGFloat = 30.0
    static let fourtyTwo: CGFloat = 42.0

}

struct BorderThickness {
    static let pointFiveZero: CGFloat = 0.5
    static let onePointZero: CGFloat = 1.0
    static let twoPointZero: CGFloat = 2.0
}

struct AppAlertTextBreak {
    static let titleBreak: Int = 26
    static let messageBreak: Int = 46
}

struct DefaultCountry {
    static let defaultCountryName:String = "India"
    static let defaultCountryDialCode:String = "+91"
}

struct MedlineRegex {
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
    static let phoneNumberRegex = "(\\([0-9]{3}\\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}"
}

struct MedlinePasswordRegex {
    static let minimumEightCharactersRegex = ".{8,}"
    static let oneSpecialCharacterRegex = ".*[@$!%*?&#]+.*"
    static let oneNumberRegex = ".*[0-9]+.*"
    static let oneUpperCaseRegex = ".*[A-Z]+.*"
}

struct MedlineWebPageURL {
    static let medlinePrivacyPolicyURL = "https://www.medline.eu/privacy-declaration"
    static let medlineTermAndConditionURL = "https://www.medline.eu/terms-of-use"
}

struct AppButtonTitle {
    static let okButton:String = "OK"
    static let cancelButton:String = "CANCEL"
}

