package com.photon.medline.epicModules.dashboard.home.component

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import androidx.cardview.widget.CardView
import androidx.databinding.DataBindingUtil
import com.photon.medline.R
import com.photon.medline.databinding.ComponentBannerViewBinding


class BannerView : CardView {

    private lateinit var mBinding: ComponentBannerViewBinding

    private lateinit var mBannerData: BannerData

    lateinit var clickListener: (BannerData) -> Unit

    constructor(context: Context) : super(context)

    constructor(context: Context, attrs: AttributeSet) : super(context, attrs)

    constructor(context: Context, attrs: AttributeSet, defStyleAttr: Int) : super(
        context,
        attrs,
        defStyleAttr
    )

    init {
        initView()
    }

    private fun initView() {
        mBinding = DataBindingUtil.inflate(
            LayoutInflater.from(context),
            R.layout.component_banner_view,
            this,
            true
        )
    }

    fun configData(bannerData: BannerData) {
        mBannerData = bannerData
        mBinding.isDisabled = !mBannerData.isEnabled
        configClickEvent()
        refreshUI(bannerData)
    }

    private fun configClickEvent() {
        mBinding.bannerRoot.setOnClickListener {
            if (it.isClickable)
                swapEnableDisable(mBannerData)
        }
    }

    fun swapEnableDisable(data: BannerData) {
        refreshUI(data)
        mBinding.isDisabled = !data.isEnabled
        if (::clickListener.isInitialized)
            clickListener.invoke(mBannerData)

    }

    private fun refreshUI(data: BannerData) {
        mBannerData = data
        mBinding.isDisabled = !mBannerData.isEnabled
        mBinding.bannerRoot.layoutParams = if (mBannerData.isEnabled) {
            val layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT)
            layoutParams.setMargins(0, 0, 0, 0)
            layoutParams
        } else {
            val dp8 = resources.getDimension(R.dimen._8dp).toInt()
            val dp4 = resources.getDimension(R.dimen._4dp).toInt()
            val layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT)
            layoutParams.setMargins(0, dp8, 0, dp4)
            layoutParams
        }
    }

    data class BannerData(
        var isEnabled: Boolean
    )
}

