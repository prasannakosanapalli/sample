package com.photon.medline.epicModules.authentication.resetpassword.ui

import androidx.databinding.Bindable
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.google.firebase.crashlytics.internal.Logger
import com.photon.medline.BR
import com.photon.medline.base.BaseViewModel
import com.photon.medline.epicModules.authentication.resetpassword.model.ResetPasswordRequest
import com.photon.medline.epicModules.authentication.resetpassword.model.ResetPasswordResponse
import com.photon.medline.epicModules.authentication.resetpassword.repository.ResetPasswordRepository
import com.photon.medline.network.BaseNetworkCallbackHandler
import com.photon.medline.utilities.AppLogger
import com.photon.medline.utilities.Constants
import com.photon.medline.utilities.Status
import com.photon.medline.utilities.UIUtils
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.onStart
import kotlinx.coroutines.launch
import javax.inject.Inject

/**
 * Reset password view model
 *
 * @property repository
 * @constructor Create empty Reset password view model
 */
@HiltViewModel
class ResetPasswordViewModel @Inject constructor(private val repository: ResetPasswordRepository) :
    BaseViewModel() {
    @Bindable
    var password: Boolean = false

    @Bindable
    var confirmPassword: Boolean = false

    @Bindable
    var hideShowTogglePassword: Boolean = false

    @Bindable
    var hideShowToggleConfirmPassword: Boolean = false
    var resetPasswordModel =
        ResetPasswordRequest()

    @Bindable
    var enableDisableSubmitButton: Boolean = false

    @Bindable
    var succcessPageEnable: Boolean = false
    var mutableLiveData = MutableLiveData<Int>()

    @Bindable
    var passwordVisibility: Boolean = false

    @Bindable
    var confirmPasswordVisibility: Boolean = false

    @Bindable
    var minimumEightChar: Boolean = false

    @Bindable
    var oneSpecialCaharcter: Boolean = false

    @Bindable
    var oneNumber: Boolean = false

    @Bindable
    var oneUpperCase: Boolean = false
    var progressEnable: Boolean = false
    val _message = MutableLiveData<BaseNetworkCallbackHandler<ResetPasswordResponse>>()

    /**
     * On password text change listener
     *
     * @param s
     * @param start
     * @param before
     * @param count
     */
    fun onPasswordTextChangeListener(
        s: CharSequence, start: Int,
        before: Int, count: Int
    ) {
        if (s.toString().isEmpty()) {
            password = false
            passwordVisibility = false
        } else {
            password = !UIUtils.isValidPassword(s.toString())
            passwordVisibility = true
        }
        notifyValidation(s.toString())
        notifyPropertyChanged(BR.password)
        notifyPropertyChanged(BR.passwordVisibility)
        resetPasswordModel.password = s.toString()
        enableDisableSubmitButton()
    }

    fun notifyValidation(password: String) {
        if (password.isEmpty()) {
            minimumEightChar = false
            oneSpecialCaharcter = false
            oneNumber = false
            oneUpperCase = false
            notifyPropertyChanged(BR.minimumEightChar)
            notifyPropertyChanged(BR.oneSpecialCaharcter)
            notifyPropertyChanged(BR.oneNumber)
            notifyPropertyChanged(BR.oneUpperCase)
        } else {
            minimumEightChar = UIUtils.textLengthMInEightDigit(password)
            notifyPropertyChanged(BR.minimumEightChar)
            oneSpecialCaharcter = UIUtils.textContainSpecialCharacter(password)
            notifyPropertyChanged(BR.oneSpecialCaharcter)
            oneNumber = UIUtils.textContainNmberCharacter(password)
            notifyPropertyChanged(BR.oneNumber)
            oneUpperCase = UIUtils.textContainUpperCase(password)
            notifyPropertyChanged(BR.oneUpperCase)
        }
    }

    /**
     * On confirm password text change listener
     *
     * @param s
     * @param start
     * @param before
     * @param count
     */
    fun onConfirmPasswordTextChangeListener(
        s: CharSequence, start: Int,
        before: Int, count: Int
    ) {
        if (s.toString().isEmpty()) {
            confirmPassword = false
            confirmPasswordVisibility = false
        } else if (!UIUtils.isValidPassword(s.toString())) {
            confirmPassword = true
            confirmPasswordVisibility = true
        } else {
            confirmPassword = !s.toString().equals(resetPasswordModel.password)
            confirmPasswordVisibility = true
        }
        notifyPropertyChanged(BR.confirmPassword)
        notifyPropertyChanged(BR.confirmPasswordVisibility)
        resetPasswordModel.confirmPassword = s.toString()
        enableDisableSubmitButton()
    }

    /**
     * Enable disable submit button
     *
     */
    fun enableDisableSubmitButton() {
        if (UIUtils.isValidPassword(resetPasswordModel.password) &&
            UIUtils.isValidPassword(resetPasswordModel.confirmPassword) &&
            resetPasswordModel.password.equals(resetPasswordModel.confirmPassword)
        ) {
            enableDisableSubmitButton = true
            notifyPropertyChanged(BR.enableDisableSubmitButton)
        } else {
            enableDisableSubmitButton = false
            notifyPropertyChanged(BR.enableDisableSubmitButton)
        }
    }

    /**
     * Hide show password click for password toggle button
     * @param hideShowTogglePassword change the status
     *
     */
    fun hideShowPasswordClick() {
        if (!resetPasswordModel.password.isEmpty()) {
            hideShowTogglePassword = !hideShowTogglePassword
            notifyPropertyChanged(BR.hideShowTogglePassword)
        }
    }

    /**
     * Hide show confirm password click for confirm password toggle button
     * @param hideShowToggleConfirmPassword change the status of this flag to show toggle button
     *
     */
    fun hideShowConfirmPasswordClick() {
        if (!resetPasswordModel.confirmPassword.isEmpty()) {
            hideShowToggleConfirmPassword = !hideShowToggleConfirmPassword
            notifyPropertyChanged(BR.hideShowToggleConfirmPassword)
        }
    }

    /**
     * Reset password button click to
     * check validation to password and new password
     * after that post data into server
     * and change the status @param succcessPageEnable to enable success page
     */
    fun resetPasswordClick() {
        if (resetPasswordModel.password.isEmpty()) {
            password = true
            notifyPropertyChanged(BR.password)
            return
        }
        if (resetPasswordModel.confirmPassword.isEmpty()) {
            confirmPassword = true
            notifyPropertyChanged(BR.confirmPassword)
            return
        }
        progressEnable = true
        mutableLiveData.postValue(Constants.PROGRESS_ENABLE)
        apiCall()
    }

    fun apiCall() {
        viewModelScope.launch {
            try {
                repository.resetPassword(resetPasswordModel).onStart {
                }.collect {
                    progressEnable = false
                    mutableLiveData.postValue(Constants.PROGRESS_ENABLE)
                    if (it.status == Status.SUCCESS) {
                        succcessPageEnable = true
                        notifyPropertyChanged(BR.succcessPageEnable)
                        //  _message.postValue(it)
                    } else {
                        _message.postValue(it)
                    }
                }
            } catch (e: Exception) {
                Logger.TAG.let { AppLogger.error(it, "Login $e") }
            }
        }
    }

    /**
     * Close activity
     *
     */
    fun closeActivity() {
        mutableLiveData.postValue(Constants.BACK_PRESSED)
    }
}