package com.photon.medline.epicModules.welcomepage

import androidx.lifecycle.MutableLiveData
import com.photon.medline.base.BaseViewModel
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.local.LoginUserDao
import com.photon.medline.utilities.Constants
import dagger.hilt.android.lifecycle.HiltViewModel
import java.util.*
import javax.inject.Inject

@HiltViewModel
class SplashViewModel @Inject constructor(private val loginUserDao: LoginUserDao) :
    BaseViewModel() {
    private val TAG: String? = SplashViewModel::class.simpleName
    var mutableLiveData = MutableLiveData<Int>()

    init {
        timeTaskForThreeSecond(Constants.DELEY_TIME)
    }

    /**
     *  this method used for deley for three second
     *
     * @param deleyTime
     */
    fun timeTaskForThreeSecond(deleyTime: Long) {
        val timer: Timer
        val timerTask: TimerTask = object : TimerTask() {
            override fun run() {
                mutableLiveData.postValue(Constants.SPLASH_SCREEN)
            }
        }
        timer = Timer()
        timer.schedule(timerTask, deleyTime)
    }
    /**
     * added by pavani on 05-03-2021.
     * User session expire and display login screen after 24 hours validation
     */
//    fun currentDateTime() {
//
//            val loginDateTime = loginUserDao.getDate()
//            val current = Calendar.getInstance()
//            val datePlusOneMonth: Date = current.time
//            val formatted = current.toString()
//            TAG?.let { AppLogger.info(it, formatted) }
//
//            val diff: Long = loginDateTime.time - dateToTimestamp(datePlusOneMonth)
//
//            //calculating hours
//            val seconds = diff/1000
//            val minutes = seconds/60
//            val hours = minutes/60
//
//        if (hours > 24)
//            mutableLiveData.postValue(Constants.SPLASH_SCREEN)
//        else
//            mutableLiveData.postValue(Constants.DASHBOARD)
//    }
    /**
     * Deeplinking configuration
     *this method is used to configuration related to deeplinking
     * like as clear session data and local database
     */

}