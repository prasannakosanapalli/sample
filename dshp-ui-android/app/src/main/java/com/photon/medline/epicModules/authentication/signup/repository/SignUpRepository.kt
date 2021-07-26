package com.photon.medline.epicModules.authentication.signup.repository

import com.photon.medline.MedlineApp
import com.photon.medline.R
import com.photon.medline.epicModules.authentication.signup.data.local.SignUpDao
import com.photon.medline.epicModules.authentication.signup.data.model.RegistrationModel
import com.photon.medline.epicModules.authentication.signup.data.model.SignUpResponse
import com.photon.medline.epicModules.authentication.signup.data.remote.SignUpRemoteDataSource
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
 * Sign up repository
 *
 * @property remoteDataSource
 * @property signUpDao
 * @constructor Create empty Sign up repository
 */
class SignUpRepository @Inject constructor
    (
    private val remoteDataSource: SignUpRemoteDataSource,
    private val signUpDao: SignUpDao
) {
    private val TAG: String? = SignUpRepository::class.simpleName
    suspend fun signUp(signUpModel: RegistrationModel): Flow<BaseNetworkCallbackHandler<SignUpResponse>> {
        return flow {
            try {
                //if internet is not there then getting data from room database
                if (!NetworkUtilities.isNetworkConnected()) {
                    signUpDao.insertUserFailedRecod(signUpModel)
                    emit(
                        BaseNetworkCallbackHandler.error<SignUpResponse>(
                            MedlineApp.application.getString(
                                R.string.internet
                            ), null
                        )
                    )
                } else {
                    signUpDao.insertUserFailedRecod(signUpModel)
                    val result = remoteDataSource.signUp(signUpModel)
                    if (result.status == Status.SUCCESS) {
                        result.data?.let { it ->
                            signUpDao.deleteFailedRecord(signUpModel)
                        }
                    }
                    emit(result)
                }
            } catch (e: Exception) {
                TAG?.let { AppLogger.error(it, e.toString()) }
            }
        }.flowOn(Dispatchers.IO)
    }

    fun registrationModel(): RegistrationModel {
        return signUpDao.userFailedRecord()
    }

    fun deleteRegistration(signUpModel: RegistrationModel) {
        signUpDao.deleteFailedRecord(signUpModel)
    }
}