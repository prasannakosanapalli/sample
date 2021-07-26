package com.photon.medline.epicModules.dashboard.home.repository

import com.photon.medline.MedlineApp
import com.photon.medline.R
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.local.LoginUserDao
import com.photon.medline.epicModules.authentication.resetpassword.repository.ResetPasswordRepository
import com.photon.medline.epicModules.dashboard.home.local.HomeFragmentDao
import com.photon.medline.epicModules.dashboard.home.model.HomeFragmentResponse
import com.photon.medline.epicModules.dashboard.home.remote.HomeFragmentDataSource
import com.photon.medline.network.BaseNetworkCallbackHandler
import com.photon.medline.utilities.AppLogger
import com.photon.medline.utilities.NetworkUtilities
import com.photon.medline.utilities.Status
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import javax.inject.Inject


/**
 *Created by Ashutosh Srivastava on 24-03-2021
 * Copyright(c) 2021 Photon.
 */
class HomeFragmentRepository @Inject constructor
    (
    private val remoteDataSource: HomeFragmentDataSource,
    private val homeFragmentDao: HomeFragmentDao,
    private val loginUserDao: LoginUserDao
) {
    private val TAG: String? = ResetPasswordRepository::class.simpleName
    suspend fun homeFragment(): Flow<BaseNetworkCallbackHandler<HomeFragmentResponse>> {
        return flow {
            try {
                //if internet is not there then getting data from room database
                if (!NetworkUtilities.isConnected(MedlineApp.application)) {
                    emit(
                        BaseNetworkCallbackHandler.error<HomeFragmentResponse>(
                            MedlineApp.application.getString(
                                R.string.internet
                            ), null
                        )
                    )
                    emit(
                        fetchUserDataCached()
                    )
                    //getting data from room database and showing as toast on screen
                }
                //If internet is there connect to API and get response and save to the room database and display on toast
                else {
                    val result = remoteDataSource.homeFragment(loginUserDao.getAll().data?.token)
                    emit(result)
                }
            } catch (e: Exception) {
                TAG?.let { AppLogger.error(it, e.toString()) }
            }
        }.flowOn(Dispatchers.IO)
    }

    //getting data from room database and show it as toast message
    private fun fetchUserDataCached(): BaseNetworkCallbackHandler<HomeFragmentResponse> =
        homeFragmentDao.getAll().let {
            BaseNetworkCallbackHandler.success(it)
        }
}