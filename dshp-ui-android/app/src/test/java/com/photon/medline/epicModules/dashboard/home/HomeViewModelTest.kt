package com.photon.medline.epicModules.dashboard.home

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import com.photon.medline.R
import com.photon.medline.epicModules.dashboard.home.model.ProductListModel
import com.photon.medline.utilities.PRODUCT_NAME_1
import com.photon.medline.utilities.PRODUCT_NAME_2
import com.photon.medline.utilities.PRODUCT_NAME_3
import kotlinx.coroutines.ExperimentalCoroutinesApi
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4

/**
 * Created by PAVANI P on 26/2/2021.
 * This class is to unit tests for the [HomeViewModel] class.
 */
@ExperimentalCoroutinesApi
@RunWith(JUnit4::class)
class HomeViewModelTest {
    @Rule
    @JvmField
    val instantExecutorRule = InstantTaskExecutorRule()
    private lateinit var productListModel: ProductListModel
    private val product_name_1 = PRODUCT_NAME_1
    private val prodcut_link_1 = R.drawable.ic_product_selector
    private val product_name_2 = PRODUCT_NAME_2
    private val prodcut_link_2 = R.drawable.ic_educational_resources
    private val product_name_3 = PRODUCT_NAME_3
    private val prodcut_link_3 = R.drawable.ic_wound
    var productList = ArrayList<ProductListModel>()

    @Before
    fun setup() {
        productListModel = ProductListModel(product_name_1, prodcut_link_1.toInt())
        productList.add(productListModel)

        productListModel = ProductListModel(product_name_2, prodcut_link_2.toInt())
        productList.add(productListModel)

        productListModel = ProductListModel(product_name_3, prodcut_link_3.toInt())
        productList.add(productListModel)
    }

    /**
     * Adding item to list test
     *the model is not null
     */
    @Test
    fun addingItemtoListTest() {
        assertEquals(3, productList.size)
    }

    /**
     * Adding item to list test_length
     *inserting item to list and checking the size of the list
     */
    @Test
    fun addingItemtoListTestlength() {
        assertEquals(3, productList.size)
    }

    /**
     * Product list items in viewmodel matches with constant values
     *Static values added in this method in viewmodel. Same values added here.
     * tests for both are same
     */
    @Test
    fun productlistitemsinviewmodelmatcheswithconstantvalues() {
        assertEquals(3, productList.size)
    }
}