package com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model

import androidx.room.Entity
import androidx.room.PrimaryKey

/**
 * Login response payload
 * created by pavani on 05/03/2021
 */
@Entity
data class LoginResponse(
    @PrimaryKey(autoGenerate = true)
    val id: Int,
    val status: String,
    val message: String?,
    val data: Data?
)

data class Data(
    val token: String?,
    val lastLogOn: String?
)






