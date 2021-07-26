package com.photon.medline.epicModules.dashboard.home.adapter

import com.photon.medline.BR
import com.photon.medline.R
import com.photon.medline.base.BaseDiAdapter
import com.photon.medline.databinding.ItemProductBinding
import com.photon.medline.epicModules.dashboard.home.HomeViewModel
import com.photon.medline.epicModules.dashboard.home.component.ProductView
import com.photon.medline.epicModules.dashboard.home.model.ProductListModel

class ProductListAdapter(var list: ArrayList<ProductListModel>, var viewModel: HomeViewModel) :
        BaseDiAdapter() {

    override fun onBindViewHolder(holder: BaseDiViewHolder, position: Int) {
        holder.binding.setVariable(BR.viewModel, viewModel)
        if (holder.binding is ItemProductBinding)
            holder.binding.productView.configData(ProductView.ProductData(
                    title = list[position].productName,
                    iconResId = list[position].productImage
            ))
        super.onBindViewHolder(holder, position)
    }

    override fun getLayoutIdForPosition(position: Int): Int {
        return R.layout.item_product
    }

    override fun getObjForPosition(position: Int): Any {
        return list.get(position)
    }

    override fun getItemCount(): Int {
        return list.size
    }
}