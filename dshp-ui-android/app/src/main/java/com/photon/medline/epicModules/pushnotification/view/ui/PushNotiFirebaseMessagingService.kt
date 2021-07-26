package com.photon.medline.epicModules.pushnotification.view.ui

import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.photon.medline.utilities.AppLogger

/*
 * Created by Vishal S.
 *  Its a Push notification and In-app Messaging integrated activity
*/
class PushNotiFirebaseMessagingService : FirebaseMessagingService() {
    private val TAG: String? = PushNotificationActivity::class.simpleName
    override fun onMessageReceived(p0: RemoteMessage) {
        super.onMessageReceived(p0)
        if (p0.data != null) {
            TAG?.let {
                AppLogger.info(it, "Data - " + p0.data.toString())
            }
            if (p0.notification != null) {
                TAG?.let {
                    AppLogger.info(it, "Refreshed Token - " + p0.notification.toString())
                }
            }
        }
    }
}
