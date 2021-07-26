package com.photon.medline.utils

import android.app.Activity
import android.content.Intent
import android.database.Cursor
import android.graphics.*
import android.media.ExifInterface
import android.net.Uri
import android.provider.MediaStore
import android.util.Log
import androidx.core.content.FileProvider
import androidx.fragment.app.Fragment
import com.theartofdev.edmodo.cropper.CropImage
import com.theartofdev.edmodo.cropper.CropImageView
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.FileNotFoundException
import java.io.IOException


class ImageInputHelper {
    private var tempFileFromSource: File? = null
    private var tempUriFromSource: Uri? = null
    lateinit var imagePath: String
    private var mContext: Activity
    private var fragment: Fragment? = null
    private var imageActionListener: ImageActionListner? = null

    constructor(context: Activity) {
        this.mContext = context
    }

    constructor(fragment: Fragment) {
        this.fragment = fragment
        this.mContext = fragment.requireActivity()
    }

    /**
     * Set image action listener
     *
     * @param imageActionListner
     */
    fun setImageActionListener(imageActionListner: ImageActionListner) {
        this.imageActionListener = imageActionListner
    }

    /**
     *  this method is used to take a callback from activity
     *
     * @param requestCode
     * @param resultCode
     * @param data
     */
    fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (resultCode == Activity.RESULT_OK) {
            if (requestCode == REQUEST_PICTURE_FROM_GALLERY) {
                data?.data.let { performCrop(it) }
            } else if (requestCode == REQUEST_PICTURE_FROM_CAMERA) {
                performCrop(tempUriFromSource)
            } else if (requestCode == CropImage.CROP_IMAGE_ACTIVITY_REQUEST_CODE) {
                val result = CropImage.getActivityResult(data)
                val resultUris = compressBitmap(result.uri)
                val resultUri = compressImage(result.uri.toString())
                imageActionListener?.onImagePicSelected(resultUris)
                imageActionListener?.onImagePicSelected(result.uri)
                imageActionListener?.onImagePicSelected(resultUri!!, "")
            }
        }
    }

    /**
     * Compress bitmap
     *
     * @param imageUri
     * @return
     */
    fun compressBitmap(imageUri: Uri): Bitmap {
        val bitmapImage = BitmapFactory.decodeFile(imageUri.path)
        val nh = (bitmapImage.height * (1280.0 / bitmapImage.width)).toInt()
        val scaledBitmap = Bitmap.createScaledBitmap(bitmapImage, 1280, nh, true)
        val outStream = ByteArrayOutputStream()
        // compress to the format you want, JPEG, PNG...
        // 70 is the 0-100 quality percentage
        // compress to the format you want, JPEG, PNG...
        // 70 is the 0-100 quality percentage
        scaledBitmap.compress(Bitmap.CompressFormat.WEBP, 70, outStream)
        return scaledBitmap
    }

    fun compressImage(imageUri: String?): Bitmap? {
        val filePath = getRealPathFromURI(imageUri!!)
        var scaledBitmap: Bitmap? = null
        val options = BitmapFactory.Options()

//      by setting this field as true, the actual bitmap pixels are not loaded in the memory. Just the bounds are loaded. If
//      you try the use the bitmap here, you will get null.
        options.inJustDecodeBounds = true
        var bmp = BitmapFactory.decodeFile(filePath, options)
        var actualHeight = options.outHeight
        var actualWidth = options.outWidth

//      max Height and width values of the compressed image is taken as 816x612
        val maxHeight = 816.0f
        val maxWidth = 612.0f
        var imgRatio = actualWidth / actualHeight.toFloat()
        val maxRatio = maxWidth / maxHeight

//      width and height values are set maintaining the aspect ratio of the image
        if (actualHeight > maxHeight || actualWidth > maxWidth) {
            if (imgRatio < maxRatio) {
                imgRatio = maxHeight / actualHeight
                actualWidth = (imgRatio * actualWidth).toInt()
                actualHeight = maxHeight.toInt()
            } else if (imgRatio > maxRatio) {
                imgRatio = maxWidth / actualWidth
                actualHeight = (imgRatio * actualHeight).toInt()
                actualWidth = maxWidth.toInt()
            } else {
                actualHeight = maxHeight.toInt()
                actualWidth = maxWidth.toInt()
            }
        }

//      setting inSampleSize value allows to load a scaled down version of the original image
        options.inSampleSize = calculateInSampleSize(options, actualWidth, actualHeight)

//      inJustDecodeBounds set to false to load the actual bitmap
        options.inJustDecodeBounds = false

//      this options allow android to claim the bitmap memory if it runs low on memory
        options.inPurgeable = true
        options.inInputShareable = true
        options.inTempStorage = ByteArray(16 * 1024)
        try {
//          load the bitmap from its path
            bmp = BitmapFactory.decodeFile(filePath, options)
        } catch (exception: OutOfMemoryError) {
            exception.printStackTrace()
        }
        try {
            scaledBitmap = Bitmap.createBitmap(actualWidth, actualHeight, Bitmap.Config.ARGB_8888)
        } catch (exception: OutOfMemoryError) {
            exception.printStackTrace()
        }
        val ratioX = actualWidth / options.outWidth.toFloat()
        val ratioY = actualHeight / options.outHeight.toFloat()
        val middleX = actualWidth / 2.0f
        val middleY = actualHeight / 2.0f
        val scaleMatrix = Matrix()
        scaleMatrix.setScale(ratioX, ratioY, middleX, middleY)
        val canvas = Canvas(scaledBitmap!!)
        canvas.setMatrix(scaleMatrix)
        canvas.drawBitmap(
            bmp,
            middleX - bmp.width / 2,
            middleY - bmp.height / 2,
            Paint(Paint.FILTER_BITMAP_FLAG)
        )

//      check the rotation of the image and display it properly
        val exif: ExifInterface
        try {
            exif = ExifInterface(filePath!!)
            val orientation: Int = exif.getAttributeInt(
                ExifInterface.TAG_ORIENTATION, 0
            )
            Log.d("EXIF", "Exif: $orientation")
            val matrix = Matrix()
            if (orientation == 6) {
                matrix.postRotate(90F)
                Log.d("EXIF", "Exif: $orientation")
            } else if (orientation == 3) {
                matrix.postRotate(180F)
                Log.d("EXIF", "Exif: $orientation")
            } else if (orientation == 8) {
                matrix.postRotate(270F)
                Log.d("EXIF", "Exif: $orientation")
            }
            scaledBitmap = Bitmap.createBitmap(
                scaledBitmap, 0, 0,
                scaledBitmap.width, scaledBitmap.height, matrix,
                true
            )
        } catch (e: IOException) {
            e.printStackTrace()
        }
        var out: ByteArrayOutputStream? = null
       // val filename = getFilename()
        try {
            out = ByteArrayOutputStream()

//          write the compressed bitmap at the destination specified by filename.
            scaledBitmap!!.compress(Bitmap.CompressFormat.JPEG, 80, out)
        } catch (e: FileNotFoundException) {
            e.printStackTrace()
        }
        return scaledBitmap
    }

    //   fun getFilename(): String? {
    //  val file =
    //      File(Environment.getExternalStorageDirectory().path, "MyFolder/Images")
    //  if (!file.exists()) {
    //      file.mkdirs()
    //  }
    //  return file.absolutePath + "/" + System.currentTimeMillis() + ".jpg"
    //}

    private fun getRealPathFromURI(contentURI: String): String? {
        val contentUri = Uri.parse(contentURI)
        val cursor: Cursor? =
            mContext.contentResolver.query(contentUri, null, null, null, null)
        return if (cursor == null) {
            contentUri.path
        } else {
            cursor.moveToFirst()
            val index = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA)
            cursor.getString(index)
        }
    }

    fun calculateInSampleSize(
        options: BitmapFactory.Options,
        reqWidth: Int,
        reqHeight: Int
    ): Int {
        val height = options.outHeight
        val width = options.outWidth
        var inSampleSize = 1
        if (height > reqHeight || width > reqWidth) {
            val heightRatio =
                Math.round(height.toFloat() / reqHeight.toFloat())
            val widthRatio =
                Math.round(width.toFloat() / reqWidth.toFloat())
            inSampleSize = if (heightRatio < widthRatio) heightRatio else widthRatio
        }
        val totalPixels = width * height.toFloat()
        val totalReqPixelsCap = reqWidth * reqHeight * 2.toFloat()
        while (totalPixels / (inSampleSize * inSampleSize) > totalReqPixelsCap) {
            inSampleSize++
        }
        return inSampleSize
    }

    /**
     *  this method used for used convert uri to string path
     * private fun getPathFromUri(uri: Uri): String {
    val path: String? = uri.path
    val databaseUri: Uri
    val selection: String?
    val selectionArgs: Array<String>?
    if (path != null && path.contains("/document/image:")) {
    databaseUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI
    selection = "_id=?"
    selectionArgs = arrayOf(DocumentsContract.getDocumentId(uri).split(":")[1])
    } else {
    databaseUri = uri
    selection = null
    selectionArgs = null
    }
    try {
    val projection = arrayOf(
    MediaStore.Images.Media.DATA,
    MediaStore.Images.Media._ID,
    MediaStore.Images.Media.ORIENTATION,
    MediaStore.Images.Media.DATE_TAKEN
    )
    val cursor = mContext.contentResolver.query(
    databaseUri,
    projection,
    selection,
    selectionArgs,
    null
    )
    if (cursor != null && cursor.moveToFirst()) {
    val columnIndex = cursor.getColumnIndex(projection[0])
    imagePath = cursor.getString(columnIndex)
    }
    cursor?.close()
    } catch (e: Exception) {
    Log.e(TAG, e.message, e)
    }
    if (imagePath.isNotEmpty()) {
    return imagePath
    } else {
    return ""
    }
    }
     * @param uri
     * @return
     */


    /**
     *  this method used for cropping image
     *
     * @param uri
     */
    private fun performCrop(uri: Uri?) {
        val intent =
            CropImage.activity(uri).setGuidelines(CropImageView.Guidelines.ON).getIntent(mContext)
        if (fragment == null) {
            mContext.startActivityForResult(intent, CropImage.CROP_IMAGE_ACTIVITY_REQUEST_CODE)
        } else {
            fragment?.startActivityForResult(intent, CropImage.CROP_IMAGE_ACTIVITY_REQUEST_CODE)
        }
    }

    /**
     * Select image from gallery
     *this method called to open gallery for selecting image
     */
    fun selectImageFromGallery() {
        chechListener()
        try {
            tempFileFromSource = File.createTempFile("choose", "png", mContext.externalCacheDir)
            tempUriFromSource = Uri.fromFile(tempFileFromSource)
        } catch (e: IOException) {
            e.printStackTrace()
        }
        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT)
        intent.addCategory(Intent.CATEGORY_OPENABLE)
        intent.putExtra(MediaStore.EXTRA_OUTPUT, tempUriFromSource)
        intent.type = "image/*"
        intent.putExtra(Intent.EXTRA_MIME_TYPES, arrayOf("image/*"))
        if (fragment == null) {
            mContext.startActivityForResult(intent, REQUEST_PICTURE_FROM_GALLERY)
        } else {
            fragment?.startActivityForResult(intent, REQUEST_PICTURE_FROM_GALLERY)
        }
    }

    /**
     * Chech listener
     *this method used to check for listener
     */
    fun chechListener() {
        if (imageActionListener == null) {
            throw RuntimeException(
                "ImageSelectionListener must be set before calling " +
                        "openGalleryIntent(),openCameraIntent() or requestCropImage()."
            )
        }
    }

    /**
     * Take photo with camera
     *this method is called to open camera and select image
     */
    fun takePhotoWithCamera() {
        chechListener()
        try {
            val tempFileFromSource =
                File.createTempFile(
                    "MedLineImage",
                    System.currentTimeMillis().toString() + ".jpeg",
                    mContext.externalCacheDir
                )
            tempUriFromSource = FileProvider.getUriForFile(
                mContext,
                "com.photon.medline.fileprovider",
                tempFileFromSource
            )
        } catch (e: IOException) {
            Log.e(TAG, e.message, e)
        }
        val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
        intent.putExtra(MediaStore.EXTRA_OUTPUT, tempUriFromSource)
        if (fragment == null) {
            mContext.startActivityForResult(intent, REQUEST_PICTURE_FROM_CAMERA)
        } else {
            fragment?.startActivityForResult(intent, REQUEST_PICTURE_FROM_CAMERA)
        }
    }

    /**
     * Image action listner
     *
     * @constructor Create empty Image action listner
     */
    interface ImageActionListner {
        fun onMediaSelected(imageUriList: List<String>, imagePathList: List<String>)
        fun onImagePicSelected(imageBitmap: Bitmap)
        fun onImagePicSelected(imageBitmap: Uri)
        fun onImagePicSelected(imageBitmap: Bitmap, img: String)
    }

    /**
     * Companion
     *
     * @constructor Create empty Companion
     */
    companion object {
        const val REQUEST_PICTURE_FROM_GALLERY = 23
        const val REQUEST_PICTURE_FROM_CAMERA = 24
        private const val TAG = "ImageInputHelper"
    }
}