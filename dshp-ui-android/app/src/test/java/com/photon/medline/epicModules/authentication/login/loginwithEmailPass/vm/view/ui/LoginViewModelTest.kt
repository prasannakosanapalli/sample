package com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.view.ui

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import com.google.gson.Gson
import com.photon.medline.BuildConfig
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model.LoginPayload
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.repository.LoginRepository
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
 *This class is for unit tests of [LoginViewModel]
 */
@ExperimentalCoroutinesApi
@RunWith(JUnit4::class)
class LoginViewModelTest {
    @Rule
    @JvmField
    val instantExecutorRule = InstantTaskExecutorRule()
    private val repository = Mockito.mock(LoginRepository::class.java)
    private lateinit var loginModel: LoginPayload
    private lateinit var apiService: ApiService
    private lateinit var apiService_endpoint: ApiService
    val header = HashMap<String, String>()
    private lateinit var mockWebServer: MockWebServer

    //valid credentials
    private val login_email = VALID_EMAIL_LOGIN
    private val login_password = VALID_PASSWORD_LOGIN

    //username correct and password wrong
    private val login_password_wrong = INVALID_PASSWORD_LOGIN
    private val login_email_valid = VALID_EMAIL_LOGIN

    //wrong credentials
    private val login_password_invalid = INVALID_PASSWORD_LOGIN
    private val login_email_invalid = INVALID_EMAIL_LOGIN

    @Before
    fun init() {
        loginModel = LoginPayload(login_email, login_password)
        mockWebServer = MockWebServer()
        header[HEADER_KEY] = BuildConfig.API_KEY
        apiService = Retrofit.Builder()
            .baseUrl(mockWebServer.url(BuildConfig.BASE_URL))
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ApiService::class.java)
        apiService_endpoint = Retrofit.Builder()
            .baseUrl(mockWebServer.url(LOGIN_WRONG_ENDPOINT))
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ApiService::class.java)
    }

    /**
     * Valid email and valid password test
     *
     */
    @Test
    fun validemailandvalidpasswordtest() {
        runBlocking {
            loginModel = LoginPayload(login_email, login_password)
            val resultResponse = apiService.userLogin(header, loginModel)
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
     * Valid email and invalid password test
     *
     */
    @Test
    fun validemailandinvalidpasswordtest() {
        runBlocking {
            loginModel = LoginPayload(login_email_valid, login_password_wrong)
            val resultResponse = apiService.userLogin(header, loginModel)
            MatcherAssert.assertThat(
                resultResponse.message(),
                CoreMatchers.equalTo(UNAUTHORISED_STATUS_MESSAGE)
            )
            MatcherAssert.assertThat(
                resultResponse.code().toString(),
                CoreMatchers.equalTo(
                    UNAUTHORISED_STATUS_CODE
                )
            )
            val errorMessage: Error = Gson().fromJson(
                resultResponse.errorBody()!!.charStream().readText(),
                Error::class.java
            )
            MatcherAssert.assertThat(
                errorMessage.message,
                CoreMatchers.equalTo(UNAUTHORISED_STATUS_ERROR)
            )
        }
    }

    /**
     * Invalid email and invalid password test
     *
     */
    @Test
    fun invalidemailandinvalidpasswordtest() {
        runBlocking {
            loginModel = LoginPayload(login_email_invalid, login_password_invalid)
            val resultResponse = apiService.userLogin(header, loginModel)

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
                CoreMatchers.equalTo(LOGIN_NOT_FOUND_ERROR_MESSAGE)
            )
        }
    }

    /**
     * Invalid email and valid password test
     *
     */
    @Test
    fun invalidemailandvalidpasswordtest() {
        runBlocking {
            loginModel = LoginPayload(login_email_invalid, login_password)
            val resultResponse = apiService.userLogin(header, loginModel)

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
                CoreMatchers.equalTo(LOGIN_NOT_FOUND_ERROR_MESSAGE)
            )
        }
    }

    /**
     * wrong payload
     * correct Email and blank password. conflict raises.
     * same response for wrong email and blank password
     */
    @Test
    fun wrongpayloademailcorrectandblankpassword() {
        runBlocking {
            loginModel = LoginPayload(login_email, "")
            val resultResponse = apiService.userLogin(header, loginModel)
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
            loginModel = LoginPayload(login_email, login_password)
            val resultResponse = apiService_endpoint.userLogin(header, loginModel)
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