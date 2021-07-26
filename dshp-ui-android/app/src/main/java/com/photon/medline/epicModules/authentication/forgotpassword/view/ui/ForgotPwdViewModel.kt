package com.photon.medline.epicModules.authentication.forgotpassword.view.ui

import androidx.databinding.Bindable
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.photon.medline.BR
import com.photon.medline.base.BaseViewModel
import com.photon.medline.epicModules.authentication.forgotpassword.data.model.ForgotPasswordPayload
import com.photon.medline.epicModules.authentication.forgotpassword.data.model.ForgotPasswordResponse
import com.photon.medline.epicModules.authentication.forgotpassword.data.repository.ForgotPwdRepository
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
 *Created by Vishal S. on 12/3/2021.
 * Its Forgot Password View Model class handing operations related to Forgot password feature
 *  via Email
 */
@HiltViewModel
class ForgotPwdViewModel @Inject constructor(private val forgotPwdRepository: ForgotPwdRepository) :
    BaseViewModel() {
    private val TAG: String? = ForgotPwdViewModel::class.simpleName

    @Bindable
    var forgetEmail: Boolean = false
    var progressEnable: Boolean = false

    @Bindable
    var enableDisableForgetPwdButton: Boolean = false
    var forgotPwdModel = ForgotPasswordPayload()

    @Bindable
    var successEmailEnable: Boolean = false
    var mutableLiveData = MutableLiveData<Int>()
    private val _message = MutableLiveData<BaseNetworkCallbackHandler<ForgotPasswordResponse>>()

    /**
     * On forget pwd email text change listener
     *
     * @param s
     * @param start
     * @param before
     * @param count
     */
    fun onForgetPwdEmailTextChangeListener(
        s: CharSequence, start: Int,
        before: Int, count: Int
    ) {
        if (s.toString().isEmpty()) {
            forgetEmail = false
            notifyPropertyChanged(BR.forgetEmail)
        } else if (UIUtils.isValidEmail(s.toString())) {
            forgetEmail = false
            notifyPropertyChanged(BR.forgetEmail)
        } else {
            forgetEmail = true
            notifyPropertyChanged(BR.forgetEmail)
        }
        forgotPwdModel.email = s.toString()
        enableDisableForgetPwdButton()
    }

    /**
     * Enable disable forget pwd button
     *
     */
    fun enableDisableForgetPwdButton() {
        if (UIUtils.isValidEmail(forgotPwdModel.email)) {
            enableDisableForgetPwdButton =
                true //If email is valid and password entered then we are enabling Login button
            notifyPropertyChanged(BR.enableDisableForgetPwdButton)
        } else {
            enableDisableForgetPwdButton =
                false //If Email or password is not valid then disabling Login button
            notifyPropertyChanged(BR.enableDisableForgetPwdButton)
        }
    }

    /**
     * On continue to login button click
     *
     */
    fun onContinueToLoginButtonClick() {
        mutableLiveData.postValue(Constants.BACK_PRESSED)
    }

    /**
     * Navigate to Login activity
     *
     */
    fun closeActivity() {
        mutableLiveData.postValue(Constants.BACK_PRESSED)
    }

    /**
     * On submit button click It will check for internet connection.
     * If connection is there It will call API.
     *
     */
    fun onSubmitButtonClick() {
        try {
            mutableLiveData.postValue(Constants.HIDE_KEYBOARD)
            if (forgotPwdModel.email.isEmpty()) {
                return
            } else {
                progressEnable = true
                mutableLiveData.postValue(Constants.PROGRESS_ENABLE)
                userForgerPwdApiCall(forgotPwdModel)
            }
        } catch (e: Exception) {
            TAG?.let { AppLogger.error(it, "Forgot Password  $e") }
        }
    }

    /**
     * User forger pwd api call
     *
     * @param forgotPwdModel
     */
    private fun userForgerPwdApiCall(forgotPwdModel: ForgotPasswordPayload) {
        viewModelScope.launch {
            try {
                forgotPwdRepository.forgotPassword(forgotPwdModel).onStart {
                }.collect {
                    progressEnable = false
                    mutableLiveData.postValue(Constants.PROGRESS_ENABLE)
                    if (it.status == Status.SUCCESS) {
                        //  _message.postValue(it)
                        successEmailEnable = true
                        notifyPropertyChanged(BR.successEmailEnable)
                    } else {
                        _message.postValue(it)
                    }
                }
            } catch (e: Exception) {
                TAG?.let { AppLogger.error(it, "ForgotPassword $e") }
            }
        }
    }

    val message = _message
}