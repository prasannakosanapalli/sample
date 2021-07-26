package com.photon.medline.epicModules.dashboard.home.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.viewpager.widget.PagerAdapter
import com.photon.medline.R
import com.photon.medline.databinding.ItemBannerLayoutBinding
import com.photon.medline.epicModules.dashboard.home.component.BannerView

class BannerPagerAdapter(var dataList: ArrayList<BannerView.BannerData>) :
    PagerAdapter() {
    override fun destroyItem(container: ViewGroup, position: Int, objects: Any) {
        container.removeView(objects as View)
    }

    fun updateList(dataList: ArrayList<BannerView.BannerData>) {
        this.dataList = dataList
        notifyDataSetChanged()
    }

    override fun isViewFromObject(view: View, objects: Any): Boolean {
        return view == objects
    }

    override fun getCount(): Int {
        return dataList.size
    }

    override fun instantiateItem(container: ViewGroup, position: Int): Any {
        val layoutInflater = LayoutInflater.from(container.context)
        val binding: ItemBannerLayoutBinding = DataBindingUtil.inflate(
            layoutInflater, R.layout.item_banner_layout, container, false
        )
        binding.data = dataList[position]
        binding.position = position
        binding.bannerView.configData(
            dataList[position]
        )
        binding.bannerView.clickListener = {
            dataList[position].isEnabled = it.isEnabled
        }
        val view = binding.root
        view.tag = "$tagValue $position"
        container.addView(
            view
        )
        return binding.root
    }

    companion object {
        const val tagValue = "BannerViewAt"
    }

    fun enableView(position: Int, getView: (Int) -> View?) {
        dataList[position].isEnabled = true

        if ((position - 1) >= 0)
            disableView(position - 1, getView)

        if ((position + 1) < dataList.size)
            disableView(position + 1, getView)

        getView(position)?.let {
            val bannerView = it.findViewById<BannerView>(R.id.banner_view)
            bannerView.swapEnableDisable(dataList[position])
        }

        notifyDataSetChanged()
    }

    fun disableView(position: Int, getView: (Int) -> View?) {
        dataList[position].isEnabled = false
        getView(position)?.let {
            val bannerView = it.findViewById<BannerView>(R.id.banner_view)
            bannerView.swapEnableDisable(dataList[position])
        }
    }
}