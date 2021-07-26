package com.photon.medline.network

import com.photon.medline.utilities.Status

/**
 * Created by Romesh
 * Its is base callback handler for all network call operations
 */
data class BaseNetworkStringCallbackHandler<out T>(
    val status: Status,
    val data: String?,
    val message: String?
) {
    companion object {
        fun <T> success(data: String): BaseNetworkStringCallbackHandler<T> {
            return BaseNetworkStringCallbackHandler(Status.SUCCESS, data, null)
        }

        fun <T> error(message: String?, data: String? = null): BaseNetworkStringCallbackHandler<T> {
            return BaseNetworkStringCallbackHandler(Status.ERROR, data, message)
        }

        fun <T> loading(data: String? = null): BaseNetworkStringCallbackHandler<T> {
            return BaseNetworkStringCallbackHandler(Status.LOADING, data, null)
        }
    }
}