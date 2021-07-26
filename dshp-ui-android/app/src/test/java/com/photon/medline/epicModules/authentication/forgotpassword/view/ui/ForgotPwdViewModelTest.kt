package com.photon.medline.epicModules.authentication.forgotpassword.view.ui

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import com.google.gson.Gson
import com.photon.medline.BuildConfig
import com.photon.medline.epicModules.authentication.forgotpassword.data.model.ForgotPasswordPayload
import com.photon.medline.epicModules.authentication.forgotpassword.data.repository.ForgotPwdRepository
import com.photon.medline.errors.Error
import com.photon.medline.network.apis.ApiService
import com.photon.medline.utilities.*
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.runBlocking
import okhttp3.mockwebserver.MockWebServer
import org.hamcrest.CoreMatchers
import org.hamcrest.MatcherAssert
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.Mockito
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

/**
 * Created by PAVANI P on 25/2/2021.
 * This class is for unit tests of [ForgotPwdActivity]
 */
@ExperimentalCoroutinesApi
@RunWith(JUnit4::class)
class ForgotPwdViewModelTest {
    @Rule
    @JvmField
    val instantExecutorRule = InstantTaskExecutorRule()
    private val repository = Mockito.mock(ForgotPwdRepository::class.java)
    private lateinit var forgotPwdModel: ForgotPasswordPayload
    private var viewModel = ForgotPwdViewModel(repository)
    private val email = FORGOT_VALID_EMAIL
    private lateinit var apiService: ApiService
    private lateinit var apiService_endpoint: ApiService
    val header = HashMap<String, String>()
    private lateinit var mockWebServer: MockWebServer

    @Before
    fun init() {
        forgotPwdModel = ForgotPasswordPayload(
            email,
            RESET_URL,
            RESEND_REQUEST
        )
        mockWebServer = MockWebServer()
        header[HEADER_KEY] = BuildConfig.API_KEY
        apiService = Retrofit.Builder()
            .baseUrl(mockWebServer.url(BuildConfig.BASE_URL))
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ApiService::class.java)
        apiService_endpoint = Retrofit.Builder()
            .baseUrl(mockWebServer.url(FORGOT_PASSWORD_WRONG_ENDPOINT))
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ApiService::class.java)
    }

    /**
     * Verify view model calling to repository
     *
     */
    @Test
    fun verifyViewModelCallingtoRepository() {
        runBlocking {
            MatcherAssert.assertThat(viewModel.forgotPwdModel, CoreMatchers.notNullValue())
            Mockito.verify(repository, Mockito.never()).forgotPassword(forgotPwdModel)
        }
    }

    /**
     * Valid email test
     *PLEASE CHECK and if needed changes EMAIL parameter.
     */
    @Test
    fun forgotpasswordrequestwithvalidemailandpendingrequestdoesnotexist() {
        runBlocking {
            forgotPwdModel = ForgotPasswordPayload(
                FORGOT_VALID_EMAIL,
                RESET_URL,
                RESEND_REQUEST
            )
            val resultResponse = apiService.userForgotPassword(header, forgotPwdModel)
            MatcherAssert.assertThat(
                resultResponse.code().toString(),
                CoreMatchers.equalTo(OK_STATUS_CODE)
            )
            MatcherAssert.assertThat(
                resultResponse.message(),
                CoreMatchers.equalTo(OK_STATUS_MESSAGE)
            )
        }
    }

    /**
     * InValid email test
     *
     */
    @Test
    fun invalidEmail() {
        runBlocking {
            forgotPwdModel = ForgotPasswordPayload(
                INVALID_EMAIL_LOGIN,
                RESET_URL,
                RESEND_REQUEST
            )
            val resultResponse = apiService.userForgotPassword(header, forgotPwdModel)
            MatcherAssert.assertThat(
                resultResponse.message(),
                CoreMatchers.equalTo(NOT_FOUND_STATUS_MESSAGE)
            )
            MatcherAssert.assertThat(
                resultResponse.code().toString(),
                CoreMatchers.equalTo(
                    NOT_FOUND_STATUS_CODE
                )
            )
            val errorMessage: Error = Gson().fromJson(
                resultResponse.errorBody()!!.charStream().readText(),
                Error::class.java
            )
            MatcherAssert.assertThat(
                errorMessage.message,
                CoreMatchers.equalTo(NOT_FOUND_ERROR_MESSAGE)
            )
        }
    }

    /**
     * already pending request exists for email.
     *
     */
    @Test
    fun forgotpasswordrequestwithpendingrequestemail() {
        runBlocking {
            forgotPwdModel = ForgotPasswordPayload(
                FORGOT_VALID_EMAIL,
                RESET_URL,
                RESEND_REQUEST
            )
            val resultResponse = apiService.userForgotPassword(header, forgotPwdModel)
            MatcherAssert.assertThat(
                resultResponse.code().toString(),
                CoreMatchers.equalTo(CONFLICT_CODE)
            )
            MatcherAssert.assertThat(
                resultResponse.message(),
                CoreMatchers.equalTo(CONFLICT_ERROR)
            )
            val errorMessage: Error = Gson().fromJson(
                resultResponse.errorBody()!!.charStream().readText(),
                Error::class.java
            )
            MatcherAssert.assertThat(
                errorMessage.message,
                CoreMatchers.equalTo(FORGOT_PENDING_REQUEST_MESSAGE)
            )
        }
    }

    /**
     * Wrong payload that has blank url
     *email has already existing pending request
     */
    @Test
    fun wrongPayloadthathasBlankurl() {
        runBlocking {
            forgotPwdModel = ForgotPasswordPayload(
                FORGOT_RESEND_VALID_EMAIL,
                BLANK_URL,
                RESEND_REQUEST
            )
            val resultResponse = apiService.userForgotPassword(header, forgotPwdModel)
            MatcherAssert.assertThat(
                resultResponse.code().toString(),
                CoreMatchers.equalTo(BADREQUEST_CODE)
            )
            MatcherAssert.assertThat(
                resultResponse.message(),
                CoreMatchers.equalTo(BADREQUEST_ERROR)
            )
            val errorMessage: Error = Gson().fromJson(
                resultResponse.errorBody()!!.charStream().readText(),
                Error::class.java
            )
            MatcherAssert.assertThat(
                errorMessage.message,
                CoreMatchers.equalTo(BADREQUEST_ERROR_MESSAGE)
            )
        }
    }

    /**
     * Wrong endpoint
     *return resouce not found error
     */
    @Test
    fun wrongendpoint() {
        runBlocking {
            forgotPwdModel = ForgotPasswordPayload(
                FORGOT_RESEND_VALID_EMAIL,
                RESET_URL,
                RESEND_REQUEST
            )
            val resultResponse = apiService_endpoint.userForgotPassword(header, forgotPwdModel)
            MatcherAssert.assertThat(
                resultResponse.code().toString(),
                CoreMatchers.equalTo(RESOURCE_NOT_FOUND_CODE)
            )
            MatcherAssert.assertThat(
                resultResponse.message(),
                CoreMatchers.equalTo(RESOURCE_NOT_FOUND_ERROR)
            )
            val errorMessage: Error = Gson().fromJson(
                resultResponse.errorBody()!!.charStream().readText(),
                Error::class.java
            )
            MatcherAssert.assertThat(
                errorMessage.message,
                CoreMatchers.equalTo(RESOURCE_NOT_FOUND_MESSAGE)
            )
        }
    }
}