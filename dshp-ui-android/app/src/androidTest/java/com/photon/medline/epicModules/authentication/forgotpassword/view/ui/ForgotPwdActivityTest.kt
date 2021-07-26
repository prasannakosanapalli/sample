package com.photon.medline.epicModules.authentication.forgotpassword.view.ui

import androidx.test.espresso.Espresso
import androidx.test.espresso.action.ViewActions
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers
import androidx.test.espresso.matcher.ViewMatchers.*
import androidx.test.ext.junit.rules.ActivityScenarioRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.photon.medline.R
import com.photon.medline.utilities.EMAIL_
import org.hamcrest.CoreMatchers
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Created by PAVANI P on 24/2/2021.
 *This UI testings class for [ForgotPwdActivity] design which is for forgot activity feature via username.
 */
@RunWith(AndroidJUnit4::class)
class ForgotPwdActivityTest {
    /**
     * Activity scenario rule launches a given activity before the test starts and closes after the test.
     */
    @get:Rule
    var ActivityScenarioRule =
        ActivityScenarioRule<ForgotPwdActivity>(ForgotPwdActivity::class.java)

    /**
     * Forgot passwordtitledisplayingtest
     *This method tests that Title is displaying on screen.
     *
     */
    @Test
    fun forgotPasswordTitleDisplayingTest() {
        Espresso.onView(withId(R.id.txt_forgot_title))
            .check(matches(isDisplayed()))
    }

    /**
     * Forgot passwordtitlesubtextdisplayingtest
     *This method tests that Title is displaying on screen.
     *
     */
    @Test
    fun forgotPasswordTitleSubTextDisplayingTest() {
        Espresso.onView(withId(R.id.txt_forgot_text))
            .check(matches(isDisplayed()))
    }

    /**
     * Forgot passwordemaildisplayingtest
     * This method tests the Edittext is displaying on screen.
     *
     */
    @Test
    fun forgotPasswordEmailDisplayingTest() {
        Espresso.onView(withId(R.id.edt_forgot_email))
            .perform(ViewActions.click())
            .check(matches(isDisplayed()))
    }

    /**
     * Forgot passwordemailinput typedtest
     *This method tests the Edittext is allowing input from the keyboard.
     */
    @Test
    fun forgotPasswordEmailInputTypedTest() {
        Espresso.onView(withId(R.id.edt_forgot_email))
            .perform(ViewActions.typeText(EMAIL_))
    }

    /**
     * Forgot passwordemailerrortextnotdisplayingtest
     *When user entered invalid data as per the validations, then only It will be visible on screen.
     */
    @Test
    fun forgotPasswordEmailErrorTextNotDisplayingTest() {
        Espresso.onView(withId(R.id.forgot_email_error))
            .check(matches(CoreMatchers.not(ViewMatchers.isDisplayed())))
    }

    /**
     * forgotPasswordErrorDisplayingOnScreenTest
     *this method test for error Email text is matching or not
     */
    @Test
    fun forgotPasswordErrorDisplayingOnScreenTest() {
        Espresso.onView(withId(R.id.forgot_email_error))
            .check(matches(withText(R.string.email_error)))
    }

    /**
     * Forgot password buttondisplayingtest
     *This method tests the SUBMIT button is Displaying on the screen. And also not enabled.
     * because this button will enable when user enter valid Email.
     */
    @Test
    fun forgotPasswordButtonDisplayingTest() {
        Espresso.onView(withId(R.id.btn_forget_password))
            .perform(ViewActions.click())
            .check(matches(isDisplayed()))
            .check(matches(CoreMatchers.not(isEnabled())))
    }

    /**
     * Forgot passwordsuccessmessageNotdisplayingtest
     *This method tests that success message is not displaying on screen. based on API response
     * It will display to user. Till that time It should not be visible.
     */
    @Test
    fun forgotPasswordSuccessMessageNotDisplayingTest() {
        Espresso.onView(withId(R.id.success))
            .check(matches(CoreMatchers.not(isDisplayed())))
    }

    /**
     * Forgot passwordsuccesssubtextnotdisplayingtest
     *This method tests that text message is not displaying on screen. based on API response
     * It will display to user. Till that time It should not be visible.
     */
    @Test
    fun forgotPasswordSuccesssubtextNotDisplayingTest() {
        Espresso.onView(withId(R.id.success_message))
            .check(matches(CoreMatchers.not(isDisplayed())))
    }

    /**
     * Forgot passwordcontinuetologinbuttonnotdisplayingtest
     *This method tests that continue to Continue to Login button not displaying on screen.based on API response
     * It will display to user. Till that time It should not be visible.
     */
    @Test
    fun forgotPasswordContinueToLoginButtonNotDisplayingTest() {
        Espresso.onView(withId(R.id.btn_continue_login))
            .check(matches(CoreMatchers.not(isDisplayed())))
    }
}