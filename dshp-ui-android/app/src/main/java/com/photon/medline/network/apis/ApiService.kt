package com.photon.medline.network.apis

import com.photon.medline.epicModules.authentication.forgotpassword.data.model.ForgotPasswordPayload
import com.photon.medline.epicModules.authentication.forgotpassword.data.model.ForgotPasswordResponse
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model.LoginPayload
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model.LoginResponse
import com.photon.medline.epicModules.authentication.resetpassword.model.ResetPasswordRequest
import com.photon.medline.epicModules.authentication.resetpassword.model.ResetPasswordResponse
import com.photon.medline.epicModules.authentication.signup.data.model.RegistrationModel
import com.photon.medline.epicModules.authentication.signup.data.model.SignUpResponse
import com.photon.medline.epicModules.dashboard.home.model.HomeFragmentResponse
import com.photon.medline.network.EndPointsApis.Companion.FORGOT_PASSWORD
import com.photon.medline.network.EndPointsApis.Companion.HOME_FRAGMENT
import com.photon.medline.network.EndPointsApis.Companion.LOGIN
import com.photon.medline.network.EndPointsApis.Companion.REGISTER_USER
import com.photon.medline.network.EndPointsApis.Companion.RESET_PASSWORD
import retrofit2.Response
import retrofit2.http.*

/**
 * Created by Romesh
 * This interface will deal with all apis call.
 */
interface ApiService {
    /**
     * User login
     *
     * @param headers
     * @param loginPayload
     * @return
     */
    @POST(LOGIN)
    suspend fun userLogin(
        @HeaderMap headers: Map<String, String>, @Body loginPayload: LoginPayload
    ): Response<LoginResponse>

    /**
     * User forgot password
     *
     * @param headers
     * @param forgotPasswordPayload
     * @return
     */
    @POST(FORGOT_PASSWORD)
    suspend fun userForgotPassword(
        @HeaderMap headers: Map<String, String>, @Body forgotPasswordPayload: ForgotPasswordPayload
    ): Response<ForgotPasswordResponse>

    /**
     * Sign up
     *
     * @param headers
     * @param registrationModel
     * @return
     */
    @POST(REGISTER_USER)
    suspend fun signUp(
        @HeaderMap headers: Map<String, String>,
        @Body registrationModel: RegistrationModel
    ): Response<SignUpResponse>

    /**
     * Reset password
     *
     * @param headers
     * @param resetPasswordRequest
     * @return
     */
    @POST(RESET_PASSWORD)
    suspend fun resetPassword(
        @HeaderMap headers: Map<String, String>,
        @Body resetPasswordRequest: ResetPasswordRequest
    ): Response<ResetPasswordResponse>

    /**
     * Home fragment
     *
     * @param headers
     * @return
     */
    @GET(HOME_FRAGMENT)
    suspend fun homeFragment(
        @HeaderMap headers: Map<String, String>
    ): Response<HomeFragmentResponse>

    /**
     * Reset password
     * this is used for mockito url testing
     * @param path
     * @param headers
     * @param resetPasswordRequest
     * @return
     */
    @POST("{path}")
    suspend fun resetPassword(
        @Path("path") path: String,
        @HeaderMap headers: Map<String, String>,
        @Body resetPasswordRequest: ResetPasswordRequest
    ): Response<ResetPasswordResponse>

    /**
     * Sign up
     *this is used for mockito url testing
     * @param path
     * @param headers
     * @param registrationModel
     * @return
     */
    @POST("{path}")
    suspend fun signUp(
        @Path("path") path: String,
        @HeaderMap headers: Map<String, String>,
        @Body registrationModel: RegistrationModel
    ): Response<SignUpResponse>
}