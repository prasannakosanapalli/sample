package com.photon.medline.epicModules.dashboard.home

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import com.photon.medline.R
import com.photon.medline.databinding.FragmentHomeBinding
import com.photon.medline.utilities.Constants
import com.photon.medline.utilities.CustomLoader
import com.photon.medline.utilities.Status
import com.photon.medline.utilities.Toaster
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class HomeFragment : Fragment() {
    private val homeViewModel: HomeViewModel by viewModels()
    private lateinit var binding: FragmentHomeBinding
    private var customLoader = CustomLoader()
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View = DataBindingUtil.inflate<FragmentHomeBinding>(
        inflater,
        R.layout.fragment_home,
        container,
        false
    ).root

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding = DataBindingUtil.bind<FragmentHomeBinding>(view)!!
        binding.viewModel = homeViewModel
        binding.wdtSearch.configViewModel(homeViewModel)
        customLoader = CustomLoader().getInstance()!!
        observable()
    }

    fun observable() {
        homeViewModel.mutableLiveData.observe(requireActivity(), Observer {
            when (it) {
                Constants.PROGRESS_ENABLE -> {
                    if (homeViewModel.progressEnable) {
                        customLoader.showProgress(requireContext())
                    } else {
                        customLoader.hideProgress()
                    }
                }
            }
        })

        homeViewModel._message.observe(requireActivity(), Observer { result ->
            when (result.status) {
                Status.SUCCESS -> {
                    Toaster.showToast(
                        requireContext(), result.data?.message, result.status, Toast.LENGTH_SHORT
                    )

                }
                Status.ERROR -> {
                    try {
                        Toaster.showToast(
                            requireContext(), result.message, result.status, Toast.LENGTH_SHORT
                        )

                    } catch (e: java.lang.Exception) {
                        e.printStackTrace()
                    }
                }
            }
        })
    }
}