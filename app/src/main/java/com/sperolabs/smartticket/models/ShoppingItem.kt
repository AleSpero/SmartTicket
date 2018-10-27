package com.sperolabs.smartticket.models

import java.util.*

/**
 * Created by alessandros on 27/10/2018.
 * @author Alessandro Sperotti
 */
class ShoppingItem(val id : Long, var name : String, val date : Date, var cost : Double = 0.0, items : List<Product>?, var ticketsNum : Int = 0)
//Cost serve? bata fare somma di costo items