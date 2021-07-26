package com.photon.medline.epicModules.authentication.forgotpassword.view.ui

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
import com.photon.medline.databinding.ActivityForgotPasswordBinding
import com.photon.medline.utilities.*
import dagger.hilt.android.AndroidEntryPoint

/**
 *Created by Vishal S. on 11/3/2021.
 * Its Forgot Password Activity class handing operations related to forgot password feature
 *  via username only
 */
@AndroidEntryPoint
class ForgotPwdActivity : BaseActivity() {
    private val TAG: String? = ForgotPwdActivity::class.simpleName
    private lateinit var forgotPwdViewModel: ForgotPwdViewModel
    private lateinit var forgotPasswordBinding: ActivityForgotPasswordBinding
    private var customLoader = CustomLoader()
    override fun onCreate(savedInstanceState: Bundle?) {
        try {
            super.onCreate(savedInstanceState)
            window.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN)
            forgotPasswordBinding =
                DataBindingUtil.setContentView(this, R.layout.activity_forgot_password)
            forgotPwdViewModel = ViewModelProvider(this).get(ForgotPwdViewModel::class.java)

            forgotPasswordBinding.forgetpwdviewModel = forgotPwdViewModel
            customLoader = CustomLoader().getInstance()!!
            forgotPasswordBinding.edtForgotEmail.setOnEditorActionListener(TextView.OnEditorActionListener { v, actionId, event ->
                if (actionId == EditorInfo.IME_ACTION_DONE) {
                    v.hideKeyboard()
                    return@OnEditorActionListener true
                }
                false
            })

            forgotPwdViewModel.mutableLiveData.observe(this, Observer { result ->
                if (result == Constants.BACK_PRESSED) {
                    onBackPressed()
                } else if (result == Constants.HIDE_KEYBOARD) {
                    forgotPasswordBinding.btnForgetPassword.hideKeyboard()
                } else if (result == Constants.PROGRESS_ENABLE) {
                    if (forgotPwdViewModel.progressEnable) {
                        customLoader.showProgress(this)
                    } else {
                        customLoader.hideProgress()
                    }
                }
            })
            forgotPasswordBinding.btnForgetPassword.setOnEditorActionListener(TextView.OnEditorActionListener { v, actionId, event ->
                if (actionId == EditorInfo.IME_ACTION_DONE) {
                    v.hideKeyboard()
                    return@OnEditorActionListener true
                }
                false
            })
            subscribeUi()
        } catch (e: Exception) {
            TAG?.let { AppLogger.error(it, "ForgotPwdActivity $e") }
        }
    }

    private fun subscribeUi() {
        forgotPwdViewModel.message.observe(this, Observer { result ->
            if (result.status == Status.SUCCESS) {
                Toaster.showToast(
                    this,
                    getString(R.string.mailsent),
                    result.status,
                    Toast.LENGTH_SHORT
                )
            } else if (result.status == Status.ERROR) {
                Toaster.showToast(
                    this,
                    result.message,
                    result.status,
                    Toast.LENGTH_SHORT
                )
            }
        })
    }

    override fun onDestroy() {
        super.onDestroy()
        customLoader.hideProgress()
    }
}