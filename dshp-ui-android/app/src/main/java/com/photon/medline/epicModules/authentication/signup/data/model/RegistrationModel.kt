package com.photon.medline.epicModules.authentication.signup.data.model

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.photon.medline.utilities.Constants

/**
 *Created by Vishal
 * Model class to store registration screen fields data entered by user
 */
@Entity
data class RegistrationModel(
    var firstName: String = "",
    var lastName: String = "",
    var customerNumber: String = "",
    var phone: String = "",
    @PrimaryKey
    var email: String = "",
    var password: String = "",
    var confirmPassword: String = "",
    var userType: String = "",
    var isPrivacyPolicyAgreed: Int = 0,
    var isTermsAndConditionAgreed: Int = 0,
    var useractivationURL: String = ""
) {
    constructor() :
            this(
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                Constants.INT_ADMIN,
                0,
                0,
                Constants.USER_ACTIVATION

            )
}