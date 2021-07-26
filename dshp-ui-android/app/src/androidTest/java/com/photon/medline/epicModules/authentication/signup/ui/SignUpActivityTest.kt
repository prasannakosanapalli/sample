package com.photon.medline.epicModules.authentication.signup.ui

import androidx.test.espresso.Espresso
import androidx.test.espresso.action.ViewActions.typeText
import androidx.test.espresso.assertion.ViewAssertions
import androidx.test.espresso.matcher.ViewMatchers
import androidx.test.ext.junit.rules.ActivityScenarioRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.photon.medline.R
import com.photon.medline.utilities.*
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Created by Ashutosh Srivastava on 26-02-2021
 * Copyright(c) 2021 .
 */
@RunWith(AndroidJUnit4::class)
class SignUpActivityTest {
    @get:Rule
    var activityScenarioRule =
        ActivityScenarioRule<SignUpActivity>(SignUpActivity::class.java)

    /**
     * Txt register top
     * this test for checking view is visible or not
     */
    @Test
    fun txtRegisterTop() {
        Espresso.onView(ViewMatchers.withId(R.id.txt_register_top))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Txt register line
     * test for view is visible or not for text description
     */
    @Test
    fun txtRegisterLine() {
        Espresso.onView(ViewMatchers.withId(R.id.txt_register_line))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Newpassworddisplayingonscreentest
     *this method test for new password view is visible or not
     * This method tests the Edittext is allowing input from the keyboard.
     */
    @Test
    fun newpasswordDisplayingOnScreenTest() {
        Espresso.onView(ViewMatchers.withId(R.id.edt_password1))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Newpassworderrordisplayingonscreentest
     *this method test for error new password text is matching or not
     */
    @Test
    fun newpassworderrorDisplayingOnScreenTest() {
        Espresso.onView(ViewMatchers.withId(R.id.txt_password1))
            .check(ViewAssertions.matches(ViewMatchers.withText(R.string.password_error)))
    }

    /**
     * Confirmpassworddisplayingonscreentest
     *this method test for confirm password view is visible or not
     * This method tests the Edittext is allowing input from the keyboard.
     */
    @Test
    fun confirmpasswordDisplayingOnScreenTest() {
        Espresso.onView(ViewMatchers.withId(R.id.edt_cpassword1))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Confirmpassworderrordisplayingonscreentest
     *this method test for error confirm password text is matching or not
     */
    @Test
    fun confirmpassworderrorDisplayingOnScreenTest() {
        Espresso.onView(ViewMatchers.withId(R.id.txt_cpassword1))
            .check(ViewAssertions.matches(ViewMatchers.withText(R.string.confirm_password_error)))
    }

    /**
     * Txtresetpasswordclicklistenerdisplayingonscreentest
     *this method test for title reset password submit textview is visible or not
     */
    @Test
    fun txtresetpasswordclicklistenerDisplayingOnScreenTest() {
        Espresso.onView(ViewMatchers.withId(R.id.txt_register))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Edtfirst
     * check first name view is visible or not
     * and type first name
     */
    @Test
    fun edtfirst() {
        Espresso.onView(ViewMatchers.withId(R.id.edt_first))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Txtfirstnameerror
     * check visibility
     */
    @Test
    fun txtfirstnameerror() {
        Espresso.onView(ViewMatchers.withId(R.id.txt_firstname_error))
            .check(ViewAssertions.matches(ViewMatchers.withText(R.string.first_name_error)))
    }

    /**
     * edtlastName
     * check first name view is visible or not
     * and type last name
     */
    @Test
    fun edtlastName() {
        Espresso.onView(ViewMatchers.withId(R.id.edt_last))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Txtlastnameerror
     *check visibility
     */
    @Test
    fun txtlastnameerror() {
        Espresso.onView(ViewMatchers.withId(R.id.txt_lastname_error))
            .check(ViewAssertions.matches(ViewMatchers.withText(R.string.last_name_error)))
    }

    /**
     * edtcustno
     *check visibility
     * and type customer number
     */
    @Test
    fun edtcustno() {
        Espresso.onView(ViewMatchers.withId(R.id.edt_custno))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    /**
     * Txtcustnoerror
     *check visibility and match test
     */
    @Test
    fun txtcustnoerror() {
        Espresso.onView(ViewMatchers.withId(R.id.txt_custno_error))
            .check(ViewAssertions.matches(ViewMatchers.withText(R.string.customer_error)))
    }

    /**
     * edtphoneno
     *check visibility
     * and type phone number
     */
    @Test
    fun edtphoneno() {
        Espresso.onView(ViewMatchers.withId(R.id.edt_phone_no))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    /**
     * txtphoneno
     *check visibility and match test
     */
    @Test
    fun txtphoneno() {
        Espresso.onView(ViewMatchers.withId(R.id.txt_phone_no))
            .check(ViewAssertions.matches(ViewMatchers.withText(R.string.phone_no_error)))
    }

    /**
     * edtemail
     *check visibility
     * and type email address
     */
    @Test
    fun edtemail() {
        Espresso.onView(ViewMatchers.withId(R.id.edt_email))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    /**
     * txtemail
     *check visibility and match test
     */
    @Test
    fun txtemail() {
        Espresso.onView(ViewMatchers.withId(R.id.txt_email))
            .check(ViewAssertions.matches(ViewMatchers.withText(R.string.email_error)))
    }

    @Test
    fun fillAllTest() {
        Espresso.onView(ViewMatchers.withId(R.id.edt_first)).perform(typeText(FIRST_NAMES))
        Espresso.onView(ViewMatchers.withId(R.id.edt_last)).perform(typeText(LAST_NAMES))
        Espresso.onView(ViewMatchers.withId(R.id.edt_custno)).perform(typeText(CUSTOMER_NUMBERS))
        Espresso.onView(ViewMatchers.withId(R.id.edt_phone_no)).perform(typeText(PHONENUMBER))
        Espresso.onView(ViewMatchers.withId(R.id.edt_email)).perform(typeText(EMAILS))
        Espresso.onView(ViewMatchers.withId(R.id.edt_password1)).perform(typeText(PASSWORDS))
        Espresso.onView(ViewMatchers.withId(R.id.edt_cpassword1)).perform(typeText(PASSWORDS))
        Espresso.onView(ViewMatchers.withId(R.id.txt_email))
            .check(ViewAssertions.matches(ViewMatchers.withText(R.string.email_error)))
    }
}