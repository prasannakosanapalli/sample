package com.photon.medline.epicModules.authentication.forgotpassword.data.remote

import com.google.gson.Gson
import com.photon.medline.BuildConfig
import com.photon.medline.epicModules.authentication.forgotpassword.data.model.ForgotPasswordPayload
import com.photon.medline.epicModules.authentication.forgotpassword.data.model.ForgotPasswordResponse
import com.photon.medline.network.BaseNetworkCallbackHandler
import com.photon.medline.network.apis.ApiService
import com.photon.medline.utilities.Constants.HEADER_KEY
import retrofit2.Response
import javax.inject.Inject

/**
 *  Created by Vishal S. on 11/3/2021.
 * This class send the request to server and return the response to Repository class.
 */
class ForgotPwdRemoteDataSource @Inject constructor(private val forgetPasswordApiService: ApiService) {
    private val TAG: String? = ForgotPwdRemoteDataSource::class.simpleName
    suspend fun forgotPassword(forgotPwdModel: ForgotPasswordPayload): BaseNetworkCallbackHandler<ForgotPasswordResponse> {
        val header = HashMap<String, String>()
        header[HEADER_KEY] = BuildConfig.API_KEY
        val response =
            getResult { forgetPasswordApiService.userForgotPassword(header, forgotPwdModel) }
        return response
    }

    protected suspend fun <T> getResult(call: suspend () -> Response<T>): BaseNetworkCallbackHandler<T> {
        try {
            val response = call()
            if (response.isSuccessful) {
                val body = response.body()
                if (body != null)
                    return BaseNetworkCallbackHandler.success(body)
            }
            val errorMessage: ForgotPasswordResponse = Gson().fromJson(
                response.errorBody()!!.charStream().readText(),
                ForgotPasswordResponse::class.java
            )
            return error(
                errorMessage.message
            )
        } catch (e: Exception) {
            return error(e.message ?: e.toString())
        }
    }

    fun <T> error(data: String): BaseNetworkCallbackHandler<T> {
        return BaseNetworkCallbackHandler.error(data)
    }
}