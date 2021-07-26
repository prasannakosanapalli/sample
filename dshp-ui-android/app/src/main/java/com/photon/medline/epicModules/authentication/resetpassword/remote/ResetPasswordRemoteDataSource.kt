package com.photon.medline.epicModules.authentication.resetpassword.remote

import com.photon.medline.BuildConfig
import com.photon.medline.epicModules.authentication.resetpassword.model.ResetPasswordRequest
import com.photon.medline.epicModules.authentication.resetpassword.model.ResetPasswordResponse
import com.photon.medline.network.BaseNetworkCallbackHandler
import com.photon.medline.network.apis.ApiService
import com.photon.medline.utilities.Constants.HEADER_KEY
import retrofit2.Response
import javax.inject.Inject

/**
 * Reset password remote data source
 *
 * @property apiService
 * @constructor Create empty Reset password remote data source
 */
class ResetPasswordRemoteDataSource @Inject constructor(private val apiService: ApiService) {
    private val TAG: String? = ResetPasswordRemoteDataSource::class.simpleName
    protected suspend fun <T> getResult(call: suspend () -> Response<T>): BaseNetworkCallbackHandler<T> {
        try {
            val response = call()
            if (response.isSuccessful) {
                val body = response.body()
                if (body != null) return BaseNetworkCallbackHandler.success(body)
            }
            return error(
                response.errorBody()!!.charStream().readText()
            )
        } catch (e: Exception) {
            return error(e.message ?: e.toString())
        }
    }

    private fun <T> error(data: String): BaseNetworkCallbackHandler<T> {
        return BaseNetworkCallbackHandler.error(data)
    }

    suspend fun resetPassword(resetPasswordRequest: ResetPasswordRequest): BaseNetworkCallbackHandler<ResetPasswordResponse> {
        val header = HashMap<String, String>()
        header[HEADER_KEY] = BuildConfig.API_KEY
        val response = getResult { apiService.resetPassword(header, resetPasswordRequest) }
        return response
    }
}