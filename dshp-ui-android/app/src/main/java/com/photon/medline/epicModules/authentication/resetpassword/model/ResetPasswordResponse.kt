package com.photon.medline.epicModules.authentication.resetpassword.model

import androidx.annotation.NonNull
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class ResetPasswordResponse(
    @NonNull
    @PrimaryKey(autoGenerate = true)
    val id: Int,
    val message: String,
    val data: String?,
    val status: String
)
