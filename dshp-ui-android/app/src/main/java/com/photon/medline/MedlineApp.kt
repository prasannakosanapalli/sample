package com.photon.medline

import android.app.Application
import dagger.hilt.android.HiltAndroidApp

/**
 * Created by Romesh
 * Its application level main class which handle the single instance of application with hilt
 * dependency injection system.
 */
@HiltAndroidApp
class MedlineApp : Application() {

    companion object {

        lateinit var application: Application
        fun getInstance() = Application()
    }

    override fun onCreate() {
        super.onCreate()
        application = this
    }
}