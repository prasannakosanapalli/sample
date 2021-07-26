package com.photon.medline.utilities

/**
 *Created by PAVANI P on 10/3/2021.
 */
import androidx.room.TypeConverter
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model.Data

class LoginConverters {
   
    @TypeConverter
    fun fromData(res: Data): String? {
        return res.token
    }

    @TypeConverter
    fun toData(token: String): Data {
        return Data(token, token)
    }
}