package com.photon.medline.epicModules.authentication.signup.data.model

import androidx.annotation.NonNull
import androidx.room.Entity
import androidx.room.PrimaryKey

/**
 * Sign up response
 *
 * @property password
 * @constructor Create empty Sign up response
 */
@Entity
data class SignUpResponse(
    @NonNull
    @PrimaryKey(autoGenerate = true)
    val id: Int,
    val additionalInfo: String?,
    val api: String,
    val message: String,
    val response: String?,
    val status: String

)




