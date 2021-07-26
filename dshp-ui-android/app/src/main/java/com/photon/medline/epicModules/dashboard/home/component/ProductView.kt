package com.photon.medline.epicModules.dashboard.home.component

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import androidx.cardview.widget.CardView
import androidx.databinding.DataBindingUtil
import com.photon.medline.R
import com.photon.medline.databinding.ComponentProductViewBinding


class ProductView : CardView {

    private lateinit var mBinding: ComponentProductViewBinding

    private lateinit var mProductData: ProductData

    constructor(context: Context) : super(context)

    constructor(context: Context, attrs: AttributeSet) : super(context, attrs)

    constructor(context: Context, attrs: AttributeSet, defStyleAttr: Int) : super(context, attrs, defStyleAttr)

    init {
        initView()
    }

    private fun initView() {
        mBinding = DataBindingUtil.inflate(LayoutInflater.from(context), R.layout.component_product_view, this, true)
        configClickListener()
    }

    private fun configClickListener() {
        mBinding.layoutProductViewRoot.setOnClickListener {

        }
    }

    fun configData(productData: ProductData) {
        mProductData = productData
        mBinding.txtProductName.text = mProductData.title
        mBinding.imgProductIcon.setImageResource(mProductData.iconResId)
    }

    data class ProductData(
            var title: String,
            var iconResId: Int
    )
}
