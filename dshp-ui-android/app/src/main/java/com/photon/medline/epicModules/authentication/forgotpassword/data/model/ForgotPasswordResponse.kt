package com.photon.medline.epicModules.authentication.forgotpassword.data.model

import androidx.room.Entity

/**
 *Created by Vishal S. on 11/3/2021.
 * Response from the api call of Forgot Password
 */
@Entity
data class ForgotPasswordResponse(
    val statusCode: String,
    val data: String,
    val message: String
)