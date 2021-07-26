package com.photon.medline.epicModules.authentication.signup.data.remote

import com.google.gson.Gson
import com.photon.medline.BuildConfig
import com.photon.medline.epicModules.authentication.signup.data.model.RegistrationModel
import com.photon.medline.epicModules.authentication.signup.data.model.SignUpResponse
import com.photon.medline.network.BaseNetworkCallbackHandler
import com.photon.medline.network.apis.ApiService
import com.photon.medline.utilities.Constants.HEADER_KEY
import retrofit2.Response
import javax.inject.Inject

/**
 * Sign up remote data source
 *
 * @property apiService
 * @constructor Create empty Sign up remote data source
 */
class SignUpRemoteDataSource @Inject constructor(private val apiService: ApiService) {
    private val TAG: String? = SignUpRemoteDataSource::class.simpleName
    protected suspend fun <T> getResult(call: suspend () -> Response<T>): BaseNetworkCallbackHandler<T> {
        try {
            val response = call()

            if (response.isSuccessful) {

                val body = response.body()
                if (body != null)
                    return BaseNetworkCallbackHandler.success(body)
            }
            val errorMessage: SignUpResponse = Gson().fromJson(
                response.errorBody()!!.charStream().readText(),
                SignUpResponse::class.java
            )
            return error(
                errorMessage.message
            )

        } catch (e: Exception) {
            return error(e.message ?: e.toString())
        }
    }

    fun <T> error(data: String?): BaseNetworkCallbackHandler<T> {
        return BaseNetworkCallbackHandler.error(data)
    }


    suspend fun signUp(signUpModel: RegistrationModel): BaseNetworkCallbackHandler<SignUpResponse> {
        val header = HashMap<String, String>()
        header[HEADER_KEY] = BuildConfig.API_KEY

        val response = getResult { apiService.signUp(header, signUpModel) }
        return response

    }

}