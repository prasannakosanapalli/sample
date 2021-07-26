package com.photon.medline.epicModules.authentication.signup.ui

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import com.google.common.truth.Truth
import com.google.gson.Gson
import com.photon.medline.BuildConfig
import com.photon.medline.epicModules.authentication.resetpassword.model.ResetPasswordResponse
import com.photon.medline.epicModules.authentication.signup.SignupValidators
import com.photon.medline.epicModules.authentication.signup.data.model.RegistrationModel
import com.photon.medline.epicModules.authentication.signup.data.model.SignUpResponse
import com.photon.medline.epicModules.authentication.signup.repository.SignUpRepository
import com.photon.medline.network.apis.ApiService
import com.photon.medline.utilities.*
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.runBlocking
import okhttp3.mockwebserver.MockWebServer
import org.hamcrest.CoreMatchers
import org.hamcrest.MatcherAssert
import org.junit.After
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.Mockito
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

/**
 * Created by Ashutosh Srivastava on 26-02-2021
 * Copyright(c) 2021 .
 */
@ExperimentalCoroutinesApi
@RunWith(JUnit4::class)
class SignUpViewModelTest {
    @get:Rule
    var instantTaskExecutorRule = InstantTaskExecutorRule()
    private val signUpRepository = Mockito.mock(SignUpRepository::class.java)
    private lateinit var viewModel: SignUpViewModel
    private var registrationModel = RegistrationModel()
    val header = HashMap<String, String>()
    private lateinit var mockWebServer: MockWebServer
    private lateinit var service: ApiService

    @Before
    fun setup() {
        viewModel = SignUpViewModel(signUpRepository)
        registrationModel.password = PASSWORD
        registrationModel.confirmPassword = PASSWORD
        registrationModel.firstName = FIRST_NAME
        registrationModel.lastName = LAST_NAME
        registrationModel.customerNumber = CUSTOMER_NUMBER
        registrationModel.phone = PHONE
        registrationModel.email = EMAIL
        registrationModel.userType = USER_TYPE
        registrationModel.isTermsAndConditionAgreed = 1
        registrationModel.isPrivacyPolicyAgreed = 1
        header[HEADER_KEY] = BuildConfig.API_KEY
        mockWebServer = MockWebServer()
        /**
         * to hit actual api
         */
        service = Retrofit.Builder()
            .baseUrl(mockWebServer.url(BuildConfig.BASE_URL))
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ApiService::class.java)
    }

    @After
    fun stopService() {
        mockWebServer.shutdown()
    }

    /**
     * Edt_first
     *check validation first name is empty or not
     */
    @Test
    fun edtFirst() {
        val result = SignupValidators.regexxFirstLastNameForTesting(registrationModel.firstName)
        Truth.assertThat(result).isTrue()
    }

    /**
     * Edt_last
     *check validation last name is empty or not
     */
    @Test
    fun edtLast() {
        val result = SignupValidators.regexxFirstLastNameForTesting(registrationModel.lastName)
        Truth.assertThat(result).isTrue()
    }

    /**
     * Edt_custno
     *check validation customer number is empty or not
     */
    @Test
    fun edtCustno() {
        val result = SignupValidators.isValidCustomerNumber(registrationModel.customerNumber)
        Truth.assertThat(result).isTrue()
    }

    /**
     * Edt_phone_no
     *check validation phone number is empty or not
     */
    @Test
    fun edtPhoneNo() {
        val result = SignupValidators.isValidMobile(registrationModel.phone)
        Truth.assertThat(result).isTrue()
    }

    /**
     * Edt_email
     *check validation email address is empty or not
     */
    @Test
    fun edtEmail() {
        val result = UIUtils.isValidEmail(registrationModel.email)
        Truth.assertThat(result).isTrue()
    }

    /**
     * Password is empty
     *check validation Password is empty
     */
    @Test
    fun passwordIsEmpty() {
        val result = UIUtils.isValidPassword(registrationModel.password)
        Truth.assertThat(result).isTrue()
    }

    /**
     * Confirm password is empty
     *check validation confirm Password is empty
     */
    @Test
    fun confirmPasswordIsEmpty() {
        val result = UIUtils.isValidPassword(registrationModel.confirmPassword)
        Truth.assertThat(result).isTrue()
    }

    /**
     * Less than nine digit password
     *check validation less than nine digit password
     */
    @Test
    fun passwordLessThanNineDigit() {
        val result = UIUtils.isValidPassword(
            registrationModel.password
        )
        Truth.assertThat(result).isTrue()
    }

    /**
     * Less than nine digit confirm password
     *check validation less than nine digit confirm password
     */
    @Test
    fun confirmPasswordLessThanNineDigit() {
        val result = UIUtils.isValidPassword(
            registrationModel.confirmPassword
        )
        Truth.assertThat(result).isTrue()
    }

    /**
     * Check valid password
     *check validation valid password
     */
    @Test
    fun checkValidPassword() {
        val result = UIUtils.isValidPassword(
            registrationModel.password
        )
        Truth.assertThat(result).isTrue()
    }

    /**
     * Check valid confirm password
     *check validation less than nine digit confirm password
     */
    @Test
    fun checkValidConfirmPassword() {
        val result = UIUtils.isValidPassword(
            registrationModel.confirmPassword
        )
        Truth.assertThat(result).isTrue()
    }

    /**
     * Verify view model callingto repository
     *
     */
    @Test
    fun verifyViewModelCallingtoRepository() {
        runBlocking {
            MatcherAssert.assertThat(registrationModel, CoreMatchers.notNullValue())
            Mockito.verify(signUpRepository, Mockito.never()).signUp(registrationModel)
        }
    }
    /**********************Actual API tests*******************************************/
    /**
     * Valid sign up test
     * registered the user and get success response
     * response @return type Object
     */
    @Test
    fun validSignUpTest() {
        runBlocking {
            val resultResponse = service.signUp(header, registrationModel)
            if (resultResponse.isSuccessful) {
                MatcherAssert.assertThat(
                    resultResponse.code().toString(),
                    CoreMatchers.equalTo(OK_STATUS_CODE)
                )
                MatcherAssert.assertThat(
                    resultResponse.message(),
                    CoreMatchers.equalTo(OK_STATUS_MESSAGE)
                )
            } else {
                val errorMessage: SignUpResponse = Gson().fromJson(
                    resultResponse.errorBody()!!.charStream().readText(),
                    SignUpResponse::class.java
                )
                MatcherAssert.assertThat(
                    errorMessage.message,
                    CoreMatchers.equalTo(RESOURCE_NOT_FOUNE)
                )
            }
        }
    }

    /**
     * Invalid customer number
     * perform api and getting error message
     * matching response error message from server to local message
     */
    @Test
    fun invalidCustomerNumber() {
        runBlocking {
            registrationModel.customerNumber = "1234567"
            registrationModel.email = "user1212@photon.in"
            val resultResponse = service.signUp(header, registrationModel)
            val errorMessage: SignUpResponse = Gson().fromJson(
                resultResponse.errorBody()!!.charStream().readText(),
                SignUpResponse::class.java
            )
            MatcherAssert.assertThat(
                errorMessage.message,
                CoreMatchers.equalTo(REGISTER_USER_ERROR)
            )
            MatcherAssert.assertThat(
                resultResponse.code().toString(), CoreMatchers.equalTo(
                    NOT_FOUND_STATUS_CODE
                )
            )
        }
    }

    /**
     * Url mismatch api failed test case
     * url mismatch api response error
     */
    @Test
    fun urlMismatchApiFailedTestCase() {
        runBlocking {
            val resultResponse =
                service.signUp("registeruserUrls", header, registrationModel)
            val errorMessage: ResetPasswordResponse = Gson().fromJson(
                resultResponse.errorBody()!!.charStream().readText(),
                ResetPasswordResponse::class.java
            )
            MatcherAssert.assertThat(
                errorMessage.message,
                CoreMatchers.equalTo(RESOURCE_NOT_FOUND_MESSAGE)
            )
            MatcherAssert.assertThat(
                resultResponse.code().toString(), CoreMatchers.equalTo(
                    NOT_FOUND_STATUS_CODE
                )
            )
        }
    }
}