package com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.local

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model.LoginResponse

/**
 *  Its a LoginUserDao class handling CRUD operations related to users login.
 */
@Dao
interface LoginUserDao {
    @Query("select * from LoginResponse")
    fun getAll(): LoginResponse

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(user: LoginResponse)

    @Query("DELETE FROM LoginResponse")
    fun delete()

    @Query("SELECT COUNT(*) FROM LoginResponse")
    fun getCount(): Int
}