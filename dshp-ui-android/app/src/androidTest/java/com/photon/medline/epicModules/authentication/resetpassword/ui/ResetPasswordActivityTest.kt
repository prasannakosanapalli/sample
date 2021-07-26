package com.photon.medline.epicModules.authentication.resetpassword.ui

import androidx.test.espresso.Espresso
import androidx.test.espresso.action.ViewActions
import androidx.test.espresso.assertion.ViewAssertions
import androidx.test.espresso.matcher.ViewMatchers
import androidx.test.ext.junit.rules.ActivityScenarioRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.photon.medline.R
import com.photon.medline.utilities.CONFIRM_PASSWORDS
import com.photon.medline.utilities.PASSWORDS
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Created by Ashutosh Srivastava on 25-02-2021
 * Copyright(c) 2021 .
 */
@RunWith(AndroidJUnit4::class)
class ResetPasswordActivityTest {
    @get:Rule
    var activityScenarioRule =
        ActivityScenarioRule<ResetPasswordActivity>(ResetPasswordActivity::class.java)

    /**
     * Titleresetpassworddisplayingonscreentest
     *this method test for title reset password view is visible or not
     */
    @Test
    fun titleresetpasswordDisplayingOnScreenTest() {
        Espresso.onView(ViewMatchers.withId(R.id.title_reset_password))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Enternewpassworddisplayingonscreentest
     *this method test for title enter reset password view is visible or not
     */
    @Test
    fun enternewpasswordDisplayingOnScreenTest() {
        Espresso.onView(ViewMatchers.withId(R.id.enter_new_password))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Newpassworddisplayingonscreentest
     *this method test for new password view is visible or not
     * This method tests the Edittext is allowing input from the keyboard.
     */
    @Test
    fun newpasswordDisplayingOnScreenTest() {
        Espresso.onView(ViewMatchers.withId(R.id.new_password))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Newpassworderrordisplayingonscreentest
     *this method test for error new password text is matching or not
     */
    @Test
    fun newpassworderrorDisplayingOnScreenTest() {
        Espresso.onView(ViewMatchers.withId(R.id.new_password_error))
            .check(ViewAssertions.matches(ViewMatchers.withText(R.string.entervalidPassword)))
    }

    /**
     * Confirmpassworddisplayingonscreentest
     *this method test for confirm password view is visible or not
     * This method tests the Edittext is allowing input from the keyboard.
     */
    @Test
    fun confirmpasswordDisplayingOnScreenTest() {
        Espresso.onView(ViewMatchers.withId(R.id.confirm_password))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Confirmpassworderrordisplayingonscreentest
     *this method test for error confirm password text is matching or not
     */
    @Test
    fun confirmpassworderrorDisplayingOnScreenTest() {
        Espresso.onView(ViewMatchers.withId(R.id.confirm_password_error))
            .check(ViewAssertions.matches(ViewMatchers.withText(R.string.newPasswordConfirmPasswordNotMatch)))
    }

    /**
     * Txtresetpasswordclicklistenerdisplayingonscreentest
     *this method test for title reset password submit textview is visible or not
     */
    @Test
    fun txtresetpasswordclicklistenerDisplayingOnScreenTest() {
        Espresso.onView(ViewMatchers.withId(R.id.txt_reset_password_click_listener))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    @Test
    fun fillAllTest() {
        Espresso.onView(ViewMatchers.withId(R.id.new_password)).perform(
            ViewActions.typeText(
                PASSWORDS
            )
        )
        Espresso.onView(ViewMatchers.withId(R.id.confirm_password))
            .perform(ViewActions.typeText(CONFIRM_PASSWORDS))

    }
}