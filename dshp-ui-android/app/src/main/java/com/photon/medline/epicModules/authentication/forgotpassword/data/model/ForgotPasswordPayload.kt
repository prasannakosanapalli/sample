package com.photon.medline.epicModules.authentication.forgotpassword.data.model

import com.photon.medline.utilities.Constants.FORGOT_PASSWORD_REQ_CODE
import com.photon.medline.utilities.Constants.RESET_URL

/**
 *Created by Vishal on 11/3/2021.
 * Its Forgot Password payload class using to handle the values to post to server while hit the Forget password api.
 */
data class ForgotPasswordPayload(
    var email: String,
    var userPasswordResetURL: String,
    var isResendRequest: Int
) {
    constructor() : this("", RESET_URL, FORGOT_PASSWORD_REQ_CODE)
}
