package com.photon.medline.epicModules.dashboard.home.widget

import android.content.Context
import android.util.AttributeSet
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.databinding.DataBindingUtil
import androidx.viewpager.widget.ViewPager
import com.photon.medline.R
import com.photon.medline.databinding.WidgetBannerBinding
import com.photon.medline.epicModules.dashboard.home.adapter.BannerPagerAdapter
import com.photon.medline.epicModules.dashboard.home.component.BannerView
import java.util.*

class BannerWidget : ConstraintLayout {

    private lateinit var mBinding: WidgetBannerBinding

    private lateinit var mBannerViewPagerAdapter: BannerPagerAdapter

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
            R.layout.widget_banner,
            this,
            true
        )
        configBannerViewPager()
        configViewPagerListener()
    }

    private fun configViewPagerListener() {
        mBinding.bannerViewPager.addOnPageChangeListener(object : ViewPager.OnPageChangeListener {
            override fun onPageScrolled(
                position: Int,
                positionOffset: Float,
                positionOffsetPixels: Int
            ) {
                Log.e("position",position.toString())
            }

            override fun onPageSelected(position: Int) {
                mBannerViewPagerAdapter.enableView(position) { pos ->
                    return@enableView mBinding.bannerViewPager.findViewWithTag<View>("${BannerPagerAdapter.tagValue} $pos")
                }
            }

            override fun onPageScrollStateChanged(state: Int) {
                Log.e("position",state.toString())
            }
        })
    }

    private fun configBannerViewPager() {

        mBannerViewPagerAdapter = BannerPagerAdapter(getBannerList())
        mBinding.bannerViewPager.adapter = mBannerViewPagerAdapter

        mBinding.bannerViewPager.clipToPadding = false
        val dp40 = resources.getDimension(R.dimen._40dp).toInt()
        mBinding.bannerViewPager.setPadding(dp40, 0, dp40, 0)
    }

    private fun getBannerList(): ArrayList<BannerView.BannerData> {
        val list = arrayListOf<BannerView.BannerData>()
        for (i in 0..9)
            list.add(BannerView.BannerData(i==0))
        return list
    }

}
