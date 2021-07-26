package com.photon.medline.utilities

import android.content.Context
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.widget.LinearLayout
import android.widget.Toast
import androidx.appcompat.widget.AppCompatImageView
import androidx.appcompat.widget.AppCompatTextView
import androidx.core.content.ContextCompat
import com.photon.medline.R

/**
 *Created by Ashutosh Srivastava on 04-03-2021
 * Copyright(c) 2021 Photon.
 */
class Toaster private constructor() {
    companion object {
        fun showToast(
            context: Context,
            message: String?,
            state: Status,
            length: Int = Toast.LENGTH_SHORT
        ) {
            val inflater =
                context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            val v: View = inflater.inflate(R.layout.toaster, null)
            val activeStatus: AppCompatImageView = v.findViewById(R.id.activeStatus)
            val textActiveStatus: AppCompatTextView = v.findViewById(R.id.text_active_status)
            val llToastBAckground: LinearLayout = v.findViewById(R.id.llToastBAckground)
            if (state == Status.SUCCESS) {
                llToastBAckground.setBackgroundColor(
                        ContextCompat.getColor(
                                context,
                                R.color.color_04b751
                        )
                )
                activeStatus.setImageDrawable(
                        ContextCompat.getDrawable(
                                context,
                                R.drawable.im_success
                        )
                )
            }
            else if (state == Status.ERROR) {
                llToastBAckground.setBackgroundColor(
                        ContextCompat.getColor(
                                context,
                                R.color.red
                        )
                )
                activeStatus.setImageDrawable(
                        ContextCompat.getDrawable(
                                context,
                                R.drawable.ic_error
                        )
                )
            }
            textActiveStatus.text = message
            val toast = Toast(context)
            toast.setGravity(Gravity.BOTTOM or Gravity.FILL_HORIZONTAL, 0, 0)
            toast.duration = length
            toast.view = v
            toast.show()
        }
    }
}