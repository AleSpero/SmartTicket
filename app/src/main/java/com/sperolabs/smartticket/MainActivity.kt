package com.sperolabs.smartticket

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.google.android.material.bottomappbar.BottomAppBar
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.sperolabs.smartticket.home.HomeFragment
import com.sperolabs.smartticket.ocr.OcrActivity
import com.sperolabs.smartticket.scan.ScanFragment

class MainActivity : AppCompatActivity() {

    lateinit var bottomAppBar : BottomAppBar
    lateinit var barFab : FloatingActionButton
    private var currentFabAlignmentMode = BottomAppBar.FAB_ALIGNMENT_MODE_CENTER

    var addVisibilityChanged :FloatingActionButton.OnVisibilityChangedListener? = null

    companion object {
        val HOME_FRAGMENT = 0
        val SCAN_FRAGMENT = 1

        var currentFragment = HOME_FRAGMENT
    }


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

         addVisibilityChanged = object : FloatingActionButton.OnVisibilityChangedListener() {
            override fun onHidden(fab: FloatingActionButton?) {
                super.onHidden(fab)
                bottomAppBar.toggleFabAlignment()
                // ? approfondisci
                bottomAppBar.replaceMenu(
                        if(currentFragment == HOME_FRAGMENT) R.menu.home_menu
                        else R.menu.scan_menu
                )
                fab?.setImageDrawable(
                        if(currentFragment == HOME_FRAGMENT) getDrawable(R.drawable.ic_add)
                        else getDrawable(R.drawable.ic_search)
                )
                fab?.show()
            }
        }

            configBottomAppBar()
    }

    fun swapToScan(){
        //change bottomappbar behaviour
        configBottomAppBar()

        //Inflate fragment scan
        val transaction = fragmentManager.beginTransaction()
        transaction.add(R.id.fragment_container, ScanFragment())
                transaction.addToBackStack( "scan" )
        transaction.commit()

    }

    private fun BottomAppBar.toggleFabAlignment() {
        fabAlignmentMode = currentFragment
    }

    fun swapToOcr(){
        startActivity(Intent(this, OcrActivity::class.java))
    }

    override fun onBackPressed() {
        super.onBackPressed()
        configBottomAppBar()
    }

    fun configBottomAppBar(){
        barFab.hide(addVisibilityChanged)
        barFab.setOnClickListener {
            if (currentFragment == HOME_FRAGMENT) swapToScan()
            else swapToOcr()
        }

    }

    override fun onAttachFragment(fragment: Fragment?) {
        super.onAttachFragment(fragment)
    }


}
