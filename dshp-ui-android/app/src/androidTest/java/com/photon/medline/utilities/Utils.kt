package com.photon.medline.utilities

import android.view.View
import androidx.test.espresso.Espresso
import androidx.test.espresso.UiController
import androidx.test.espresso.ViewAction
import androidx.test.espresso.matcher.ViewMatchers.isRoot
import org.hamcrest.Matcher

object Utils {

    /**
     * Perform action of waiting for a specific time.
     */
    fun waitFor(millis: Long ?= null) {
        Espresso.onView(isRoot()).perform(object : ViewAction {
            override fun getConstraints(): Matcher<View> {
                return isRoot()
            }

            override fun getDescription(): String {
                return "Wait for ${millis ?: 1000} milliseconds."
            }

            override fun perform(uiController: UiController, view: View) {
                uiController.loopMainThreadForAtLeast(millis ?: 1000)
            }
        })
    }
}