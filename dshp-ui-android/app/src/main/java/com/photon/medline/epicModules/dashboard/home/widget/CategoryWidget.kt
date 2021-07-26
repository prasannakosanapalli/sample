package com.photon.medline.epicModules.dashboard.home.widget

import android.content.Context
import android.content.Intent
import android.util.AttributeSet
import android.view.LayoutInflater
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.databinding.DataBindingUtil
import com.google.android.flexbox.AlignItems
import com.google.android.flexbox.FlexboxLayoutManager
import com.photon.medline.R
import com.photon.medline.databinding.WidgetCategoryBinding
import com.photon.medline.epicModules.dashboard.home.adapter.ChiperFilterListAdapter
import com.photon.medline.epicModules.dashboard.home.adapter.SubCategoryAdapter
import com.photon.medline.epicModules.dashboard.home.component.ChipView
import com.photon.medline.epicModules.dashboard.home.component.SubCategoryView
/*import com.photon.medline.epicModules.seeall.ui.SeeAllActivity*/
import com.photon.medline.utilities.Status
import com.photon.medline.utilities.Toaster

class CategoryWidget : ConstraintLayout {

    private lateinit var mBinding: WidgetCategoryBinding

    constructor(context: Context) : super(context)

    constructor(context: Context, attrs: AttributeSet) : super(context, attrs)

    constructor(context: Context, attrs: AttributeSet, defStyleAttr: Int) : super(context, attrs, defStyleAttr)

    init {
        initView()
    }

    private fun initView() {
        mBinding = DataBindingUtil.inflate(LayoutInflater.from(context), R.layout.widget_category, this, true)
        configChipAdapter()
        configSubCategoryAdapter()
        configClickListener()
    }

    private fun configClickListener() {
        mBinding.txtSeeAll.setOnClickListener {
            Toaster.showToast(context,context.getString(R.string.seeAllMessage), Status.SUCCESS)
        }
    }

    private fun configSubCategoryAdapter() {
        mBinding.rvSubCategory.adapter = SubCategoryAdapter(getSubCategory()) { data , position ->
            Toaster.showToast(context,"${data.title} is tapped at $position", Status.SUCCESS)
        }
    }

    private fun configChipAdapter() {
        val layoutManager = FlexboxLayoutManager(context)
        layoutManager.alignItems = AlignItems.FLEX_START
        mBinding.rvChip.layoutManager = layoutManager
        mBinding.rvChip.adapter = ChiperFilterListAdapter(getChipDataList()) { data , isChecked , position ->
            Toaster.showToast(context,"${data.title} is tapped at $position and is checked $isChecked ", Status.SUCCESS)
        }
    }

    private fun getChipDataList() : ArrayList<ChipView.ChipData> {
        val chipsData = arrayListOf<ChipView.ChipData>()

        chipsData.add(
                ChipView.ChipData(
                        "Skin care",
                        false
                )
        )
        chipsData.add(
                ChipView.ChipData(
                        "Infection Prevention",
                        false
                )
        )
        chipsData.add(
                ChipView.ChipData(
                        "Wound care",
                        false
                )
        )
        chipsData.add(
                ChipView.ChipData(
                        "Nutrition",
                        false
                )
        )
        chipsData.add(
                ChipView.ChipData(
                        "Diagnostics",
                        false
                )
        )

        return chipsData
    }

    private fun getSubCategory() : ArrayList<SubCategoryView.SubCategoryData> {
        val subCategoryData = arrayListOf<SubCategoryView.SubCategoryData>()

        subCategoryData.add(
                SubCategoryView.SubCategoryData(
                        "Skin care"
                )
        )
        subCategoryData.add(
                SubCategoryView.SubCategoryData(
                        "Infection Prevention"
                )
        )
        subCategoryData.add(
                SubCategoryView.SubCategoryData(
                        "Wound care"
                )
        )
        subCategoryData.add(
                SubCategoryView.SubCategoryData(
                        "Nutrition"
                )
        )
        subCategoryData.add(
                SubCategoryView.SubCategoryData(
                        "Diagnostics"
                )
        )

        return subCategoryData
    }

}
