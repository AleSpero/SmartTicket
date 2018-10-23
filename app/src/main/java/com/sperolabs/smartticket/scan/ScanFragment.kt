package com.sperolabs.smartticket.scan

import android.app.Fragment
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

class ScanFragment : Fragment(), ScanContract.View {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(inflater: LayoutInflater?, container: ViewGroup?, savedInstanceState: Bundle?): View {

       /* val view = inflater.inflate(R.layout.fragment_details, container, false)

        return view*/
         return super.onCreateView(inflater, container, savedInstanceState)
    }
}