package com.photon.medline.utilities

import android.text.SpannableString
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.style.ClickableSpan

/**
 *Created by Ashutosh Srivastava on 23-02-2021
 * Copyright(c) 2021 Photon.
 */
object StringUtils {
    /**
     * Get spannable string
     *this method is called for making two spannable text and
     * perform click listener
     * @param privacyPolicy
     * @param termAndCondition
     * @param privacyPolicyText
     * @param termAndConditionText
     * @param finalString
     * @return
     */
    fun getSpannableString(
            privacyPolicy: ClickableSpan,
            termAndCondition: ClickableSpan,
            privacyPolicyText: String,
            termAndConditionText: String,
            finalString: String
    ): SpannableStringBuilder {
        val spannableStringBuilder = SpannableStringBuilder()
        val titlePageLink = finalString
        val privacyPolicyTextLink = titlePageLink.substring(
                0,
                titlePageLink.indexOf(privacyPolicyText) + privacyPolicyText.length + 1
        )
        val remainingText =
                titlePageLink.substring(privacyPolicyTextLink.length, titlePageLink.length)
        val termAndConditionTextLink =
                remainingText.substring(0, remainingText.indexOf(termAndConditionText))
        val lastText = titlePageLink.substring(
                (privacyPolicyTextLink.length + termAndConditionTextLink.length),
                titlePageLink.length
        )
        spannableStringBuilder.append(
            getSpannableString(
                privacyPolicy,
                privacyPolicyTextLink,
                privacyPolicyText
            )
        ).append(termAndConditionTextLink)
            .append(getSpannableString(termAndCondition, lastText, termAndConditionText))
        return spannableStringBuilder
    }

    /**
     * Get spannable string
     *this method is called for spannable text and perform to
     * click listner
     * @param clickableSpan
     * @param toSpan
     * @param toFindIndex
     * @return
     */
    fun getSpannableString(
        clickableSpan: ClickableSpan,
        toSpan: String,
        toFindIndex: String
    ): SpannableString {
        val spannableString = SpannableString(toSpan)
        var spanStartIndex = spannableString.toString().indexOf(toFindIndex)
        if (spanStartIndex == -1) spanStartIndex = spannableString.length - toFindIndex.length
        val endIndex = spanStartIndex + toFindIndex.length
        spannableString.setSpan(
            clickableSpan,
            spanStartIndex,
            endIndex,
            Spanned.SPAN_INCLUSIVE_INCLUSIVE
        )
        return spannableString
    }
}