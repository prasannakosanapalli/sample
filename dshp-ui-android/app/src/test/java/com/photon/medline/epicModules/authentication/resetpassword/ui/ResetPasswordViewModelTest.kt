package com.photon.medline.epicModules.authentication.resetpassword.ui

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import com.google.common.truth.Truth.assertThat
import com.google.gson.Gson
import com.photon.medline.BuildConfig
import com.photon.medline.epicModules.authentication.resetpassword.model.ResetPasswordRequest
import com.photon.medline.epicModules.authentication.resetpassword.model.ResetPasswordResponse
import com.photon.medline.epicModules.authentication.resetpassword.repository.ResetPasswordRepository
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
 * Created by Ashutosh Srivastava on 25-02-2021
 * Copyright(c) 2021 .
 */
@ExperimentalCoroutinesApi
@RunWith(JUnit4::class)
class ResetPasswordViewModelTest {
    @get:Rule
    var instantTaskExecutorRule = InstantTaskExecutorRule()
    private val resetPasswordRepository = Mockito.mock(ResetPasswordRepository::class.java)
    private lateinit var viewModel: ResetPasswordViewModel
    private var resetPasswordModel = ResetPasswordRequest()
    val header = HashMap<String, String>()
    private lateinit var mockWebServer: MockWebServer
    private lateinit var service: ApiService

    @Before
    fun setup() {
        viewModel = ResetPasswordViewModel(resetPasswordRepository)
        resetPasswordModel.email = EMAIL_ID
        resetPasswordModel.password = PASSWORD
        resetPasswordModel.confirmPassword = CONFIRM_PASSWORD
        resetPasswordModel.token = FORGET_PASSWORD_TOKEN
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
     * Password is empty
     */
    @Test
    fun passwordIsEmpty() {
        val result = UIUtils.isValidPassword(resetPasswordModel.password)
        assertThat(result).isTrue()
    }

    /**
     * confirm Password is empty
     */
    @Test
    fun confirmPasswordIsEmpty() {
        val result = UIUtils.isValidPassword(resetPasswordModel.confirmPassword)
        assertThat(result).isTrue()
    }

    /**
     * less than nine digit password
     */
    @Test
    fun passwordLessThanNineDigitPassword() {
        val result = UIUtils.isValidPassword(
            resetPasswordModel.password
        )
        assertThat(result).isTrue()
    }

    /**
     * less than nine digit confirm password
     */
    @Test
    fun confirmPasswordLessThanNineDigit() {
        val result = UIUtils.isValidPassword(
            resetPasswordModel.confirmPassword
        )
        assertThat(result).isTrue()
    }

    /**
     * valid password
     */
    @Test
    fun checkValidPassword() {
        val result = UIUtils.isValidPassword(
            resetPasswordModel.password
        )
        assertThat(result).isTrue()
    }

    /**
     * less than two digit confirm password
     */
    @Test
    fun checkValidConfirmPassword() {
        val result = UIUtils.isValidPassword(
            resetPasswordModel.confirmPassword
        )
        assertThat(result).isTrue()
    }

    /**
     * Verify view model calling to repository
     *
     */
    @Test
    fun verifyViewModelCallingtoRepository() {
        runBlocking {
            MatcherAssert.assertThat(resetPasswordModel, CoreMatchers.notNullValue())
            Mockito.verify(resetPasswordRepository, Mockito.never())
                .resetPassword(resetPasswordModel)
        }
    }

    /**
     * Valid reset api test
     * reset password success response
     * response @return type Object
     */
    @Test
    fun resetPasswordApiTesting() {
        runBlocking {
            val resultResponse = service.resetPassword(header, resetPasswordModel)
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
                val errorMessage: ResetPasswordResponse = Gson().fromJson(
                    resultResponse.errorBody()!!.charStream().readText(),
                    ResetPasswordResponse::class.java
                )
                MatcherAssert.assertThat(
                    errorMessage.message,
                    CoreMatchers.equalTo(PASSWORD_ALREADY_COMPLETED)
                )
            }
        }
    }

    /**
     * Api failed test case
     * api failed test case
     * invalid @email and @token
     */
    @Test
    fun apiFailedTestCase() {
        runBlocking {
            resetPasswordModel.token = "SlkhGQOVPQtmTyTKu83loP2S7pzI1Wkoh5uZRtdbE+A="
            resetPasswordModel.email = "ashutosh@photon.in"
            val resultResponse = service.resetPassword(header, resetPasswordModel)
            val errorMessage: ResetPasswordResponse = Gson().fromJson(
                resultResponse.errorBody()!!.charStream().readText(),
                ResetPasswordResponse::class.java
            )
            MatcherAssert.assertThat(
                errorMessage.message,
                CoreMatchers.equalTo(PASSWORD_ALREADY_COMPLETED)
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
                service.resetPassword("resetpasswordUrl", header, resetPasswordModel)
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