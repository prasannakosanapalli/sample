package com.photon.medline.epicModules.authentication.signup.ui

import android.graphics.Color
import android.graphics.Typeface
import android.text.TextPaint
import android.text.method.LinkMovementMethod
import android.text.style.ClickableSpan
import android.view.View
import android.widget.CheckBox
import androidx.appcompat.widget.AppCompatTextView
import androidx.databinding.Bindable
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.google.firebase.crashlytics.internal.Logger.TAG
import com.photon.medline.BR
import com.photon.medline.MedlineApp
import com.photon.medline.R
import com.photon.medline.base.BaseViewModel
import com.photon.medline.epicModules.authentication.signup.SignupValidators
import com.photon.medline.epicModules.authentication.signup.data.model.RegistrationModel
import com.photon.medline.epicModules.authentication.signup.data.model.SignUpResponse
import com.photon.medline.epicModules.authentication.signup.repository.SignUpRepository
import com.photon.medline.network.BaseNetworkCallbackHandler
import com.photon.medline.utilities.*
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.onStart
import kotlinx.coroutines.launch
import java.util.concurrent.Executors
import javax.inject.Inject

/**
 *Created by Vishal
 */
/**
 * Sign up view model
 *
 * @property repository
 * @constructor Create empty Sign up view model
 */
@HiltViewModel
class SignUpViewModel @Inject constructor(private val repository: SignUpRepository) :
    BaseViewModel(), LifecycleObserver {
    val _message = MutableLiveData<BaseNetworkCallbackHandler<SignUpResponse>>()

    @Bindable
    var enableDisableSubmitButton: Boolean = false

    @Bindable
    var firstname: Boolean = false

    @Bindable
    var lastname: Boolean = false

    @Bindable
    var customernumber: Boolean = false

    @Bindable
    var phone: Boolean = false

    @Bindable
    var email: Boolean = false

    @Bindable
    var password: Boolean = false

    @Bindable
    var confirmPassword: Boolean = false

    @Bindable
    var hideShowTogglePassword: Boolean = false

    @Bindable
    var hideShowToggleConfirmPassword: Boolean = false

    @Bindable
    var passwordVisibility: Boolean = false

    @Bindable
    var confirmPasswordVisibility: Boolean = false

    @Bindable
    var succcessPageEnable: Boolean = false
    var progressEnable: Boolean = false
    var registrationModel = RegistrationModel()
    var mutableLiveData = MutableLiveData<Int>()

    @Bindable
    var successEmailEnable: Boolean = false

    @Bindable
    var privacyPolicyTermCondition: Boolean = false
    var message: String? = ""

    @Bindable
    var minimumEightChar: Boolean = false

    @Bindable
    var oneSpecialCaharcter: Boolean = false

    @Bindable
    var oneNumber: Boolean = false

    @Bindable
    var oneUpperCase: Boolean = false
    var localDataFlag = false

    init {
        getUserRecord()
    }

    fun getUserRecord() {
        registrationModel = repository.registrationModel()
        if (registrationModel != null && !registrationModel.firstName.isEmpty()) {
            localDataFlag = true
            mutableLiveData.postValue(Constants.TEXT_FILLED)
        } else {
            registrationModel = RegistrationModel()
        }
    }

    /**
     * On first name text change listener
     * listener to check text empty or not
     * after that error message view Visible and Gone
     * @param s
     * @param start
     * @param before
     * @param count
     */
    fun onFirstNameTextChangeListener(
        s: CharSequence, start: Int,
        before: Int, count: Int
    ) {
        if (s.toString().isEmpty()) {
            firstname = false
        } else firstname = SignupValidators.regexxFirstLastName(s.toString())
        notifyPropertyChanged(BR.firstname)
        if (localDataFlag) {
            localDataFlag = false
            clearLocalDataBase()
        }
        registrationModel.firstName = s.toString()
        enableDisableSubmitButton()
    }

    /**
     * On last name text change listener
     *listener to check text empty or not
     * after that error message view Visible and Gone
     * @param s
     * @param start
     * @param before
     * @param count
     */
    fun onLastNameTextChangeListener(
        s: CharSequence, start: Int,
        before: Int, count: Int
    ) {
        if (s.toString().isEmpty()) {
            lastname = false
        } else lastname = SignupValidators.regexxFirstLastName(s.toString())
        notifyPropertyChanged(BR.lastname)
        if (localDataFlag) {
            localDataFlag = false
            clearLocalDataBase()
        }
        registrationModel.lastName = s.toString()
        enableDisableSubmitButton()
    }

    /**
     * On customer number text change listener
     *listener to check text number empty or not
     * after that error message view Visible and Gone
     * @param s
     * @param start
     * @param before
     * @param count
     */
    fun onCustomerNumberTextChangeListener(
        s: CharSequence, start: Int,
        before: Int, count: Int
    ) {
        if (s.toString().isEmpty()) {
            customernumber = false
        } else customernumber = (s.toString().length != 7)
        notifyPropertyChanged(BR.customernumber)
        if (localDataFlag) {
            localDataFlag = false
            clearLocalDataBase()
        }
        registrationModel.customerNumber = s.toString()
        enableDisableSubmitButton()
    }

    /**
     * On phone text change listener
     *listener to check text empty or not
     * after that error message view Visible and Gone
     * @param s
     */
    fun onPhoneTextChangeListener(s: String) {
        if (s.isEmpty()) {
            phone = false
        } else phone = !SignupValidators.isValidMobile(s)
        notifyPropertyChanged(BR.phone)
        if (localDataFlag) {
            localDataFlag = false
            clearLocalDataBase()
        }
        enableDisableSubmitButton()
    }

    /**
     * On email text change listener
     *listener to check text empty and match email pattern
     * after that error message view Visible and Gone
     * @param s
     * @param start
     * @param before
     * @param count
     */
    fun onEmailTextChangeListener(
        s: CharSequence, start: Int,
        before: Int, count: Int
    ) {
        if (s.toString().isEmpty()) {
            email = false
        } else email = !UIUtils.isValidEmail(s.toString())
        notifyPropertyChanged(BR.email)
        if (localDataFlag) {
            localDataFlag = false
            clearLocalDataBase()
        }
        registrationModel.email = s.toString()
        enableDisableSubmitButton()
    }

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
        if (localDataFlag) {
            localDataFlag = false
            clearLocalDataBase()
        }
        registrationModel.password = s.toString()
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
            confirmPassword = !s.toString().equals(registrationModel.password)
            confirmPasswordVisibility = true
        }
        notifyPropertyChanged(BR.confirmPassword)
        notifyPropertyChanged(BR.confirmPasswordVisibility)
        if (localDataFlag) {
            localDataFlag = false
            clearLocalDataBase()
        }
        registrationModel.confirmPassword = s.toString()
        enableDisableSubmitButton()
    }

    /**
     * Enable disable submit button
     *
     */
    fun enableDisableSubmitButton() {
        if (SignupValidators.isBlank(registrationModel.firstName) &&
            SignupValidators.isBlank(registrationModel.lastName) &&
            SignupValidators.isBlank(registrationModel.customerNumber) &&
            SignupValidators.isValidMobile(registrationModel.phone) &&
            UIUtils.isValidEmail(registrationModel.email) &&
            UIUtils.isValidPassword(registrationModel.password) &&
            UIUtils.isValidPassword(registrationModel.confirmPassword) &&
            registrationModel.password.equals(registrationModel.confirmPassword)
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
        if (!registrationModel.password.isEmpty()) {
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
        if (!registrationModel.confirmPassword.isEmpty()) {
            hideShowToggleConfirmPassword = !hideShowToggleConfirmPassword
            notifyPropertyChanged(BR.hideShowToggleConfirmPassword)
        }
    }

    fun onClickPrivacyPolicyTermAndCondition(view: View) {
        if (view is CheckBox) {
            val checked = view.isChecked
            privacyPolicyTermCondition = checked
            notifyPropertyChanged(BR.privacyPolicyTermCondition)
        }
    }

    /**
     * On Register click
     *For design validation purpose directly calling this function which will
     * hide the Forgot password design and display the success message if user
     * enters the valid email id.
     * Once API ready then need to call onSubmitButtonClick function which will call API and
     * based on success response we will change this binding object to true.
     */
    fun onRegiserButtonClick() {
        try {
            if (registrationModel.firstName.isEmpty() &&
                registrationModel.lastName.isEmpty() &&
                registrationModel.customerNumber.isEmpty() &&
                registrationModel.phone.isEmpty() &&
                registrationModel.email.isEmpty() &&
                registrationModel.password.isEmpty() &&
                registrationModel.confirmPassword.isEmpty() &&
                registrationModel.password.equals(registrationModel.confirmPassword)
            ) {
                successEmailEnable = false
                notifyPropertyChanged(BR.successEmailEnable)
                return
            } else if (!privacyPolicyTermCondition) {
                mutableLiveData.postValue(Constants.PRIVACY_POLICY_TERM_CONDITION)
            } else {
                mutableLiveData.postValue(Constants.HIDE_KEYBOARD)
                registrationModel.isPrivacyPolicyAgreed = 1
                registrationModel.isTermsAndConditionAgreed = 1
                progressEnable = true
                mutableLiveData.postValue(Constants.PROGRESS_ENABLE)
                userRegistrationCall(registrationModel)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    //when user click on the registration button this method will be called from the Activity.
    fun userRegistrationCall(registrationModel: RegistrationModel) {
        viewModelScope.launch {
            try {
                repository.signUp(registrationModel).onStart {
                }.collect {
                    progressEnable = false
                    mutableLiveData.postValue(Constants.PROGRESS_ENABLE)
                    if (it.status == Status.SUCCESS) {
                        successEmailEnable = true
                        notifyPropertyChanged(BR.successEmailEnable)
                        repository.deleteRegistration(registrationModel)
                    } else {
                        message = it.message
                        _message.postValue(it)
                    }
                }
            } catch (e: Exception) {
                TAG.let { AppLogger.error(it, "Login $e") }
            }
        }
    }

    /**
     * Spannable text view
     *this method is called for make custom spannable
     * text and perform click listener
     * @param textView
     */
    fun spannableTextViewTerm(textView: AppCompatTextView) {
        val privacyPolicy = object : ClickableSpan() {
            override fun onClick(widget: View) {
                mutableLiveData.postValue(Constants.PRIVACY_POLICY)
            }

            override fun updateDrawState(ds: TextPaint) {
                super.updateDrawState(ds)
                ds.isUnderlineText = false
                ds.color = MedlineApp.application.getColor(R.color.login_btn_color)
                //   ds.setTypeface(Typeface.create(Typeface.DEFAULT, Typeface.BOLD));
            }
        }
        val termAndCondition = object : ClickableSpan() {
            override fun onClick(widget: View) {
                mutableLiveData.postValue(Constants.TERM_AND_CONDITION)
            }

            override fun updateDrawState(ds: TextPaint) {
                super.updateDrawState(ds)
                ds.isUnderlineText = false
                ds.color =MedlineApp.application.getColor(R.color.login_btn_color)
                // ds.setTypeface(Typeface.create(Typeface.DEFAULT, Typeface.BOLD));
            }
        }

        textView.movementMethod = LinkMovementMethod.getInstance()
        textView.text = StringUtils.getSpannableString(
            privacyPolicy, termAndCondition, textView.context.getString(
                R.string.str_privacy_policy
            ), textView.context.getString(
                R.string.strterms
            ), textView.context.getString(
                R.string.terms
            )
        )
    }

    /**
     * Spannable text view
     *this method is called for make custom spannable
     * text and perform click listener
     * @param textView
     */
    fun spannableTextViewForText(textView: AppCompatTextView) {
        val loginSpan = object : ClickableSpan() {
            override fun onClick(widget: View) {
                mutableLiveData.postValue(Constants.LOGIN)
            }

            override fun updateDrawState(ds: TextPaint) {
                super.updateDrawState(ds)
                ds.isUnderlineText = false
                ds.color = MedlineApp.application.getColor(R.color.login_btn_color)
                ds.typeface = Typeface.create(Typeface.DEFAULT, Typeface.BOLD)
            }
        }

        textView.movementMethod = LinkMovementMethod.getInstance()
        textView.text = StringUtils.getSpannableString(
            loginSpan, textView.context.getString(
                R.string.register_acc1
            ), textView.context.getString(
                R.string.logins
            )
        )
    }

    fun obBackPressed() {
        mutableLiveData.postValue(Constants.BACK_PRESSED)
    }

    fun clearLocalDataBase() {
        Executors.newSingleThreadExecutor().execute(Runnable {
            repository.deleteRegistration(registrationModel)
        })
    }

    fun onContinueToLoginButtonClick() {
        Executors.newSingleThreadExecutor().execute(Runnable {
            repository.deleteRegistration(registrationModel)
        })
        mutableLiveData.postValue(Constants.BACK_PRESSED)
    }
}
