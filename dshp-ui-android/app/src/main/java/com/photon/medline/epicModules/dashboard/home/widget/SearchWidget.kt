package com.photon.medline.epicModules.dashboard.home.widget

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.databinding.DataBindingUtil
import com.photon.medline.R
import com.photon.medline.databinding.WidgetSearchBinding
import com.photon.medline.epicModules.dashboard.home.HomeViewModel
import com.photon.medline.utilities.Status
import com.photon.medline.utilities.Toaster

class SearchWidget : ConstraintLayout {

    private lateinit var mBinding: WidgetSearchBinding

    constructor(context: Context) : super(context)

    constructor(context: Context, attrs: AttributeSet) : super(context, attrs)

    constructor(context: Context, attrs: AttributeSet, defStyleAttr: Int) : super(context, attrs, defStyleAttr)

    init {
        initView()
    }

    private fun initView() {
        mBinding = DataBindingUtil.inflate(LayoutInflater.from(context), R.layout.widget_search, this, true)
        configClickListener()
    }

    private fun configClickListener() {
        mBinding.ivQRCodeScanner.setOnClickListener {
            Toaster.showToast(context,"QR Code Scanner is tapped ", Status.SUCCESS)
        }
    }

    fun configViewModel(viewModel : HomeViewModel) {
        mBinding.viewModel = viewModel
    }

}
