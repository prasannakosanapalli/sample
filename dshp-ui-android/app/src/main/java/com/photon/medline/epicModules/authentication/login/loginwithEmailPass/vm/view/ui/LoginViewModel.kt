package com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.view.ui

import androidx.databinding.Bindable
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.photon.medline.BR
import com.photon.medline.base.BaseViewModel
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.local.LoginUserDao
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model.LoginPayload
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model.LoginResponse
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.repository.LoginRepository
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

/*
 * Created by Romesh
 *  Its login View Model class handing operations related to login feature
 *  via username and password only
 */
@HiltViewModel
class LoginViewModel @Inject constructor(
    private val loginRepository: LoginRepository,
    private val loginUserDao: LoginUserDao
) :
    BaseViewModel() {
    private val TAG: String? = LoginViewModel::class.simpleName

    @Bindable
    var loginEmail: Boolean = false

    @Bindable
    var loginPassword: Boolean = false

    @Bindable
    var enableDisableLoginButton: Boolean = false

    @Bindable
    var hideShowTogglePassword: Boolean = false
    var loginModel = LoginPayload()
    private val _connection = MutableLiveData<Boolean>() //to check internet connection
    val _message = MutableLiveData<BaseNetworkCallbackHandler<LoginResponse>>()
    var mutableLiveData = MutableLiveData<Int>()

    @Bindable
    var passwordVisibility: Boolean = false
    var progressEnable: Boolean = false
    var message: String? = ""

    //this method called when changes happened for Email edit text
    fun onLoginEmailTextChangeListener(
        s: CharSequence, start: Int,
        before: Int, count: Int
    ) {
        if (s.toString().isEmpty()) { //checking if email field is not empty
            loginEmail = false
        } else { //we are checking for Email is valid
            loginEmail = !UIUtils.isValidEmail(s.toString())
        }
        notifyPropertyChanged(BR.loginEmail)
        loginModel.Email = s.toString() //saving the changes to model class
        enableDisableLoginButton() //If email is correct then will check for enabling button of Login
    }

    //this method called when changes happened for Password edittext
    fun onLoginPasswordTextChangeListener(
        s: CharSequence, start: Int,
        before: Int, count: Int
    ) {
        if (s.toString().isEmpty()) {
            loginPassword = false
            passwordVisibility = false
        } else {
            loginPassword = !UIUtils.isValidPasswordLogin(s.toString())
            passwordVisibility = true
        }
        notifyPropertyChanged(BR.loginPassword)
        notifyPropertyChanged(BR.passwordVisibility)

        loginModel.Password = s.toString()
        enableDisableLoginButton()
    }

    fun enableDisableLoginButton() {
        if (UIUtils.isValidEmail(loginModel.Email) && UIUtils.isValidPasswordLogin(loginModel.Password)) {
            enableDisableLoginButton = true
        } else {
            enableDisableLoginButton = false
        }
        notifyPropertyChanged(BR.enableDisableLoginButton)
    }

    //this method called when Forgot password button clicked.
    fun onForgotPasswordButtonClick() {
        try {
            mutableLiveData.postValue(Constants.FORGOT_PASSWORD)
        } catch (E: Exception) {
            TAG?.let { AppLogger.error(it, "LoginViewModel $E") }
        }
    }

    /**
     * Hide show password click for password toggle button
     * @param hideShowTogglePassword change the status
     *
     */
    fun hideShowPasswordClick() {
        if (!loginModel.Password.isEmpty()) {
            hideShowTogglePassword = !hideShowTogglePassword
            notifyPropertyChanged(BR.hideShowTogglePassword)
        }
    }

    //this method called when registration button clicked.
    fun onLoginButtonClick() {
        try {
            if (loginModel.Email.isEmpty() &&
                loginModel.Password.isEmpty()
            ) {
                return
            } else {
                mutableLiveData.postValue(Constants.HIDE_KEYBOARD)
                progressEnable = true
                mutableLiveData.postValue(Constants.PROGRESS_ENABLE)
                userLoginApiCall(loginModel)
            }
        } catch (e: Exception) {
            TAG?.let { AppLogger.error(it, "LoginViewModel $e") }
        }
    }

    //when user click on the registration button this method will be called from the Activity.
    fun userLoginApiCall(loginModel: LoginPayload) {
        viewModelScope.launch {
            try {
                loginRepository.userLogin(loginModel).onStart {
                }.collect {
                    progressEnable = false
                    mutableLiveData.postValue(Constants.PROGRESS_ENABLE)
                    if (it.status == Status.SUCCESS) {
                        if (it.data?.data?.lastLogOn != null)
                            mutableLiveData.postValue(Constants.DASHBOARD)
                        else
                            mutableLiveData.postValue(Constants.RESET_PASSWORD)
                        _message.postValue(it)
                    } else {
                        message = it.message
                        _message.postValue(it)
                    }
                }
            } catch (e: Exception) {
                TAG?.let { AppLogger.error(it, "LoginViewModel $e") }
            }
        }
    }

    /**
     * On click reset password to
     *navigate reset password screen
     */
    fun onClickResetPassword() {
        mutableLiveData.postValue(Constants.RESET_PASSWORD)
    }

    /**
     * On click register
     *navigate to signup screen
     */
    fun onClickRegister() {
        mutableLiveData.postValue(Constants.REGISTER)
    }
}