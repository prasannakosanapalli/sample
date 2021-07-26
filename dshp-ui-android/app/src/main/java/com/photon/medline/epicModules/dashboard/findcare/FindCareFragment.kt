package com.photon.medline.epicModules.dashboard.findcare

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.photon.medline.R
import com.photon.medline.databinding.FragmentFindcareBinding

class FindCareFragment : Fragment() {
    private lateinit var findCareViewModel: FindCareViewModel
    private lateinit var binding: FragmentFindcareBinding
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? = DataBindingUtil.inflate<FragmentFindcareBinding>(
        inflater,
        R.layout.fragment_findcare,
        container,
        false
    ).root

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding = DataBindingUtil.bind<FragmentFindcareBinding>(view)!!
        findCareViewModel =
            ViewModelProvider(this).get(FindCareViewModel::class.java)
        binding.viewModel = findCareViewModel
    }
}