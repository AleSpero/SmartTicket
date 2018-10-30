package com.sperolabs.smartticket.models

import androidx.room.Entity
import androidx.room.Ignore
import androidx.room.PrimaryKey
import java.util.*

/**
 * Created by alessandros on 27/10/2018.
 * @author Alessandro Sperotti
 */
@Entity(tableName = "shopping_item")
data class ShoppingItem(@PrimaryKey(autoGenerate = true) var id : Long,
                        var name : String,
                        var date : String,
                        var cost : Double = 0.0,
                        /*@Ignore var items : List<Product>?,*/
                        var ticketsNum : Int = 0)
//Cost serve? bata fare somma di costo items
//TODO Cambia nome field ticketnum in db che è sbaglito