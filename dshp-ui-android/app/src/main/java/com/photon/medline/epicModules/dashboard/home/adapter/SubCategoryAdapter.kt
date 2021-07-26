package com.photon.medline.epicModules.dashboard.home.adapter

import com.photon.medline.R
import com.photon.medline.base.BaseDiAdapter
import com.photon.medline.databinding.ItemSubCategoryBinding
import com.photon.medline.epicModules.dashboard.home.component.SubCategoryView

class SubCategoryAdapter(
        var list: ArrayList<SubCategoryView.SubCategoryData>,
        var listener: (SubCategoryView.SubCategoryData,Int) -> Unit
) : BaseDiAdapter() {

    override fun onBindViewHolder(holder: BaseDiViewHolder, position: Int) {
        if (holder.binding is ItemSubCategoryBinding) {
            holder.binding.subCategoryView.configData(SubCategoryView.SubCategoryData(
                    title = list[position].title
            ))
            holder.binding.subCategoryView.clickListener =  { data ->
                listener.invoke(data,position)
            }
        }
        super.onBindViewHolder(holder, position)
    }

    override fun getLayoutIdForPosition(position: Int): Int {
        return R.layout.item_sub_category
    }

    override fun getObjForPosition(position: Int): Any {
        return list[position]
    }

    override fun getItemCount(): Int {
        return list.size
    }
}