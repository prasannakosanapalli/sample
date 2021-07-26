package com.photon.medline.base

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.recyclerview.widget.RecyclerView
import com.photon.medline.BR

abstract class BaseDiAdapter : RecyclerView.Adapter<BaseDiAdapter.BaseDiViewHolder>() {
    override fun onCreateViewHolder(viewGroup: ViewGroup, viewType: Int): BaseDiViewHolder {
        val layoutInflater: LayoutInflater = LayoutInflater.from(viewGroup.context)
        val viewDataBinding: ViewDataBinding =
            DataBindingUtil.inflate(layoutInflater, viewType, viewGroup, false)
        return BaseDiViewHolder(viewDataBinding)
    }

    override fun onBindViewHolder(holder: BaseDiViewHolder, position: Int) {
        val obj = getObjForPosition(position)
        holder.bind(obj, position)
    }

    override fun getItemViewType(position: Int): Int {
        return getLayoutIdForPosition(position)
    }

    abstract fun getLayoutIdForPosition(position: Int): Int
    abstract fun getObjForPosition(position: Int): Any
    class BaseDiViewHolder internal constructor(val binding: ViewDataBinding) :
        RecyclerView.ViewHolder(binding.root) {
        fun bind(obj: Any?, position: Int) {
            binding.setVariable(BR.position, position)
            binding.setVariable(BR.data, obj)
            binding.executePendingBindings()
        }
    }
}