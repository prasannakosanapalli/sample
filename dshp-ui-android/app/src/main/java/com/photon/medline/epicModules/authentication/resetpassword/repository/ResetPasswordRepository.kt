package com.photon.medline.epicModules.authentication.resetpassword.repository

import com.photon.medline.MedlineApp
import com.photon.medline.R
import com.photon.medline.epicModules.authentication.resetpassword.local.ResetPasswordDao
import com.photon.medline.epicModules.authentication.resetpassword.model.ResetPasswordRequest
import com.photon.medline.epicModules.authentication.resetpassword.model.ResetPasswordResponse
import com.photon.medline.epicModules.authentication.resetpassword.remote.ResetPasswordRemoteDataSource
import com.photon.medline.network.BaseNetworkCallbackHandler
import com.photon.medline.utilities.AppLogger
import com.photon.medline.utilities.NetworkUtilities
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import javax.inject.Inject

/**
 * Reset password repository
 *
 * @property remoteDataSource
 * @property resetPasswordDao
 * @constructor Create empty Reset password repository
 */
class ResetPasswordRepository @Inject constructor
    (
    private val remoteDataSource: ResetPasswordRemoteDataSource,
    private val resetPasswordDao: ResetPasswordDao
) {
    private val TAG: String? = ResetPasswordRepository::class.simpleName
    suspend fun resetPassword(model: ResetPasswordRequest): Flow<BaseNetworkCallbackHandler<ResetPasswordResponse>> {
        return flow {
            try {
                //if internet is not there then getting data from room database
                if (!NetworkUtilities.isConnected(MedlineApp.application)) {
                    emit(
                        BaseNetworkCallbackHandler.error<ResetPasswordResponse>(
                            MedlineApp.application.getString(
                                R.string.internet
                            ), null
                        )
                    )
                    //getting data from room database and showing as toast on screen
                }
                //If internet is there connect to API and get response and save to the room database and display on toast
                else {
                    val result = remoteDataSource.resetPassword(model)
                    emit(result)
                }
            } catch (e: Exception) {
                TAG?.let { AppLogger.error(it, e.toString()) }
            }
        }.flowOn(Dispatchers.IO)
    }
}