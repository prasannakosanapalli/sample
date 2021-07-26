package com.photon.medline.epicModules.authentication.resetpassword.local

import androidx.room.*
import com.photon.medline.epicModules.authentication.resetpassword.model.ResetPasswordResponse

/**
 * Reset password dao
 *
 * @constructor Create empty Reset password dao
 */
@Dao
interface ResetPasswordDao {
    @Query("select * from ResetPasswordResponse")
    fun getAll(): ResetPasswordResponse

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(passwordModel: ResetPasswordResponse)

    @Delete
    suspend fun delete(resetPassword: ResetPasswordResponse)

    @Query("SELECT COUNT(*) FROM ResetPasswordResponse")
    fun getCount(): Int
}