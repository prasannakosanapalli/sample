package com.photon.medline.utils

import android.content.DialogInterface

interface DialogTwoButtonInterface {
    fun onPositiveButtonClick(dialog: DialogInterface?)
    fun onNegativeButtonClick(dialog: DialogInterface?)
}