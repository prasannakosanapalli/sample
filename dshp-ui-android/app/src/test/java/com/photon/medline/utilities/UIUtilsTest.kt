package com.photon.medline.utilities

import com.google.common.truth.Truth.assertThat
import org.junit.Test

/**
 * Created by PAVANI P on 15/3/2021.
 */
class UIUtilsTest {
    /**
     * Incorrect syntax for email where @ missed returns false
     *This test case verifies the wrong email id syntax returns false.
     */
    @Test
    fun incorrectsyntaxforemailwheremissedreturnsfalse() {
        val result = UIUtils.isValidEmail(INVALID_EMAIL_1)
        assertThat(result).isFalse()
    }

    /**
     * Incorrect syntax for email where dot is missed returns true
     *This test case verifies the wrong email id syntax returns false.
     */
    @Test
    fun incorrectsyntaxforemailwheredotismissedreturnstrue() {
        val result = UIUtils.isValidEmail(INVALID_EMAIL_2)
        assertThat(result).isFalse()
    }

    /**
     * Empty email returns true
     *This test case verifies the empty string value returns false.
     */
    @Test
    fun emptyemailreturnstrue() {
        val result = UIUtils.isValidEmail(BLANK_EMAIL)
        assertThat(result).isFalse()
    }

    /**
     * Correct syntax for email returns true
     *This test case verifies the correct Email syntax will returns true.
     */
    @Test
    fun correctsyntaxforemailreturnstrue() {
        val result = UIUtils.isValidEmail(VALID_EMAIL)
        assertThat(result).isTrue()
    }

    @Test
    fun passworddoesnothaveatleast1capitalletterreturnsfalse() {
        val result = UIUtils.isValidPassword(INVALID_PASSWORD_1)
        assertThat(result).isFalse()
    }

    @Test
    fun passworddoesnothaveatleast1specialcharacterreturnsfalse() {
        val result = UIUtils.isValidPassword(INVALID_PASSWORD_2)
        assertThat(result).isFalse()
    }

    @Test
    fun passworddoesnothaveatleast1digitreturnsfalse() {
        val result = UIUtils.isValidPassword(INVALID_PASSWORD_3)
        assertThat(result).isFalse()
    }

    @Test
    fun passworddoesnothavelengthof8returnsfalse() {
        val result = UIUtils.isValidPassword(INVALID_PASSWORD_4)
        assertThat(result).isFalse()
    }

    @Test
    fun validpasswordhaveuppercaseletterspecialcharacterdigitandlengthgreaterthanorequalsto8returntrue() {
        val result = UIUtils.isValidPassword(INVALID_PASSWORD_5)
        assertThat(result).isTrue()
    }
}