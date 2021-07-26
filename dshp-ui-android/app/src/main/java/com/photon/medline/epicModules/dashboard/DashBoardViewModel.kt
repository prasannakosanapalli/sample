package com.photon.medline.epicModules.dashboard

import androidx.hilt.lifecycle.ViewModelInject
import com.photon.medline.base.BaseViewModel
import com.photon.medline.epicModules.authentication.resetpassword.repository.ResetPasswordRepository

class DashBoardViewModel @ViewModelInject constructor(
    private val repository: ResetPasswordRepository
) : BaseViewModel()