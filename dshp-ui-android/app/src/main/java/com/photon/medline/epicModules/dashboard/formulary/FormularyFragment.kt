package com.photon.medline.epicModules.dashboard.formulary

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.photon.medline.R
import com.photon.medline.databinding.FragmentFormularyBinding

class FormularyFragment : Fragment() {
    private lateinit var formularyViewModel: FormularyViewModel
    private lateinit var binding: FragmentFormularyBinding
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? = DataBindingUtil.inflate<FragmentFormularyBinding>(
        inflater,
        R.layout.fragment_formulary,
        container,
        false
    ).root

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding = DataBindingUtil.bind<FragmentFormularyBinding>(view)!!
        formularyViewModel =
            ViewModelProvider(this).get(FormularyViewModel::class.java)
        binding.viewModel = formularyViewModel
    }
}