package com.photon.medline.epicModules.dashboard.home.component

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import androidx.cardview.widget.CardView
import androidx.databinding.DataBindingUtil
import com.photon.medline.R
import com.photon.medline.databinding.ComponentSubCategoryDataViewBinding


class SubCategoryView : CardView {

    private lateinit var mBinding: ComponentSubCategoryDataViewBinding

    private lateinit var mData: SubCategoryData

    lateinit var clickListener: (SubCategoryData) -> Unit

    constructor(context: Context) : super(context)

    constructor(context: Context, attrs: AttributeSet) : super(context, attrs)

    constructor(context: Context, attrs: AttributeSet, defStyleAttr: Int) : super(context, attrs, defStyleAttr)

    init {
        initView()
    }

    private fun initView() {
        mBinding = DataBindingUtil.inflate(LayoutInflater.from(context), R.layout.component_sub_category_data_view, this, true)
        configClickListener()
    }

    private fun configClickListener() {
        mBinding.layoutSubCategoryRoot.setOnClickListener {
            if(::clickListener.isInitialized)
                clickListener.invoke(mData)
        }
    }

    fun configData(subCategoryData: SubCategoryData) {
        mData = subCategoryData
        mBinding.txtSubCateTitle.text = mData.title
    }

    data class SubCategoryData(
            var title: String
    )
}
