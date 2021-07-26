package com.photon.medline.epicModules.authentication.signup.data.local

import androidx.room.*
import com.photon.medline.epicModules.authentication.signup.data.model.RegistrationModel
import com.photon.medline.epicModules.authentication.signup.data.model.SignUpResponse

/**
 * Sign up dao
 *
 * @constructor Create empty Sign up dao
 */
@Dao
interface SignUpDao {
    @Query("select * from SignUpResponse")
    fun getAll(): SignUpResponse

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(passwordModel: SignUpResponse)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertUserFailedRecod(registrationModel: RegistrationModel)

    @Query("select * from RegistrationModel")
    fun userFailedRecord(): RegistrationModel

    @Delete
    fun deleteFailedRecord(registrationModel: RegistrationModel)

    @Delete
    suspend fun delete(signUp: SignUpResponse)

    @Query("SELECT COUNT(*) FROM SignUpResponse")
    fun getCount(): Int
}