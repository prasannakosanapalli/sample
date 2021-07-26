package com.photon.medline.epicModules.authentication.resetpassword.ui

import android.os.Bundle
import android.view.inputmethod.EditorInfo
import android.widget.TextView.OnEditorActionListener
import android.widget.Toast
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.google.gson.Gson
import com.photon.medline.R
import com.photon.medline.base.BaseActivity
import com.photon.medline.databinding.ActivityResetPasswordBinding
import com.photon.medline.epicModules.authentication.signup.data.model.SignUpResponse
import com.photon.medline.utilities.*
import dagger.hilt.android.AndroidEntryPoint

/**
 * Reset password activity
 *
 * @constructor Create empty Reset password activity
 */
@AndroidEntryPoint
class ResetPasswordActivity : BaseActivity() {
    private lateinit var binding: ActivityResetPasswordBinding
    private lateinit var viewModel: ResetPasswordViewModel
    private var customLoader = CustomLoader()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_reset_password)
        viewModel = ViewModelProvider(this).get(ResetPasswordViewModel::class.java)
        binding.viewModel = viewModel
        /* viewModel.resetPasswordModel.email = intent.getStringExtra(Constants.EMAIL)!!
         viewModel.resetPasswordModel.token = intent.getStringExtra(Constants.TOKEN)!!*/
        customLoader = CustomLoader().getInstance()!!
        observable()
    }

    fun observable() {
        viewModel.mutableLiveData.observe(this, Observer {
            if (it == Constants.BACK_PRESSED) {
                onBackPressed()
            } else if (it == Constants.PROGRESS_ENABLE) {
                if (viewModel.progressEnable) {
                    customLoader.showProgress(this)
                } else {
                    customLoader.hideProgress()
                }
            }
        })

        binding.confirmPassword.setOnEditorActionListener(OnEditorActionListener { v, actionId, event ->
            if (actionId == EditorInfo.IME_ACTION_DONE) {
                v.hideKeyboard()
                return@OnEditorActionListener true
            }
            false
        })
        viewModel._message.observe(this, Observer { result ->
            if (result.status == Status.SUCCESS) {
                Toaster.showToast(this, result.data?.message, result.status, Toast.LENGTH_SHORT)
            } else if (result.status == Status.ERROR) {
                try {
                    val message: SignUpResponse = Gson().fromJson(
                        result.message,
                        SignUpResponse::class.java
                    )
                    Toaster.showToast(this, message.message, result.status, Toast.LENGTH_SHORT)
                } catch (e: java.lang.Exception) {
                    e.printStackTrace()
                }
            }
        })
    }

    override fun onDestroy() {
        super.onDestroy()
        customLoader.hideProgress()
    }
}