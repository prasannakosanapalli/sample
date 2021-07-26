package com.photon.medline.utilities

/**
 *Created by PAVANI P on 25/2/2021.
 * Here all constants we have defined for unit testings, don't use any other class for this.
 */
const val EMAIL = "user@photon.in"
const val PASSWORD = "Medline@123"
const val CONFIRM_PASSWORD = "Medline@123"
const val FIRST_NAME = "Medline"
const val LAST_NAME = "Health"
const val USER_TYPE = "IntAdmin"
const val CUSTOMER_NUMBER = "1410792"
const val PHONE = "8130616106"
const val FORGET_PASSWORD_TOKEN = "SlkhGQOVPQtmTyTKu83loP2S7pzI1Wkoh5uZRtdbE+A="
const val EMAIL_ID = "ashutoshshrivas@photon.in"
const val RESET_URL = "https://devdshpapiservice.azure-api.net/Dev-DSHP-API/resetpassword"

/**
 * constants for Valid Email Testing
 */
const val BLANK_EMAIL = ""
const val BLANK_PASSWORD = ""
const val INVALID_EMAIL_1 = "user_medline.in"
const val INVALID_EMAIL_2 = "user@medlinein"
const val VALID_EMAIL = "user@medline.in"

/**
 * constants for Valid Password Testing
 */
const val INVALID_PASSWORD_1 = "medline@12345"
const val INVALID_PASSWORD_2 = "Medline12345"
const val INVALID_PASSWORD_3 = "Medline@@@@"
const val INVALID_PASSWORD_4 = "Med@123"
const val INVALID_PASSWORD_5 = "Medline@1"
const val PRODUCT_NAME_1 = "Product Selector"
const val PRODUCT_NAME_2 = "Education Resources"
const val PRODUCT_NAME_3 = "Wound Management"

/**
 * API TESTING
 */
const val VALID_EMAIL_LOGIN = "pichukapavanivi@photon.in"
const val VALID_PASSWORD_LOGIN = "Pavani@123"
const val INVALID_PASSWORD_LOGIN = "Pavani@1234"
const val INVALID_EMAIL_LOGIN = "pavani@photon.in"
const val OK_STATUS_CODE = "200"
const val UNAUTHORISED_STATUS_CODE = "401"
const val NOT_FOUND_STATUS_CODE = "404"
const val UNAUTHORISED_STATUS_MESSAGE = "Unauthorized"
const val UNAUTHORISED_STATUS_ERROR = "Unauthorized access."
const val NOT_FOUND_STATUS_MESSAGE = "Not Found"
const val NOT_FOUND_ERROR_MESSAGE = "User not found or inActive."
const val REGISTER_USER_ERROR = "Customer not found for this user or customer is inActive."
const val OK_STATUS_MESSAGE = "OK"
const val BADREQUEST_ERROR = "Bad Request"
const val BADREQUEST_ERROR_MESSAGE =
    "User request is invalid or the attributes does not have values, verify the request data."
const val RESOURCE_NOT_FOUNE = "Resource not found"
const val PASSWORD_ALREADY_COMPLETED = "password reset completed already."
const val BADREQUEST_CODE = "400"
const val CONFLICT_CODE = "409"
const val CONFLICT_ERROR = "Conflict"
const val RESOURCE_NOT_FOUND_CODE = "404"
const val RESOURCE_NOT_FOUND_ERROR = "Resource Not Found"
const val RESOURCE_NOT_FOUND_MESSAGE = "Resource not found"
const val RESEND_REQUEST = 1
const val HEADER_KEY = "Ocp-Apim-Subscription-Key"
const val LOGIN_WRONG_ENDPOINT = "https://qadshpapiservice.azure-api.net/QA-DSHP-API/userlogin1/"
const val FORGOT_RESEND_VALID_EMAIL = "pichukapavanivi@Photon.in"
const val FORGOT_PENDING_REQUEST_MESSAGE = "A active password reset request already pending."
const val FORGOT_VALID_EMAIL = "sukatevishalvij@photon.in"
const val BLANK_URL = ""
const val FORGOT_PASSWORD_WRONG_ENDPOINT =
    "https://devdshpapiservice.azure-api.net/Dev-DSHP-API/forgotpassword1/"
const val LOGIN_NOT_FOUND_ERROR_MESSAGE = "User not found or inactive."