package com.photon.medline.epicModules.dashboard.home

import androidx.databinding.Bindable
import androidx.databinding.BindingAdapter
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.firebase.crashlytics.internal.Logger
import com.photon.medline.BR
import com.photon.medline.R
import com.photon.medline.base.BaseViewModel
import com.photon.medline.epicModules.dashboard.home.adapter.ProductListAdapter
import com.photon.medline.epicModules.dashboard.home.model.HomeFragmentResponse
import com.photon.medline.epicModules.dashboard.home.model.ProductListModel
import com.photon.medline.epicModules.dashboard.home.repository.HomeFragmentRepository
import com.photon.medline.network.BaseNetworkCallbackHandler
import com.photon.medline.utilities.AppLogger
import com.photon.medline.utilities.Constants
import com.photon.medline.utilities.Status
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.onStart
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class HomeViewModel @Inject constructor(private val repository: HomeFragmentRepository) :
    BaseViewModel() {
    @Bindable
    var productListModel = ArrayList<ProductListModel>()
    private val TAG: String? = HomeViewModel::class.simpleName
    var progressEnable: Boolean = false
    var mutableLiveData = MutableLiveData<Int>()
    val _message = MutableLiveData<BaseNetworkCallbackHandler<HomeFragmentResponse>>()

    init {
        productList()
        apiCall()
    }

    fun productList() {
        productListModel.add(
            ProductListModel(
                "Product Selector",
                R.drawable.ic_product_selector
            )
        )
        productListModel.add(
            ProductListModel(
                "Education Resources",
                R.drawable.ic_educational_resources
            )
        )
        productListModel.add(
            ProductListModel(
                "Wound Management",
                R.drawable.ic_wound
            )
        )
        notifyPropertyChanged(BR.productListModel)
    }

    fun onTextChanged(
        s: CharSequence, start: Int,
        before: Int, count: Int
    ) {
        if (s.toString().equals("Steve")) {
            TAG?.let { AppLogger.info(it, "onTextChanged") }
        }
    }

    /**
     * Api call
     * this method is called to homefragment api call for product banner slider search
     * that's will return list of Object
     * @param null
     * @return list of Object
     *
     */
    fun apiCall() {
        viewModelScope.launch {
            try {
                repository.homeFragment().onStart {
                }.collect {
                    progressEnable = false
                    mutableLiveData.postValue(Constants.PROGRESS_ENABLE)
                    if (it.status == Status.SUCCESS) {
                        //  _message.postValue(it)
                    } else {
                        _message.postValue(it)
                    }
                }
            } catch (e: Exception) {
                Logger.TAG.let { AppLogger.error(it, "Login $e") }
            }
        }
    }
}

@BindingAdapter(value = ["productList", "viewModel"])
fun listBinding(
    recyclerView: RecyclerView,
    list: ArrayList<ProductListModel>,
    viewModel: HomeViewModel
) {
    val layoutManager =
        LinearLayoutManager(recyclerView.context, LinearLayoutManager.HORIZONTAL, false)
    recyclerView.layoutManager = layoutManager
    val productListAdaptor = ProductListAdapter(list, viewModel)
    recyclerView.adapter = productListAdaptor
}
