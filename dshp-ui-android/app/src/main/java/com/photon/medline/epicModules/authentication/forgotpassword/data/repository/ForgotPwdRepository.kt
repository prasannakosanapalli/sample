package com.photon.medline.epicModules.authentication.forgotpassword.data.repository

import com.photon.medline.MedlineApp
import com.photon.medline.R
import com.photon.medline.epicModules.authentication.forgotpassword.data.model.ForgotPasswordPayload
import com.photon.medline.epicModules.authentication.forgotpassword.data.model.ForgotPasswordResponse
import com.photon.medline.epicModules.authentication.forgotpassword.data.remote.ForgotPwdRemoteDataSource
import com.photon.medline.network.BaseNetworkCallbackHandler
import com.photon.medline.testing.OpenForTesting
import com.photon.medline.utilities.AppLogger
import com.photon.medline.utilities.NetworkUtilities
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import javax.inject.Inject

/**
 *Created by Vishal S. on 11/3/2021.
 * Its Forgot Password Repository class which will decide to render the data from local database or from API.
 */
@OpenForTesting
class ForgotPwdRepository @Inject constructor
    (private val forgotPwdRemoteDataSource: ForgotPwdRemoteDataSource) {
    private val TAG: String? = ForgotPwdRepository::class.simpleName
    suspend fun forgotPassword(forgotPwdModel: ForgotPasswordPayload): Flow<BaseNetworkCallbackHandler<ForgotPasswordResponse>> {
        return flow {
            try {
                if (!NetworkUtilities.isConnected(MedlineApp.application)) {
                    emit(
                        BaseNetworkCallbackHandler.error<ForgotPasswordResponse>(
                            MedlineApp.application.getString(
                                R.string.internet
                            ), null
                        )
                    )
                } else {
                    val result = forgotPwdRemoteDataSource.forgotPassword(forgotPwdModel)
                    emit(result)
                }

            } catch (e: Exception) {
                TAG?.let { AppLogger.error(it, e.toString()) }
            }
        }.flowOn(Dispatchers.IO)
    }
}