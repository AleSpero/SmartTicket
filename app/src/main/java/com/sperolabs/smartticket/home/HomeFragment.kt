package com.sperolabs.smartticket.home

import android.app.Fragment
import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.bottomappbar.BottomAppBar
import com.sperolabs.smartticket.MainActivity
import com.sperolabs.smartticket.R
import com.sperolabs.smartticket.adapters.ShoppingAdapter
import com.sperolabs.smartticket.helpers.DatabaseDataSource
import com.sperolabs.smartticket.home.HomeContract

class HomeFragment : Fragment(), HomeContract.View {

    lateinit var shoppingList: RecyclerView
    lateinit var emptyView: LinearLayout

    override fun onAttach(context: Context?) {
        MainActivity.currentFragment = MainActivity.HOME_FRAGMENT
        super.onAttach(context)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        val view = inflater.inflate(R.layout.fragment_home, container, false)

        shoppingList = view.findViewById(R.id.shoppingList)
        emptyView = view.findViewById(R.id.noItems)

        //setup recyclerview
        shoppingList.hasFixedSize()
        shoppingList.layoutManager = LinearLayoutManager(activity)

        return view
    }

    override fun onResume() {
        super.onResume()
        refreshList()
    }


    override fun refreshList() {

        //TODO query
        val items = DatabaseDataSource.getStDbInstance()
                .shoppingItemDao()
                .getAllItems()


        shoppingList.visibility = if (items.isNotEmpty()) View.VISIBLE else View.GONE
        emptyView.visibility = if (items.isEmpty()) View.VISIBLE else View.GONE

        //TODO setAdapter
        shoppingList.adapter = ShoppingAdapter(items)


    }

    override fun refreshBottomAppBar() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun swapToScan() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

}