package com.sperolabs.smartticket.scan

import android.app.Fragment
import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.bottomappbar.BottomAppBar
import com.sperolabs.smartticket.MainActivity
import com.sperolabs.smartticket.R
import com.sperolabs.smartticket.home.HomeContract

class ScanFragment : Fragment(), ScanContract.View {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        val view = inflater.inflate(R.layout.fragment_scan, container, false)
        val bottomAppBar = view.findViewById<BottomAppBar>(R.id.bar)

        (activity as AppCompatActivity).setSupportActionBar(bottomAppBar)

        return view
    }

    override fun onAttach(context: Context?) {
        MainActivity.currentFragment = MainActivity.SCAN_FRAGMENT
        super.onAttach(context)
    }

    override fun onDetach() {
        MainActivity.currentFragment = MainActivity.HOME_FRAGMENT
        super.onDetach()
    }


}