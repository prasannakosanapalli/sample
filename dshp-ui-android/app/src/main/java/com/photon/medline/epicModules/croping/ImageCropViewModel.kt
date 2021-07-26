package com.photon.medline.ui.croping

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.MutableLiveData
import com.photon.medline.base.BaseViewModel
import com.photon.medline.epicModules.authentication.resetpassword.repository.ResetPasswordRepository

/**
 * Image crop view model
 *
 * @property repository
 * @constructor Create empty Image crop view model
 */
class ImageCropViewModel @ViewModelInject constructor(
    private val repository: ResetPasswordRepository
) : BaseViewModel() {
    var mutableLiveData = MutableLiveData<Int>()
    fun onProfileClick() {
        mutableLiveData.postValue(101)
    }
}