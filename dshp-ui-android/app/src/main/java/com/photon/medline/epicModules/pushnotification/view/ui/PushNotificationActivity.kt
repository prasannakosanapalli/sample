package com.photon.medline.epicModules.pushnotification.view.ui
/*
 * Created by Vishal S.
 *  Its Push Notification and In-app Messaging class
 *  using Token and Installation ID
 */
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.ktx.Firebase
import com.google.firebase.messaging.ktx.messaging
import com.photon.medline.R
import com.photon.medline.utilities.AppLogger

class PushNotificationActivity : AppCompatActivity() {
    private val TAG: String? = PushNotificationActivity::class.simpleName
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            setContentView(R.layout.activity_pushnotification)
            Firebase.messaging.token.addOnCompleteListener(OnCompleteListener { task ->
                if (!task.isSuccessful) {
                    TAG?.let { AppLogger.error(it, "Fetching FCM registration token failed") }
                    return@OnCompleteListener
                }
                // Get new FCM registration token
                val token = task.result
                TAG?.let { AppLogger.info(it, "Token - $token") }
                Toast.makeText(baseContext, "" + token, Toast.LENGTH_SHORT).show()
            })
        } catch (e: Exception) {
            TAG?.let { AppLogger.error(it, "Exception $e ") }
        }
    }
}