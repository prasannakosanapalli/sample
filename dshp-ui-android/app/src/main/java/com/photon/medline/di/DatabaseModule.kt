package com.photon.medline.di

import android.content.Context
import androidx.room.Room
import androidx.room.migration.Migration
import androidx.sqlite.db.SupportSQLiteDatabase
import com.photon.medline.db.AppDatabase
import com.photon.medline.epicModules.authentication.login.loginwithEmailPass.vm.data.local.LoginUserDao
import com.photon.medline.epicModules.authentication.resetpassword.local.ResetPasswordDao
import com.photon.medline.epicModules.authentication.signup.data.local.SignUpDao
import com.photon.medline.epicModules.dashboard.home.local.HomeFragmentDao
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent

/**
 * Created by Romesh
 * This is core class for Room DB here we handle the room version upgrade and downgrade.
 * Also we declared the room name private
 */
@InstallIn(SingletonComponent::class)
@Module
object DatabaseModule {
    // Database name should be always private so don't take any where out side the class
    private const val DATABASE_NAME = "medline.db"
    val MIGRATION_1_2: Migration = object : Migration(1, 2) {
        override fun migrate(database: SupportSQLiteDatabase) {
            // Note this piece line of code we will use when we upgrade the DB version.
            // Till the time i have commented this code
        }
    }

    @Provides
    fun provideAppDatabase(@ApplicationContext appContext: Context): AppDatabase {
        return Room.databaseBuilder(
            appContext,
            AppDatabase::class.java,
            DATABASE_NAME
        ).allowMainThreadQueries()//.addMigrations(MIGRATION_1_2)
            .build()
    }

    @Provides
    fun provideLoginDao(appDatabase: AppDatabase): LoginUserDao {
        return appDatabase.loginUserDao()
    }

    @Provides
    fun provideResetPasswordDao(appDatabase: AppDatabase): ResetPasswordDao {
        return appDatabase.resetPassword()
    }

    @Provides
    fun provideSignUpDao(appDatabase: AppDatabase): SignUpDao {
        return appDatabase.signUpDao()
    }

    @Provides
    fun provideHomeFragmentDao(appDatabase: AppDatabase): HomeFragmentDao {
        return appDatabase.homeFragmentDao()
    }
}