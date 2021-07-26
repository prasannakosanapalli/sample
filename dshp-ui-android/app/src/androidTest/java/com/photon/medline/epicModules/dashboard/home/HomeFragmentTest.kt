package com.photon.medline.epicModules.dashboard.home

import androidx.test.ext.junit.rules.ActivityScenarioRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.photon.medline.base.BaseClass
import com.photon.medline.base.screen.HomeFragmentScreen
import com.photon.medline.base.screen.widget.SearchWidget
import com.photon.medline.epicModules.dashboard.DashBoardActivity
import com.photon.medline.epicModules.welcomepage.SplashActivity
import com.photon.medline.utilities.Utils
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Created by PAVANI P on 26/2/2021.
 * This class is for UI testings for [HomeFragment] design which is home screen in [DashBoardActivity]
 */
@RunWith(AndroidJUnit4::class)
class HomeFragmentTest : BaseClass() {
    @get:Rule
    val activityScenarioRule =
        ActivityScenarioRule(SplashActivity::class.java)

    @Test
    fun validateDashboardUIElements() {
        doLogin()
        Utils.waitFor(8000)
        HomeFragmentScreen.validateBasicUIElement()
        SearchWidget.validateBasicUIElements()

    }
}