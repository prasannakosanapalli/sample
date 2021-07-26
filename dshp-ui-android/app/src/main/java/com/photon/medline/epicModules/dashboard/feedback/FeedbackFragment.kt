package com.photon.medline.epicModules.dashboard.feedback

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.photon.medline.R
import com.photon.medline.databinding.FragmentFeedbackBinding

class FeedbackFragment : Fragment() {
    private lateinit var feedbackViewModel: FeedbackViewModel
    private lateinit var binding: FragmentFeedbackBinding
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? = DataBindingUtil.inflate<FragmentFeedbackBinding>(
        inflater,
        R.layout.fragment_feedback,
        container,
        false
    ).root

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding = DataBindingUtil.bind<FragmentFeedbackBinding>(view)!!
        feedbackViewModel =
            ViewModelProvider(this).get(FeedbackViewModel::class.java)
        binding.viewModel = feedbackViewModel
    }
}