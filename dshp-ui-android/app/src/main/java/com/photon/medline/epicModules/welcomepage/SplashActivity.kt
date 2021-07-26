package com.photon.medline.epicModules.welcomepage

import android.content.Intent
import android.os.Bundle
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.photon.medline.R
import com.photon.medline.base.BaseActivity
import com.photon.medline.databinding.ActivitySplashBinding
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.view.ui.LoginActivity
import com.photon.medline.epicModules.dashboard.DashBoardActivity
import com.photon.medline.utilities.Constants
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class SplashActivity : BaseActivity() {
    private lateinit var binding: ActivitySplashBinding
    private lateinit var viewModel: SplashViewModel
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_splash)
        viewModel = ViewModelProvider(this).get(SplashViewModel::class.java)
        binding.viewModel = viewModel
        viewModel.mutableLiveData.observe(this, Observer { result ->
            when (result) {
                Constants.SPLASH_SCREEN -> {
                    startActivity(Intent(this, LoginActivity::class.java))
                    finish()
                }
                Constants.DASHBOARD -> {
                    startActivity(Intent(this, DashBoardActivity::class.java))
                    finish()
                }
            }
        })
    }
}