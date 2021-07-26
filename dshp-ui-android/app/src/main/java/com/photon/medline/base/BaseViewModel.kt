package com.photon.medline.base

import androidx.databinding.Observable
import androidx.databinding.PropertyChangeRegistry
import androidx.lifecycle.ViewModel

/* Created by Romesh
 * Its base view model class to customize the view model features
 */
open class BaseViewModel : ViewModel(), Observable {
    @delegate:Transient
    val mCallBacks: PropertyChangeRegistry by lazy { PropertyChangeRegistry() }
    override fun addOnPropertyChangedCallback(callback: androidx.databinding.Observable.OnPropertyChangedCallback) {
        mCallBacks.add(callback)
    }

    override fun removeOnPropertyChangedCallback(callback: androidx.databinding.Observable.OnPropertyChangedCallback) {
        mCallBacks.remove(callback)
    }

    open fun notifyPropertyChanged(fieldId: Int) {
        mCallBacks.notifyCallbacks(this, fieldId, null)
    }
}