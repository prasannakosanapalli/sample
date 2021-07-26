package com.photon.medline.utilities

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import com.photon.medline.MedlineApp

/*
 Created by Romesh
 Here we will handle the network related functions like internet not available.
 Which type internet user using like that.
 */
object NetworkUtilities {
    fun isConnected(context: Context): Boolean {
        val connectivityManager =
            context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val networks: Array<Network> = connectivityManager.allNetworks
        var hasInternet = false
        if (networks.size > 0) {
            for (network in networks) {
                val nc = connectivityManager.getNetworkCapabilities(network)
                if (nc != null && nc.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)) hasInternet =
                    true
            }
        }
        return hasInternet
    }

    fun isNetworkConnected(): Boolean {
        val cm =
            MedlineApp.application.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager?
        return cm!!.activeNetworkInfo != null && cm.activeNetworkInfo!!.isConnected
    }
}
