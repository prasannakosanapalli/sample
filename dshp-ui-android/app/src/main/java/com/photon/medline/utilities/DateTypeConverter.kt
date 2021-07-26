package com.photon.medline.utilities

import androidx.room.TypeConverter
import java.util.*

/**
 *Created by PAVANI P on 5/3/2021.
 */
class DateTypeConverter {
    @TypeConverter
    fun fromTimestamp(value: Long?): Date? {
        return value?.let { Date(it) }
    }

    @TypeConverter
    fun dateToTimestamp(date: Date?): Long? {
        return date?.time
    }
}