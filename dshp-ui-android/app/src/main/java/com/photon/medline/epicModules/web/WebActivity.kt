package com.photon.medline.epicModules.web

import android.os.Bundle
import android.view.View
import android.webkit.WebView
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider
import com.photon.medline.R
import com.photon.medline.base.BaseActivity
import com.photon.medline.databinding.WebActivityBinding

/**
 *Created by Ashutosh Srivastava on 02-03-2021
 * Copyright(c) 2021 Photon.
 */
class WebActivity : BaseActivity() {
    private lateinit var binding: WebActivityBinding
    private lateinit var viewModel: WebViewModel
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.web_activity)
        viewModel = ViewModelProvider(this).get(WebViewModel::class.java)
        binding.viewModel = viewModel
        //binding.webView.setWebViewClient(WebViewClient())
        binding.webView.loadUrl("https://www.google.com")
    }

    inner class WebViewClient : android.webkit.WebViewClient() {

        override fun shouldOverrideUrlLoading(
            view: WebView,
            url: String
        ): Boolean {
            view.loadUrl(url)
            return true
        }

        override fun onPageFinished(view: WebView, url: String) {
            super.onPageFinished(view, url)
            binding.progressBar.visibility = View.GONE
        }
    }
}