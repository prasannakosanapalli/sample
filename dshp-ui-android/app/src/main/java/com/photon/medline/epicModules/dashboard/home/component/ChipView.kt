package com.photon.medline.epicModules.dashboard.home.component

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.databinding.DataBindingUtil
import com.photon.medline.R
import com.photon.medline.databinding.ComponentChipViewBinding

class ChipView : ConstraintLayout {

    private lateinit var mBinding: ComponentChipViewBinding

    private lateinit var mChipData: ChipData

    lateinit var clickListener: (ChipData, Boolean) -> Unit

    constructor(context: Context) : super(context)

    constructor(context: Context, attrs: AttributeSet) : super(context, attrs)

    constructor(context: Context, attrs: AttributeSet, defStyleAttr: Int) : super(context, attrs, defStyleAttr)

    init {
        initView()
    }

    private fun initView() {
        mBinding = DataBindingUtil.inflate(LayoutInflater.from(context), R.layout.component_chip_view, this, true)
    }

    fun configData(chipData: ChipData) {
        mChipData = chipData
        mBinding.text = mChipData.title
        mBinding.isSelected = mChipData.isSelected
        configClickEvent()
    }

    private fun configClickEvent() {
        mBinding.layoutChipRoot.setOnClickListener {
            if (it.isClickable) {
                mBinding.isSelected = !getFieldSelected()
                mChipData.isSelected = getFieldSelected()
                if(::clickListener.isInitialized)
                    clickListener.invoke(mChipData,getFieldSelected())
            }
        }
    }

    private fun getFieldSelected(): Boolean {
        return mBinding.isSelected?.let {
            it
        } ?: false
    }

    data class ChipData(
            var title: String,
            var isSelected: Boolean
    )
}
