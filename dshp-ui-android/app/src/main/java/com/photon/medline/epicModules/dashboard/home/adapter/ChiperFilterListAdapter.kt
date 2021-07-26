package com.photon.medline.epicModules.dashboard.home.adapter

import com.photon.medline.R
import com.photon.medline.base.BaseDiAdapter
import com.photon.medline.databinding.ItemChipperFilterBinding
import com.photon.medline.epicModules.dashboard.home.component.ChipView

class ChiperFilterListAdapter(
    var list: ArrayList<ChipView.ChipData>,
    var listener : (ChipView.ChipData,Boolean,Int) -> Unit
) : BaseDiAdapter() {

    override fun onBindViewHolder(holder: BaseDiViewHolder, position: Int) {
        if(holder.binding is ItemChipperFilterBinding) {
            holder.binding.chipView.configData(list[position])
            holder.binding.chipView.clickListener = { data ,isChecked ->
                listener.invoke(data , isChecked , position)
            }
        }
        super.onBindViewHolder(holder, position)
    }

    override fun getLayoutIdForPosition(position: Int): Int {
        return R.layout.item_chipper_filter
    }

    override fun getObjForPosition(position: Int): Any {
        return list[position]
    }

    override fun getItemCount(): Int {
        return list.size
    }
}