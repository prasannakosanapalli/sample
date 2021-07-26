package com.photon.medline.utilities

import java.util.regex.Matcher
import java.util.regex.Pattern

object UIUtils {
    val emailPattern = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" +
            "\\@" +
            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
            "(" +
            "\\." +
            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
            ")+"
    val passwordPattern =
        "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#\$%!\\-_?&])(?=\\S+\$).{8,}"
    val special = Pattern.compile("(.*[:?!@#$%^&*()].*)")
    val regex = "(.*[A-Z].*)"
    val emailAddressPattern = Pattern.compile(emailPattern

    )

    /**
     * Is valid password
     * @param password
     * @return
     */
    fun isValidPassword(password: String): Boolean {
        val pattern: Pattern
        val matcher: Matcher
        pattern = Pattern.compile(passwordPattern)
        matcher = pattern.matcher(password)
        return matcher.matches()
    }

    /**
     * Text contain upper case
     *
     * @param checkUpperCaseString
     * @return
     */
    fun textContainUpperCase(checkUpperCaseString: String): Boolean {
        val pattern = Pattern.compile(regex)
        val containsNumber = pattern.matcher(checkUpperCaseString).matches()
        return containsNumber
    }

    /**
     * Text contain special character
     *
     * @param checkSpecialCharString
     * @return
     */
    fun textContainSpecialCharacter(checkSpecialCharString: String): Boolean {

        val hasSpecial = special.matcher(checkSpecialCharString)
        return hasSpecial.find()
    }

    /**
     * Text contain number character
     *
     * @param checkDigitString
     * @return
     */
    fun textContainNmberCharacter(checkDigitString: String): Boolean {
        val digit = Pattern.compile("(.*\\d.*)")
        val hasSpecial = digit.matcher(checkDigitString)
        return hasSpecial.find()
    }

    fun textLengthMInEightDigit(password: String): Boolean {
        return password.length > 7
    }

    fun isValidEmail(email: String): Boolean {
        return emailAddressPattern.matcher(email).matches()
    }

    /**
     * Is valid password
     * @param password
     * @return
     */
    fun isValidPasswordLogin(password: String): Boolean {
        return password.length > 0
    }
}