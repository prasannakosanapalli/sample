package com.photon.medline.epicModules.authentication.resetpassword.model

/**
 * Created by Romesh
 * Its login payload class using to handle the values to post to server while hit the login api.
 */
data class ResetPasswordRequest(
    var password: String,
    var confirmPassword: String,
    var token: String,
    var email: String
) {
    constructor() : this("", "", "", "")
}
