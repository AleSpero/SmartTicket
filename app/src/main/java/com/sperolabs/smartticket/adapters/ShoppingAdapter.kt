package com.sperolabs.smartticket.adapters

import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextClock
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.sperolabs.smartticket.R
import com.sperolabs.smartticket.models.ShoppingItem
import java.util.*

/**
 * Created by alessandros on 27/10/2018.
 * @author Alessandro Sperotti
 */
class ShoppingAdapter(var itemList : List<ShoppingItem>) : RecyclerView.Adapter<ShoppingAdapter.ItemViewHolder>() {

    //TODO swipe to dismiss (world clockkk)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {
        val v = LayoutInflater.from(parent.context).inflate(R.layout.shopping_item, parent, false)
        return ItemViewHolder(v)
    }

    override fun getItemCount(): Int {
        return itemList.size
    }

    override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {
       holder.bindItem(itemList[position])
    }


    class ItemViewHolder(itemView : View) : RecyclerView.ViewHolder(itemView){

        fun bindItem(item : ShoppingItem){

            //bind con view
            val itemName = itemView.findViewById<TextView>(R.id.itemName)
            val totalCost = itemView.findViewById<TextView>(R.id.totalCost)
            val date = itemView.findViewById<TextView>(R.id.date)
            val nTickets = itemView.findViewById<TextView>(R.id.nTickets)

            itemName.text = item.name
            totalCost.text = item.cost.toString() //TODO aggiungi segno valuta
            date.text = item.date
            nTickets.text = item.ticketsNum.toString()
        }

   /* fun setDataList(citiesList: ArrayList<City>){
        cities = citiesList
        notifyDataSetChanged()
    }

    fun getItemAtPosition(position: Int) : ShoppingItem{
        return it[position]
    }*/
    }
}