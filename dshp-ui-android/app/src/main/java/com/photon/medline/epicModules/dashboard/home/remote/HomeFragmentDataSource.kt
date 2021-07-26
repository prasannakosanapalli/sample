package com.photon.medline.epicModules.dashboard.home.remote

import com.photon.medline.BuildConfig
import com.photon.medline.epicModules.dashboard.home.model.HomeFragmentResponse
import com.photon.medline.network.BaseNetworkCallbackHandler
import com.photon.medline.network.apis.ApiService
import com.photon.medline.utilities.Constants
import retrofit2.Response
import javax.inject.Inject


/**
 *Created by Ashutosh Srivastava on 24-03-2021
 * Copyright(c) 2021 Photon.
 */
class HomeFragmentDataSource @Inject constructor(private val apiService: ApiService) {
    private val TAG: String? = HomeFragmentDataSource::class.simpleName
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

    suspend fun homeFragment(token: String?): BaseNetworkCallbackHandler<HomeFragmentResponse> {
        val header = HashMap<String, String>()
        header[Constants.HEADER_KEY] = BuildConfig.API_KEY
        header[Constants.TOKEN] = token!!
        val response = getResult { apiService.homeFragment(header) }
        return response
    }
}