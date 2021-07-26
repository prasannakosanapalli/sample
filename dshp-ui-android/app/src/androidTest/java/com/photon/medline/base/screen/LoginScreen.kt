package com.photon.medline.base.screen

import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions
import androidx.test.espresso.assertion.ViewAssertions
import androidx.test.espresso.matcher.ViewMatchers.*
import com.photon.medline.R
import com.photon.medline.utilities.UserCredentialsInfo
import com.photon.medline.utilities.Utils

object LoginScreen {

    fun checkUserNameVisible() {
        Utils.waitFor(50)
        onView(withId(R.id.edt_user_name))
            .check(ViewAssertions.matches(isDisplayed()))
    }

    fun checkPasswordVisible() {
        Utils.waitFor(50)
        onView(withId(R.id.edt_login_password))
            .check(ViewAssertions.matches(isDisplayed()))
    }

    fun fillUserName(username: String) {
        Utils.waitFor(50)
        onView(withId(R.id.edt_user_name))
            .check(ViewAssertions.matches(isDisplayed()))
            .perform(ViewActions.typeText(username))
    }

    fun fillPassword(password: String) {
        Utils.waitFor(50)
        onView(withId(R.id.edt_login_password))
            .check(ViewAssertions.matches(isDisplayed()))
            .perform(ViewActions.typeText(password))
    }


    fun onClickLoginButton() {
        Utils.waitFor(50)
        onView(withId(R.id.btn_login))
            .check(ViewAssertions.matches(isEnabled()))
            .check(ViewAssertions.matches(isDisplayed()))
            .perform(ViewActions.click())
        Utils.waitFor(2000)
    }

    fun doLogin(username: String?, password: String?) {
        checkUserNameVisible()
        checkPasswordVisible()
        fillUserName(username?: UserCredentialsInfo.Username)
        fillPassword(password?: UserCredentialsInfo.Password)
        onClickLoginButton()
    }

    fun validateScreen() {
        checkUserNameVisible()
        checkPasswordVisible()

        Utils.waitFor(50)
        onView(withId(R.id.toolbar))
            .check(ViewAssertions.matches(isDisplayed()))

        Utils.waitFor(50)
        onView(withId(R.id.logo_login_screen))
            .check(ViewAssertions.matches(isDisplayed()))

        Utils.waitFor(50)
        onView(withId(R.id.txt_login_title))
            .check(ViewAssertions.matches(isDisplayed()))

        Utils.waitFor(50)
        onView(withId(R.id.txt_login_text))
            .check(ViewAssertions.matches(isDisplayed()))

        Utils.waitFor(50)
        onView(withId(R.id.txt_forgot_Password))
            .check(ViewAssertions.matches(isDisplayed()))

        Utils.waitFor(50)
        onView(withId(R.id.btn_login))
            .check(ViewAssertions.matches(isDisplayed()))

        Utils.waitFor(50)
        onView(withId(R.id.btn_login_register))
            .check(ViewAssertions.matches(isDisplayed()))
    }
}
