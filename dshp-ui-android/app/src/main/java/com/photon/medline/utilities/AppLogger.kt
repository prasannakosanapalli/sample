package com.photon.medline.utilities

import android.util.Log

/**
 * Created by Romesh
 * It will control the all logs of app locally. Here i am not using any library for it.
 */
object AppLogger {
    private const val LOG_ENABLE = true
    fun debug(tag: String, message: String) {
        if (LOG_ENABLE) {
            Log.d(APP_LOG + tag, message)
        }
    }

    fun info(tag: String, message: String) {
        if (LOG_ENABLE) {
            Log.i(APP_LOG + tag, message)
        }
    }

    fun warning(tag: String, message: String) {
        if (LOG_ENABLE) {
            Log.w(APP_LOG + tag, message)
        }
    }

    fun error(tag: String, message: String) {
        if (LOG_ENABLE) {
            Log.e(APP_LOG + tag, message)
        }
    }
}