package com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.view.ui

import android.content.Intent
import android.os.Bundle
import android.view.WindowManager
import android.view.inputmethod.EditorInfo
import android.widget.TextView
import android.widget.Toast
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.photon.medline.R
import com.photon.medline.base.BaseActivity
import com.photon.medline.databinding.ActivityLoginBinding
import com.photon.medline.epicModules.authentication.forgotpassword.view.ui.ForgotPwdActivity
import com.photon.medline.epicModules.authentication.resetpassword.ui.ResetPasswordActivity
import com.photon.medline.epicModules.authentication.signup.ui.SignUpActivity
import com.photon.medline.epicModules.dashboard.DashBoardActivity
import com.photon.medline.utilities.*
import dagger.hilt.android.AndroidEntryPoint

/*
 * Created by Romesh
 *  Its login LoginActivity class handing operations related to login feature
 *  via username and password only
 */
@AndroidEntryPoint
class LoginActivity : BaseActivity() {
    private val TAG: String? = LoginActivity::class.simpleName
    private lateinit var loginViewModel: LoginViewModel
    private lateinit var loginBinding: ActivityLoginBinding
    private var customLoader = CustomLoader()
    override fun onCreate(savedInstanceState: Bundle?) {
        try {
            super.onCreate(savedInstanceState)
            window.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN)
            loginBinding = DataBindingUtil.setContentView(this, R.layout.activity_login)
            loginViewModel = ViewModelProvider(this).get(LoginViewModel::class.java)
            loginBinding.loginviewModel = loginViewModel
            customLoader = CustomLoader().getInstance()!!
            loginViewModel.mutableLiveData.observe(this, Observer { result ->

                if (result == Constants.REGISTER) {
                    startActivity(Intent(this, SignUpActivity::class.java))
                } else if (result == Constants.RESET_PASSWORD) {
                    startActivity(Intent(this, ResetPasswordActivity::class.java))
                } else if (result == Constants.FORGOT_PASSWORD) {
                    startActivity(Intent(this, ForgotPwdActivity::class.java))
                } else if (result == Constants.DASHBOARD) {
                    startActivity(Intent(this, DashBoardActivity::class.java))
                    finish()
                } else if (result == Constants.HIDE_KEYBOARD) {
                    loginBinding.btnLogin.hideKeyboard()
                } else if (result == Constants.PROGRESS_ENABLE) {
                    if (loginViewModel.progressEnable) {
                        customLoader.showProgress(this)
                    } else {
                        customLoader.hideProgress()
                    }
                }
            })
            loginBinding.edtLoginPassword.setOnEditorActionListener(TextView.OnEditorActionListener { v, actionId, event ->
                if (actionId == EditorInfo.IME_ACTION_DONE) {
                    v.hideKeyboard()
                    return@OnEditorActionListener true
                }
                false
            })
            subscribeUi()
        } catch (e: Exception) {
            TAG?.let { AppLogger.error(it, "Login $e") }
        }
    }

    private fun subscribeUi() {
        loginViewModel._message.observe(this, Observer { result ->
            if (result.status == Status.ERROR) {
                try {
                    val message = loginViewModel.message
                    Toaster.showToast(this, message, result.status, Toast.LENGTH_SHORT)
                } catch (e: Exception) {
                    TAG?.let { AppLogger.error(it, "Login $e") }
                }
            }
        })
    }

    override fun onPause() {
        super.onPause()
        customLoader.hideProgress()
    }

    override fun onDestroy() {
        super.onDestroy()
        customLoader.hideProgress()
    }
}