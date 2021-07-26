package com.photon.medline.epicModules.dashboard.hotline

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.photon.medline.R
import com.photon.medline.databinding.FragmentHotlineBinding

class HotlineFragment : Fragment() {
    private lateinit var hotlineViewModel: HotlineViewModel
    private lateinit var binding: FragmentHotlineBinding
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? = DataBindingUtil.inflate<FragmentHotlineBinding>(
        inflater,
        R.layout.fragment_hotline,
        container,
        false
    ).root

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding = DataBindingUtil.bind<FragmentHotlineBinding>(view)!!
        hotlineViewModel =
            ViewModelProvider(this).get(HotlineViewModel::class.java)
        binding.viewModel = hotlineViewModel
    }
}