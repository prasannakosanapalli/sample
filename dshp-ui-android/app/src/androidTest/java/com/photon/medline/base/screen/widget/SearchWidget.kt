package com.photon.medline.base.screen.widget

import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.assertion.ViewAssertions
import androidx.test.espresso.matcher.ViewMatchers.isDisplayed
import androidx.test.espresso.matcher.ViewMatchers.withId
import com.photon.medline.R
import com.photon.medline.utilities.Utils

object SearchWidget {

    fun validateBasicUIElements() {

        Utils.waitFor(50)
        onView(withId(R.id.edt_search))
            .check(ViewAssertions.matches(isDisplayed()))

        Utils.waitFor(50)
        onView(withId(R.id.ivQRCodeScanner))
            .check(ViewAssertions.matches(isDisplayed()))

    }
}