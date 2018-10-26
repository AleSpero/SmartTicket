package com.sperolabs.smartticket

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.sperolabs.smartticket.home.HomeFragment

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val transaction = fragmentManager.beginTransaction()
        transaction.add(R.id.fragment_container, HomeFragment())
        transaction.commit()

    }
}
