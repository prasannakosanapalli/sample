package com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.remote

import com.google.gson.Gson
import com.photon.medline.BuildConfig
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model.LoginPayload
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model.LoginResponse
import com.photon.medline.errors.Error
import com.photon.medline.network.BaseNetworkCallbackHandler
import com.photon.medline.network.apis.ApiService
import com.photon.medline.utilities.Constants.HEADER_KEY
import retrofit2.Response
import javax.inject.Inject

class LoginRemoteDataSource @Inject constructor(private val loginApiService: ApiService) {
    private val TAG: String? = LoginRemoteDataSource::class.simpleName
    protected suspend fun <T> getResult(call: suspend () -> Response<T>): BaseNetworkCallbackHandler<T> {
        try {
            val response = call()
            if (response.isSuccessful) {
                val body = response.body()
                if (body != null) return BaseNetworkCallbackHandler.success(body)
            }
            val error: Error = Gson().fromJson(
                response.errorBody()!!.charStream().readText(),
                Error::class.java
            )
            return error(
                error.message!!
            )
        } catch (e: Exception) {
            return error(e.message ?: e.toString())
        }
    }

    fun <T> error(data: String): BaseNetworkCallbackHandler<T> {
        return BaseNetworkCallbackHandler.error(data)
    }

    suspend fun userLogin(loginModel: LoginPayload): BaseNetworkCallbackHandler<LoginResponse> {
        val header = HashMap<String, String>()
        header[HEADER_KEY] = BuildConfig.API_KEY
        val response = getResult { loginApiService.userLogin(header, loginModel) }
        return response
    }
}