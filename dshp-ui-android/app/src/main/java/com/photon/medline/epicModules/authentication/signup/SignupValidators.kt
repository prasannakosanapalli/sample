package com.photon.medline.epicModules.authentication.signup

import java.util.regex.Pattern

/**
 * Created by Vishal
 *  This is Login validators class that only handle login related validations
 */
object SignupValidators {
    /**
     * Is valid mobile
     *
     * @param phone
     * @return
     */
    fun isValidMobile(phone: String): Boolean {
        return if (!Pattern.matches("[a-zA-Z]+", phone)) {
            phone.length == 10
        } else false
    }

    /**
     * Is valid customer number
     *
     * @param phone
     * @return
     */
    fun isValidCustomerNumber(customerNumber: String): Boolean {
        return customerNumber.length == 7
    }

    /**
     * Is blank
     *
     * @param value
     * @return
     */
    fun isBlank(value: String?): Boolean {
        return value?.isNotEmpty() ?: return false
    }

    /**
     * Regexx first last name
     *
     * @param text
     * @return
     */
    fun regexxFirstLastName(text: String): Boolean {
        val pattern = Pattern.compile("[^a-zA-Z]")
        val matcher = pattern.matcher(text)
        return matcher.find()
    }

    /**
     * Regexx first last name for testing
     *
     * @param text
     * @return
     */
    fun regexxFirstLastNameForTesting(text: String): Boolean {
        val pattern = Pattern.compile("[a-zA-Z]{3,30}")
        val matcher = pattern.matcher(text)
        return matcher.find()
    }
}