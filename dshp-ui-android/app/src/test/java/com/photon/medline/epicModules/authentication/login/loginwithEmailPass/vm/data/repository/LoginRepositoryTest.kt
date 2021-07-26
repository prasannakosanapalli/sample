package com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.repository

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import com.photon.medline.db.AppDatabase
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.local.LoginUserDao
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model.LoginPayload
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.remote.LoginRemoteDataSource
import com.photon.medline.network.apis.ApiService
import com.photon.medline.utilities.EMAIL
import com.photon.medline.utilities.PASSWORD
import kotlinx.coroutines.runBlocking
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.ArgumentMatchers
import org.mockito.Mockito

/**
 * Created by PAVANI P on 25/2/2021.
 * This class for testing Repository [LoginRepository]
 */
@RunWith(JUnit4::class)
class LoginRepositoryTest {
    private lateinit var repository: LoginRepository
    private val loginUserDao = Mockito.mock(LoginUserDao::class.java)
    private val service = Mockito.mock(ApiService::class.java)
    private val remoteDataSource = LoginRemoteDataSource(service)
    private lateinit var loginModel: LoginPayload
    private val login_email = EMAIL
    private val login_password = PASSWORD

    @Rule
    @JvmField
    val instantExecutorRule = InstantTaskExecutorRule()

    @Before
    fun init() {
        val db = Mockito.mock(AppDatabase::class.java)
        Mockito.`when`(db.loginUserDao()).thenReturn(loginUserDao)
        Mockito.`when`(db.runInTransaction(ArgumentMatchers.any())).thenCallRealMethod()
        //loginUserDao = LoginUserDao()
        loginModel = LoginPayload(login_email, login_password)
        repository = LoginRepository(remoteDataSource, loginUserDao)
    }

    @Test
    fun loadRegistrationResponseNetwork() {
        runBlocking {
            repository.userLogin(loginModel)
            Mockito.verify(loginUserDao, Mockito.never()).getAll()
            Mockito.verify(loginUserDao, Mockito.never()).getCount()
            Mockito.verifyNoMoreInteractions(loginUserDao)
        }
    }
}