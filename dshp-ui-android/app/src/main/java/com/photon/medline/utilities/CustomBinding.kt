package com.photon.medline.utils

import android.graphics.drawable.Drawable
import android.text.method.HideReturnsTransformationMethod
import android.text.method.PasswordTransformationMethod
import androidx.appcompat.widget.AppCompatEditText
import androidx.appcompat.widget.AppCompatImageView
import androidx.appcompat.widget.AppCompatTextView
import androidx.databinding.BindingAdapter
import com.bumptech.glide.Glide
import com.photon.medline.R

@BindingAdapter("bannerImage")
fun bannerImage(view: AppCompatImageView, image: String) {
    Glide.with(view.context).load(image).error(R.drawable.cat).into(view)
}

@BindingAdapter("srcCompat")
fun bindSrcCompat(imageView: AppCompatImageView, drawable: Drawable) {
    imageView.setImageDrawable(drawable)
}

@BindingAdapter("drawableStart")
fun bindDrawableStart(textView: AppCompatTextView, drawable: Drawable) {
    textView.setCompoundDrawablesRelativeWithIntrinsicBounds(drawable, null, null, null)
}

@BindingAdapter("background")
fun bindSrcCompat(textView: AppCompatTextView, drawable: Drawable) {
    textView.setBackgroundDrawable(drawable)
}

@BindingAdapter("hideShowText")
fun bindSrcCompat(editText: AppCompatEditText, hideShowText: Boolean) {
    if (hideShowText) {
        editText.transformationMethod = HideReturnsTransformationMethod.getInstance()
    } else {
        editText.transformationMethod = PasswordTransformationMethod.getInstance()
    }
    if (editText.text != null && !editText.text.toString().isEmpty()) {
        editText.setSelection(editText.text!!.length)
    }
}
