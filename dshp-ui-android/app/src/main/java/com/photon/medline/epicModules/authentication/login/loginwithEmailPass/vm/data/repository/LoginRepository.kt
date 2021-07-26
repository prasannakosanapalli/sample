package com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.repository

import com.photon.medline.MedlineApp
import com.photon.medline.MedlineApp.Companion.application
import com.photon.medline.R
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.local.LoginUserDao
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model.LoginPayload
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model.LoginResponse
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.remote.LoginRemoteDataSource
import com.photon.medline.network.BaseNetworkCallbackHandler
import com.photon.medline.testing.OpenForTesting
import com.photon.medline.utilities.AppLogger
import com.photon.medline.utilities.NetworkUtilities
import com.photon.medline.utilities.Status
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import javax.inject.Inject

/*
 * Created by Romesh
 * Its Login Repository class which will decide to render the data from local database or from API. *
 */
@OpenForTesting
class LoginRepository @Inject constructor
    (
    private val loginRemoteDataSource: LoginRemoteDataSource,
    private val loginUserDao: LoginUserDao
) {
    private val TAG: String? = LoginRepository::class.simpleName
    suspend fun userLogin(loginModel: LoginPayload): Flow<BaseNetworkCallbackHandler<LoginResponse>> {
        return flow {
            try {
                if (!NetworkUtilities.isConnected(MedlineApp.application)) {
                    emit(
                        BaseNetworkCallbackHandler.error<LoginResponse>(
                            application.getString(
                                R.string.internet
                            ), null
                        )
                    )
                } else {
                    val result = loginRemoteDataSource.userLogin(loginModel)
                    if (result.status == Status.SUCCESS) {
                        result.data.let { it ->
                            loginUserDao.delete()
                            if (it != null) {
                                loginUserDao.insert(it)
                            }
                        }
                    }
                    emit(result)
                }
            } catch (e: Exception) {
                TAG?.let { AppLogger.error(it, e.toString()) }
            }
        }.flowOn(Dispatchers.IO)
    }

    //getting data from room database and show it as toast message
    private fun fetchUserDataCached(): BaseNetworkCallbackHandler<LoginResponse> =
        loginUserDao.getAll().let {
            BaseNetworkCallbackHandler.success(it)
        }
}