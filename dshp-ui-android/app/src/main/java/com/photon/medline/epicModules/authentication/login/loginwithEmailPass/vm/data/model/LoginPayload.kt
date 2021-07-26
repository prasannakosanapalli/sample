package com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model

/**
 * Created by Romesh
 * Its login payload class using to handle the values to post to server while hit the login api.
 */
data class LoginPayload(var Email: String, var Password: String) {
    constructor() : this("", "")
}
