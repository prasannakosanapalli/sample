package com.photon.medline.utilities

import android.app.Dialog
import android.content.Context
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.view.Window
import com.photon.medline.R

/**
 *Created by Ashutosh Srivastava on 16-03-2021
 * Copyright(c) 2021 Photon.
 */
class CustomLoader {
    var mCShowProgress: CustomLoader? = null
    var mDialog: Dialog? = null
    fun getInstance(): CustomLoader? {
        if (mCShowProgress == null) {
            mCShowProgress = CustomLoader()
        }
        return mCShowProgress
    }

    fun showProgress(mContext: Context) {
        mDialog = Dialog(mContext)
        mDialog!!.requestWindowFeature(Window.FEATURE_NO_TITLE)
        mDialog!!.setContentView(R.layout.loader)
        mDialog!!.window!!.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
        mDialog!!.setCancelable(false)
        mDialog!!.setCanceledOnTouchOutside(false)
        mDialog!!.show()
    }

    fun hideProgress() {
        if (mDialog != null) {
            mDialog!!.dismiss()
            mDialog = null
        }
    }
}