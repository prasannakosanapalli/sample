package com.photon.medline.db

import androidx.room.Database
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.local.LoginUserDao
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model.LoginResponse
import com.photon.medline.epicModules.authentication.resetpassword.local.ResetPasswordDao
import com.photon.medline.epicModules.authentication.resetpassword.model.ResetPasswordResponse
import com.photon.medline.epicModules.authentication.signup.data.local.SignUpDao
import com.photon.medline.epicModules.authentication.signup.data.model.RegistrationModel
import com.photon.medline.epicModules.authentication.signup.data.model.SignUpResponse
import com.photon.medline.epicModules.dashboard.home.local.HomeFragmentDao
import com.photon.medline.epicModules.dashboard.home.model.HomeFragmentResponse
import com.photon.medline.utilities.LoginConverters

/* Created by Romesh
 *  Its base class for room database where we are extending the room db.
 */
@Database(
    entities = [LoginResponse::class, ResetPasswordResponse::class, SignUpResponse::class, HomeFragmentResponse::class, RegistrationModel::class],
    version = 1
)
@TypeConverters(LoginConverters::class)
abstract class AppDatabase : RoomDatabase() {
    abstract fun loginUserDao(): LoginUserDao
    abstract fun resetPassword(): ResetPasswordDao
    abstract fun signUpDao(): SignUpDao
    abstract fun homeFragmentDao(): HomeFragmentDao
}