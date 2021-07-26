package com.photon.medline.epicModules.welcomepage

import androidx.test.espresso.Espresso
import androidx.test.espresso.assertion.ViewAssertions
import androidx.test.espresso.matcher.ViewMatchers
import androidx.test.ext.junit.rules.ActivityScenarioRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.photon.medline.R
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Created by Ashutosh Srivastava on 25-02-2021
 * Copyright(c) 2021 .
 */
@RunWith(AndroidJUnit4::class)
class SplashActivityTest {
    @Rule
    @JvmField
    val activityRule = ActivityScenarioRule<SplashActivity>(SplashActivity::class.java)

    @Test
    fun isScreenDisplay() {
        Espresso.onView(ViewMatchers.withId(R.id.title_medline))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }
}