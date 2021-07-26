package com.photon.medline.base.screen

import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.assertion.ViewAssertions
import androidx.test.espresso.matcher.ViewMatchers.isDisplayed
import androidx.test.espresso.matcher.ViewMatchers.withId
import com.photon.medline.R
import com.photon.medline.utilities.Utils

object HomeFragmentScreen {
    fun validateBasicUIElement() {

        Utils.waitFor(50)
        onView(withId(R.id.wdt_search))
            .check(ViewAssertions.matches(isDisplayed()))

        Utils.waitFor(50)
        onView(withId(R.id.txt_greeting))
            .check(ViewAssertions.matches(isDisplayed()))

        Utils.waitFor(50)
        onView(withId(R.id.rv_product))
            .check(ViewAssertions.matches(isDisplayed()))

        Utils.waitFor(50)
        onView(withId(R.id.wdt_banner))
            .check(ViewAssertions.matches(isDisplayed()))

        Utils.waitFor(50)
        onView(withId(R.id.wdt_sub_category))
            .check(ViewAssertions.matches(isDisplayed()))
    }

}