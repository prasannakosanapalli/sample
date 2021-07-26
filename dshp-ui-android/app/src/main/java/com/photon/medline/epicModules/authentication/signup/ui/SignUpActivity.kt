package com.photon.medline.epicModules.authentication.signup.ui

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.widget.Toast
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.photon.medline.R
import com.photon.medline.base.BaseActivity
import com.photon.medline.databinding.ActivitySignupBinding
import com.photon.medline.utilities.*
import com.photon.medline.utilities.Constants.MASK
import dagger.hilt.android.AndroidEntryPoint

/**
 * Sign up activity
 *
 * @constructor Create empty Sign up activity
 */
@AndroidEntryPoint
class SignUpActivity : BaseActivity() {
    private lateinit var signUpViewModel: SignUpViewModel
    private lateinit var signupBinding: ActivitySignupBinding
    private var customLoader = CustomLoader()
    private var isRunning = false
    private var isDeleting = false
    private val mask: String = MASK
    override fun onCreate(savedInstanceState: Bundle?) {
        try {
            super.onCreate(savedInstanceState)
            signupBinding = DataBindingUtil.setContentView(this, R.layout.activity_signup)
            signUpViewModel = ViewModelProvider(this).get(SignUpViewModel::class.java)
            signupBinding.signupviewmodel = signUpViewModel
            signUpViewModel.spannableTextViewTerm(signupBinding.txtPrivacyTermCondition)
            signUpViewModel.spannableTextViewForText(signupBinding.txtRegisterLine)
            customLoader = CustomLoader().getInstance()!!
            registeredMutableLiveData()
            registeredObservable()
        } catch (e: Exception) {
         e.printStackTrace()
        }
    }

    private fun registeredObservable() {
        signUpViewModel._message.observe(this, Observer { result ->
            if (result.status == Status.SUCCESS) {
                Toaster.showToast(
                    this,
                    getString(R.string.registration_success),
                    result.status,
                    Toast.LENGTH_SHORT
                )
            } else if (result.status == Status.ERROR) {
                try {
                    Toaster.showToast(
                        this,
                        result.message,
                        result.status,
                        Toast.LENGTH_SHORT
                    )
                } catch (e: java.lang.Exception) {
                    e.printStackTrace()
                }
            }
        })
        // logic for phone number formatting for this format((###) ###-####)
        signupBinding.edtPhoneNo.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(editable: Editable) {
                if (isRunning || isDeleting) {
                    val replaceOpenBracket: String = editable.toString().replace("(", "")
                    val replaceCloseBracket: String = replaceOpenBracket.replace(")", "")
                    val replaceSpace: String = replaceCloseBracket.replace(" ", "")
                    val replaceMinus: String = replaceSpace.replace("-", "")
                    signUpViewModel.onPhoneTextChangeListener(replaceMinus)
                    signUpViewModel.registrationModel.phone = replaceMinus
                    return
                }
                isRunning = true
                val editableLength = editable.length
                if (editableLength < mask.length) {
                    if (mask[editableLength] != '#') {
                        editable.append(mask[editableLength])
                    } else if (mask[editableLength - 1] != '#') {
                        editable.insert(
                            editableLength - 1,
                            mask,
                            editableLength - 1,
                            editableLength
                        )
                    }
                }
                isRunning = false
                val replaceOpenBracket: String = editable.toString().replace("(", "")
                val replaceCloseBracket: String = replaceOpenBracket.replace(")", "")
                val replaceSpace: String = replaceCloseBracket.replace(" ", "")
                val replaceMinus: String = replaceSpace.replace("-", "")
                signUpViewModel.onPhoneTextChangeListener(replaceMinus)
                signUpViewModel.registrationModel.phone = replaceMinus
            }

            override fun beforeTextChanged(
                editable: CharSequence?,
                start: Int,
                count: Int,
                after: Int
            ) {
                isDeleting = count >= after
            }

            override fun onTextChanged(
                charSequence: CharSequence?,
                start: Int,
                before: Int,
                count: Int
            ) {
                Log.e(charSequence.toString(), charSequence.toString())
            }
        })
    }

    private fun registeredMutableLiveData() {
        signUpViewModel.mutableLiveData.observe(this, Observer { result ->
            if (result == Constants.TERM_AND_CONDITION) {
                AlertDialogHelper.termAndConditionDialog(this)
            } else if (result == Constants.PRIVACY_POLICY) {
                AlertDialogHelper.privacyPolicyDialog(this)
            } else if (result == Constants.BACK_PRESSED) onBackPressed()
            else if (result == Constants.LOGIN) {
                finish()
            } else if (result == Constants.TEXT_FILLED) {
                textFilled()
            } else if (result == Constants.HIDE_KEYBOARD) {
                signupBinding.constraintButton.hideKeyboard()
            } else if (result == Constants.PRIVACY_POLICY_TERM_CONDITION) {
                Toaster.showToast(
                    this,
                    getString(R.string.enablePrivacyTermAndCondition),
                    Status.ERROR,
                    Toast.LENGTH_SHORT
                )
            } else if (result == Constants.PROGRESS_ENABLE) {
                if (signUpViewModel.progressEnable) {
                    customLoader.showProgress(this)
                } else {
                    customLoader.hideProgress()
                }
            }
        })
    }

    private fun textFilled() {
        val phone = "(${
        signUpViewModel.registrationModel.phone.substring(
            0,
            3
        )
        })" + " ${
        signUpViewModel.registrationModel.phone.substring(
            3,
            6
        )
        }" + "-${
        signUpViewModel.registrationModel.phone.substring(
            6,
            signUpViewModel.registrationModel.phone.length
        )
        }"
        signupBinding.edtFirst.setText(signUpViewModel.registrationModel.firstName)
        signupBinding.edtLast.setText(signUpViewModel.registrationModel.lastName)
        signupBinding.edtCustno.setText(signUpViewModel.registrationModel.customerNumber)
        signupBinding.edtPhoneNo.setText(phone)
        signupBinding.edtEmail.setText(signUpViewModel.registrationModel.email)
        signupBinding.edtPassword1.setText(signUpViewModel.registrationModel.password)
        signupBinding.edtCpassword1.setText(signUpViewModel.registrationModel.confirmPassword)
        signupBinding.checkTerms.isChecked = true
    }

    override fun onDestroy() {
        super.onDestroy()
        customLoader.hideProgress()
    }
}