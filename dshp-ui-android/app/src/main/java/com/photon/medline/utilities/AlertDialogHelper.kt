package com.photon.medline.utilities

import android.app.AlertDialog
import android.app.Dialog
import android.content.Context
import android.content.DialogInterface
import android.text.TextPaint
import android.text.style.ClickableSpan
import android.view.LayoutInflater
import android.view.View
import android.view.Window
import androidx.databinding.DataBindingUtil
import com.photon.medline.MedlineApp
import com.photon.medline.R
import com.photon.medline.databinding.LayoutPrivacyPolicyBinding
import com.photon.medline.databinding.LayoutTermAndConditionBinding
import com.photon.medline.utils.DialogTwoButtonInterface


object AlertDialogHelper {
    fun dialogTwoButton(
        context: Context?, dialogInterface: DialogTwoButtonInterface, title: String?,
        msg: String?, positiveBtnText: String?, negativeBtnText: String?, cancellable: Boolean
    ) {
        val builder = AlertDialog.Builder(context)
        builder.setTitle(title)
        builder.setMessage(msg)
        builder.setPositiveButton(positiveBtnText) { dialog: DialogInterface?, _: Int ->
            dialogInterface.onPositiveButtonClick(dialog)
        }

        builder.setNegativeButton(negativeBtnText) { dialog: DialogInterface?, _: Int ->
            dialogInterface.onNegativeButtonClick(dialog)
        }
        val dialogs: Dialog = builder.create()
        dialogs.setCancelable(cancellable)
        dialogs.show()
    }

    /**
     * Privacy policy dialog
     * showing static privacy policy content
     * @return null
     * @param context
     */
    fun privacyPolicyDialog(context: Context) {
        val dialog = Dialog(context)
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE)
        val binding: LayoutPrivacyPolicyBinding = DataBindingUtil.inflate(
            LayoutInflater.from(context),
            R.layout.layout_privacy_policy,
            null,
            false
        )
        dialog.setContentView(binding.root)
        dialog.setCancelable(false)
        dialog.setCanceledOnTouchOutside(false)
        dialog.show()
        binding.icCancel.setOnClickListener {
            dialog.dismiss()
        }
        val privacyPolicy = object : ClickableSpan() {
            override fun onClick(widget: View) {
                dialog.dismiss()
            }

            override fun updateDrawState(ds: TextPaint) {
                super.updateDrawState(ds)
                ds.isUnderlineText = false
                ds.color = MedlineApp.application.getColor(R.color.login_btn_color)

            }
        }
        binding.privacyDescription.text = StringUtils.getSpannableString(
            privacyPolicy, binding.privacyDescription.context.getString(
                R.string.privacy_description
            ), binding.privacyDescription.context.getString(
                R.string.medlineprivacy_zendesk_com
            )
        )
    }


    /**
     * Term and condition dialog
     *showing static term and condition
     * @return null
     * @param context
     */
    fun termAndConditionDialog(context: Context) {
        val dialog = Dialog(context)
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE)
        val binding: LayoutTermAndConditionBinding = DataBindingUtil.inflate(
            LayoutInflater.from(context),
            R.layout.layout_term_and_condition,
            null,
            false
        )
        dialog.setContentView(binding.root)
        dialog.setCancelable(false)
        dialog.setCanceledOnTouchOutside(false)
        dialog.show()
        binding.icCancel.setOnClickListener {
            dialog.dismiss()
        }
        val privacyPolicy = object : ClickableSpan() {
            override fun onClick(widget: View) {
                dialog.dismiss()
            }

            override fun updateDrawState(ds: TextPaint) {
                super.updateDrawState(ds)
                ds.isUnderlineText = false
                ds.color = MedlineApp.application.getColor(R.color.login_btn_color)

            }
        }
        binding.privacyDescription.text = StringUtils.getSpannableString(
            privacyPolicy, binding.privacyDescription.context.getString(
                R.string.privacy_description
            ), binding.privacyDescription.context.getString(
                R.string.medlineprivacy_zendesk_com
            )
        )
    }
}