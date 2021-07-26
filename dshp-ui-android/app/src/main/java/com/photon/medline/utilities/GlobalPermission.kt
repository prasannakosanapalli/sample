package com.photon.medline.utils

import android.app.Activity
import android.content.Context
import android.content.DialogInterface
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.provider.Settings
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.app.ActivityCompat.*
import androidx.fragment.app.Fragment
import com.photon.medline.R
import com.photon.medline.utilities.AlertDialogHelper

@Suppress("SENSELESS_COMPARISON")
class GlobalPermission {
    private var unique: Int = 0
    private lateinit var mContext: Activity
    private var fragment: Fragment? = null
    private var permissionList: Array<String> = emptyArray()
    private var onPermissionGranted: OnPermissionGranted? = null

    constructor(
        mContext: Activity,
        permissionLists: Array<String>,
        onPermissionGranted: OnPermissionGranted
    ) {
        this.mContext = mContext
        this.permissionList = permissionLists
        this.onPermissionGranted = onPermissionGranted
    }

    constructor(
        fragment: Fragment,
        permissionLists: Array<String>,
        onPermissionGranted: OnPermissionGranted
    ) {
        this.fragment = fragment
        this.permissionList = permissionLists
        this.onPermissionGranted = onPermissionGranted
    }

    constructor(activity: Activity) {
        this.mContext = activity
    }

    fun setPERMISSION(permissionLists: Array<String>) {
        this.permissionList = permissionLists
    }

    fun setUnique(unique: Int) {
        this.unique = unique
    }

    /**
     * Check permission
     *
     */
    @Suppress("DEPRECATION")
    fun checkPermission() {
        if (hasPermissions(mContext, *permissionList)) {
            if (fragment == null) {
                requestPermissions(mContext, permissionList, PERMISSION_ALL)
            } else fragment?.requestPermissions(permissionList, PERMISSION_ALL)
        } else {
            onPermissionGranted?.onPermissionGranted(unique)
        }
    }

    fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String>,
        grantResult: IntArray
    ) {
        var status = false
        when (requestCode) {
            PERMISSION_ALL -> {
                var allPermissionGranted = true
                if (grantResult.isNotEmpty()) for (grantResults in grantResult) if (grantResults != PackageManager.PERMISSION_GRANTED) {
                    allPermissionGranted = false
                }
                if (!allPermissionGranted) {
                    var somePermissionsForeverDenied = false
                    for (permission in permissions) {
                        if (shouldShowRequestPermissionRationale(
                                mContext,
                                permission
                            )
                        ) {
                            Log.e("denied", permission)
                            status = true
                        } else {
                            when (PackageManager.PERMISSION_GRANTED
                                ) {
                                checkSelfPermission(
                                    mContext,
                                    permission
                                ) -> {
                                    //allowed
                                    Log.e("allow", permission)
                                    somePermissionsForeverDenied = true
                                }
                            }
                        }
                    }
                    if (somePermissionsForeverDenied) {
                        AlertDialogHelper.dialogTwoButton(
                            mContext,
                            object : DialogTwoButtonInterface {
                                override fun onPositiveButtonClick(dialog: DialogInterface?) {
                                    val intent: Intent = Intent(
                                        Settings.ACTION_APPLICATION_SETTINGS,
                                        Uri.fromParts("package", mContext.packageName, null)
                                    )
                                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                                    mContext.startActivity(intent)
                                }

                                override fun onNegativeButtonClick(dialog: DialogInterface?) {
                                    dialog?.dismiss()
                                }
                            }, mContext.resources.getString(R.string.permission_title),
                            mContext.resources.getString(R.string.permission_msg),
                            mContext.resources.getString(R.string.setting),
                            mContext.resources.getString(R.string.cancel), false
                        )
                    }
                } else {
                    onPermissionGranted?.onPermissionGranted(unique)
                }
                if (status) {
                    onPermissionGranted?.onPermissionGranted(PERMISSION_REJECTED)
                }
            }
        }
    }

    interface OnPermissionGranted {
        fun onPermissionGranted(statusCode: Int)
    }

    companion object {
        private const val PERMISSION_ALL = 1234
        private const val PERMISSION_REJECTED = 0
        private fun hasPermissions(context: Context?, vararg permissions: String): Boolean {
            if (context != null && permissions != null) {
                for (permission in permissions) {
                    if (checkSelfPermission(
                            context,
                            permission
                        ) != PackageManager.PERMISSION_GRANTED
                    ) {
                        return false
                    }
                }
            }
            return true
        }
    }
}

