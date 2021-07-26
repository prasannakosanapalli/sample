package com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.view.ui

import androidx.test.espresso.Espresso
import androidx.test.espresso.action.ViewActions
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.ext.junit.rules.ActivityScenarioRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.photon.medline.R
import com.photon.medline.utilities.EMAIL_
import com.photon.medline.utilities.TEXT
import org.hamcrest.CoreMatchers
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Created by PAVANI P on 24/2/2021.
 * Its UI testings class for [LoginActivity] design which is for forgot activity feature
 * via username and Password.
 */
@RunWith(AndroidJUnit4::class)
class LoginActivityTest {
    @get:Rule
    var ActivityScenarioRule = ActivityScenarioRule<LoginActivity>(LoginActivity::class.java)

    /**
     * Logintitledisplayingtest
     *This method tests that Title is displaying on screen.
     *
     */
    @Test
    fun loginTitleDisplayingTest() {
        Espresso.onView(withId(R.id.txt_login_title))
            .check(matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Logintitlesubtextdisplayingtest
     *This method tests that Title is not displaying on screen.
     *
     */
    @Test
    fun loginTitleSubTextDisplayingTest() {
        Espresso.onView(withId(R.id.txt_login_text))
            .check(matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Loginemaildisplayingtest
     *This method tests the Edittext for username is displaying on screen.
     */
    @Test
    fun loginEmailDisplayingTest() {
        Espresso.onView(withId(R.id.edt_user_name))            // withId(R.id.my_view) is a ViewMatcher
            .perform(ViewActions.click())               // click() is a ViewAction
            .check(matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Loginemailinput typedtest
     *This method tests the Edittext of username is allowing input from the keyboard.
     */
    @Test
    fun loginEmailInputTypedTest() {
        Espresso.onView(withId(R.id.edt_user_name))
            .perform(ViewActions.typeText(EMAIL_))
    }

    /**
     * Loginemailerrortextnotdisplayingtest
     *When user entered invalid data as per the validations, then only It will be visible on screen.
     */
    @Test
    fun loginEmailErrorTextNotDisplayingTest() {
        Espresso.onView(withId(R.id.username_error))
            .check(matches(CoreMatchers.not(ViewMatchers.isDisplayed())))
    }

    /**
     * loginEmailErrorDisplayingOnScreenTest
     *this method test for error Email text is matching or not
     */
    @Test
    fun loginEmailErrorDisplayingOnScreenTest() {
        Espresso.onView(withId(R.id.username_error))
            .check(matches(ViewMatchers.withText(R.string.email_error)))
    }

    /**
     * Loginpassworddisplayingtest
     *This method tests the Edittext for password is displaying on screen.
     */
    @Test
    fun loginPasswordDisplayingTest() {
        Espresso.onView(withId(R.id.edt_login_password))            // withId(R.id.my_view) is a ViewMatcher
            .perform(ViewActions.click())               // click() is a ViewAction
            .check(matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Loginpasswordinput typedtest
     *This method tests the Edittext of password is allowing input from the keyboard.
     */
    @Test
    fun loginPasswordInputTypedTest() {
        Espresso.onView(withId(R.id.edt_login_password))
            .perform(ViewActions.typeText(TEXT))
    }

    /**
     * Loginpassworderrortextnotdisplayingtest
     *When user entered invalid data as per the validations, then only It will be visible on screen.
     */
    @Test
    fun loginPasswordErrorTextNotDisplayingTest() {
        Espresso.onView(withId(R.id.login_password_error))
            .check(matches(CoreMatchers.not(ViewMatchers.isDisplayed())))
    }

    /**
     * loginPasswordErrorDisplayingOnScreenTest
     *this method test for error Password text is matching or not
     */
    @Test
    fun loginPasswordErrorDisplayingOnScreenTest() {
        Espresso.onView(withId(R.id.login_password_error))
            .check(matches(ViewMatchers.withText(R.string.pwd_error)))
    }

    /**
     * Loginforgotpassworddisplayingonscreentest
     *This method tests the Logo Displaying on screen and click action also working.
     */
    @Test
    fun loginForgotPasswordDisplayingOnScreenTest() {
        Espresso.onView(withId(R.id.txt_forgot_Password))
            .check(matches(ViewMatchers.isDisplayed()))
            .perform(ViewActions.click())
    }

    /**
     * Loginbuttondisplayingtest
     *This method tests the Login button is Displaying on the screen. And also not enabled. because this button will enable when user enter
     * valid Email.
     */
    @Test
    fun loginButtonDisplayingTest() {
        Espresso.onView(withId(R.id.btn_login))
            .perform(ViewActions.click())
            .check(matches(ViewMatchers.isDisplayed()))
            .check(matches(CoreMatchers.not(ViewMatchers.isEnabled())))
    }

    /**
     * Registerbuttondisplayingtest
     *This method tests the Login button is Displaying on the screen. And also not enabled. And can be clicked.
     *
     */
    @Test
    fun registerButtonDisplayingTest() {
        Espresso.onView(withId(R.id.btn_login_register))
            .check(matches(ViewMatchers.isDisplayed()))
            .perform(ViewActions.click())
    }

}