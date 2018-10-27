package com.sperolabs.smartticket

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.bottomappbar.BottomAppBar
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.sperolabs.smartticket.home.HomeFragment
import com.sperolabs.smartticket.scan.ScanFragment

class MainActivity : AppCompatActivity() {

    lateinit var bottomAppBar : BottomAppBar
    lateinit var barFab : FloatingActionButton
    private var currentFabAlignmentMode = BottomAppBar.FAB_ALIGNMENT_MODE_CENTER


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        bottomAppBar = findViewById(R.id.bar)
        barFab = findViewById(R.id.fab)

        setSupportActionBar(bottomAppBar)

        //Inflate fragment home
        val transaction = fragmentManager.beginTransaction()
        transaction.add(R.id.fragment_container, HomeFragment())
        transaction.commit()

        val addVisibilityChanged: FloatingActionButton.OnVisibilityChangedListener = object : FloatingActionButton.OnVisibilityChangedListener() {
            override fun onShown(fab: FloatingActionButton?) {
                super.onShown(fab)
            }
            override fun onHidden(fab: FloatingActionButton?) {
                super.onHidden(fab)
                bottomAppBar.toggleFabAlignment()
                // ? approfondisci
                bottomAppBar.replaceMenu(
                        if(currentFabAlignmentMode == BottomAppBar.FAB_ALIGNMENT_MODE_CENTER) R.menu.home_menu
                        else R.menu.scan_menu
                )
                fab?.setImageDrawable(
                        if(currentFabAlignmentMode == BottomAppBar.FAB_ALIGNMENT_MODE_CENTER) getDrawable(R.drawable.ic_add)
                        else getDrawable(R.drawable.ic_search)
                )
                fab?.show()
            }
        }


        barFab.setOnClickListener {
            swapToScan(addVisibilityChanged)
        }

    }

    fun swapToScan(listener : FloatingActionButton.OnVisibilityChangedListener){


        //Change bottomappbar behaviour
        barFab.hide(listener)

        //Inflate fragment scan
        val transaction = fragmentManager.beginTransaction()
        transaction.add(R.id.fragment_container, ScanFragment())
        transaction.commit()

    }

    private fun BottomAppBar.toggleFabAlignment() {
        fabAlignmentMode = currentFabAlignmentMode.xor(1)
        currentFabAlignmentMode = fabAlignmentMode
    }


}
