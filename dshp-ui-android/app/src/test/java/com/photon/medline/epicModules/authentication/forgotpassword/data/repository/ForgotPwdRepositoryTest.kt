package com.photon.medline.epicModules.authentication.forgotpassword.data.repository

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import com.photon.medline.epicModules.authentication.forgotpassword.data.model.ForgotPasswordPayload
import com.photon.medline.epicModules.authentication.forgotpassword.data.remote.ForgotPwdRemoteDataSource
import com.photon.medline.network.apis.ApiService
import com.photon.medline.utilities.EMAIL
import com.photon.medline.utilities.RESEND_REQUEST
import com.photon.medline.utilities.RESET_URL
import kotlinx.coroutines.runBlocking
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.Mockito

/**
 * Created by PAVANI P on 25/2/2021.
 * This class for testing Repository [ForgotPwdRepository]
 */
@RunWith(JUnit4::class)
class ForgotPwdRepositoryTest {
    private lateinit var repository: ForgotPwdRepository
    private val service = Mockito.mock(ApiService::class.java)
    private val remoteDataSource = ForgotPwdRemoteDataSource(service)
    private lateinit var forgotPwdModel: ForgotPasswordPayload
    private val forget_email = EMAIL
    private val reset_url = RESET_URL

    @Rule
    @JvmField
    val instantExecutorRule = InstantTaskExecutorRule()

    @Before
    fun init() {
        forgotPwdModel = ForgotPasswordPayload(forget_email, reset_url, RESEND_REQUEST)
        repository = ForgotPwdRepository(remoteDataSource)
    }

    @Test
    fun loadRegistrationResponseNetwork() {
        runBlocking {
            repository.forgotPassword(forgotPwdModel)
        }
    }
}