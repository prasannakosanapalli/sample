package com.photon.medline.errors

import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.model.Data

/**
 *  Created by Romesh
 *  Its Common Error data class to render error messages which will come during network apis call
 */
data class Error(val status: String, val message: String? = null, val data: Data?)