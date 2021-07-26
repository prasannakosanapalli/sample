package com.photon.medline.epicModules.dashboard.home.model

import androidx.annotation.NonNull
import androidx.room.Entity
import androidx.room.PrimaryKey


/**
 *Created by Ashutosh Srivastava on 24-03-2021
 * Copyright(c) 2021 Photon.
 */
@Entity
data class HomeFragmentResponse(
    @NonNull
    @PrimaryKey(autoGenerate = true)
    val id: Int,
    val message: String,
    val data: String?,
    val status: String
)