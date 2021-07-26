package com.photon.medline.ui.croping

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Bundle
import android.util.Base64
import androidx.activity.viewModels
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import com.photon.medline.R
import com.photon.medline.databinding.ActivityImageCropBinding
import com.photon.medline.utils.GlobalPermission
import com.photon.medline.utils.ImageInputHelper
import dagger.hilt.android.AndroidEntryPoint
import java.io.ByteArrayOutputStream


/**
 * Image crop activity
 *
 * @constructor Create empty Image crop activity
 */
@AndroidEntryPoint
class ImageCropActivity : AppCompatActivity(), GlobalPermission.OnPermissionGranted,
    ImageInputHelper.ImageActionListner, ActivityCompat.OnRequestPermissionsResultCallback {
    private val viewModel: ImageCropViewModel by viewModels()
    private lateinit var binding: ActivityImageCropBinding
    private lateinit var globalPermission: GlobalPermission
    private lateinit var imageIntputHelper: ImageInputHelper
    private var photoBitmap: Bitmap? = null
    private val permissionList = arrayOf(
        android.Manifest.permission.READ_EXTERNAL_STORAGE,
        android.Manifest.permission.WRITE_EXTERNAL_STORAGE,
        android.Manifest.permission.CAMERA
    )

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_image_crop)
        binding.viewModel = viewModel
        imageIntputHelper = ImageInputHelper(this)
        imageIntputHelper.setImageActionListener(this)
        viewModel.mutableLiveData.observe(this, Observer { result ->
            if (result == 101) {
                checkPermissions()
            }
        })
    }

    /**
     *  this method used for check storage  permission
     *
     */
    private fun checkPermissions() {
        globalPermission = GlobalPermission(this, permissionList, this)
        globalPermission.setUnique(111)
        globalPermission.checkPermission()
    }

    override fun onPermissionGranted(statusCode: Int) {
        if (statusCode == 111) {
            showOptions()
        } else {
            checkPermissions()
        }
    }

    @SuppressLint("MissingSuperCall")
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String>,
        grantResults: IntArray
    ) {
        if (grantResults.isNotEmpty()) {
            globalPermission.onRequestPermissionsResult(requestCode, permissions, grantResults)
        }
    }

    /**
     *  overide method
     *
     * @param requestCode
     * @param resultCode
     * @param data
     */
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == Activity.RESULT_OK) {
            imageIntputHelper.onActivityResult(requestCode, resultCode, data)
        }
    }

    /**
     *  this method is used for show pop
     *  selecting image option from gallery and camera
     *
     */
    private fun showOptions() {
        val listItems = arrayOf(getString(R.string.camera), getString(R.string.gallery))
        val mBuilder = AlertDialog.Builder(this)
        mBuilder.setTitle(getString(R.string.continueUsing))
        mBuilder.setSingleChoiceItems(listItems, -1) { dialog, i ->
            when (i) {
                0 -> imageIntputHelper.takePhotoWithCamera()
                1 -> imageIntputHelper.selectImageFromGallery()
            }
            dialog.dismiss()
        }
        val mDilog = mBuilder.create()
        mDilog.show()
    }

    override fun onMediaSelected(imageUriList: List<String>, imagePathList: List<String>) {
        // cdnjfcdsnck
    }

    override fun onImagePicSelected(imageBitmap: Bitmap) {
        photoBitmap = imageBitmap
        if (photoBitmap != null) {
            binding.compressedImage.setImageBitmap(photoBitmap)
            val sizeKb = photoBitmap!!.byteCount / 1024
            binding.compressedImageText.text = "KB size=$sizeKb"
        }

    }


    override fun onImagePicSelected(imageUri: Uri) {
        photoBitmap = BitmapFactory.decodeFile(imageUri.path)
        if (photoBitmap != null) {
            binding.imgProfile.setImageBitmap(photoBitmap)
            val sizeKb = photoBitmap!!.byteCount / 1024
            binding.profileText.text = "KB size=$sizeKb"
        }
        val baos = ByteArrayOutputStream()
        val b = baos.toByteArray()
        val encode = Base64.encode(b, Base64.DEFAULT)
    }

    override fun onImagePicSelected(imageBitmap: Bitmap, img: String) {
        photoBitmap = imageBitmap
        if (photoBitmap != null) {
            binding.bitmapImage.setImageBitmap(photoBitmap)
            val sizeKb = photoBitmap!!.byteCount / 1024
            binding.bitmapImageText.text = "KB size=$sizeKb"
        }
        val baos = ByteArrayOutputStream()
        val b = baos.toByteArray()
        val encode = Base64.encode(b, Base64.DEFAULT)
    }
}