package com.photon.medline.base

import androidx.test.espresso.NoMatchingViewException
import com.photon.medline.base.screen.LoginScreen
import com.photon.medline.base.screen.SplashScreen
import com.photon.medline.utilities.Utils

open class BaseClass {

    fun doLogin(username : String ?= null , password : String ?= null) {
        try {
            SplashScreen.validateSplashScreen()
            Utils.waitFor(3000)
        } catch (e : NoMatchingViewException) {
            e.printStackTrace()
        }
        LoginScreen.validateScreen()
        LoginScreen.doLogin(username,password)
    }
}