package com.photon.medline.network

import com.photon.medline.utilities.Status

/**
 * Created by Romesh
 * Its is base callback handler for all network call operations
 */
data class BaseNetworkCallbackHandler<out T>(
    val status: Status,
    val data: T?,
    val message: String?
) {
    companion object {
        fun <T> success(data: T?): BaseNetworkCallbackHandler<T> {
            return BaseNetworkCallbackHandler(Status.SUCCESS, data, null)
        }

        fun <T> error(message: String, data: T?): BaseNetworkCallbackHandler<T> {
            return BaseNetworkCallbackHandler(Status.ERROR, data, message)
        }

        fun <T> error(data: String?): BaseNetworkCallbackHandler<T> {
            return BaseNetworkCallbackHandler(Status.ERROR, null, data)
        }

        fun <T> loading(data: T? = null): BaseNetworkCallbackHandler<T> {
            return BaseNetworkCallbackHandler(Status.LOADING, data, null)
        }
    }
}