package com.photon.medline.base.screen

import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.assertion.ViewAssertions
import androidx.test.espresso.matcher.ViewMatchers.isDisplayed
import androidx.test.espresso.matcher.ViewMatchers.withId
import com.photon.medline.R
import com.photon.medline.utilities.Utils

object SplashScreen {

    fun validateSplashScreen() {
        onView(withId(R.id.title_medline))
            .check(ViewAssertions.matches(isDisplayed()))
        Utils.waitFor(50)
    }
}