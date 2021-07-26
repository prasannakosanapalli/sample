package com.photon.medline.epicModules.dashboard.home.local

import androidx.room.*
import com.photon.medline.epicModules.dashboard.home.model.HomeFragmentResponse


/**
 *Created by Ashutosh Srivastava on 24-03-2021
 * Copyright(c) 2021 Photon.
 */
@Dao
interface HomeFragmentDao {

    @Query("select * from HomeFragmentResponse")
    fun getAll(): HomeFragmentResponse

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(homeFragmentResponse: HomeFragmentResponse)

    @Delete
    suspend fun delete(homeFragmentResponse: HomeFragmentResponse)

    @Query("SELECT COUNT(*) FROM HomeFragmentResponse")
    fun getCount(): Int
}