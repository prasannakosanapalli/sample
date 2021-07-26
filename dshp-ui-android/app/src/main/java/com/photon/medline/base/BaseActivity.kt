package com.photon.medline.base

import androidx.annotation.LayoutRes
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding

/**
 *  Created by Romesh
 *  Its base class of Activity level which will handle common operations at single place.
 */
abstract class BaseActivity : AppCompatActivity() {
    protected inline fun <reified T : ViewDataBinding> binding(
        @LayoutRes resId: Int
    ): Lazy<T> = lazy { DataBindingUtil.setContentView<T>(this, resId) }

    /**
     * On back pressed
     *to close activity
     */
    override fun onBackPressed() {
        super.onBackPressed()
        finish()
    }
}