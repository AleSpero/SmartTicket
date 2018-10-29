package com.sperolabs.smartticket.models

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.PrimaryKey

/**
 * Created by alessandros on 27/10/2018.
 * @author Alessandro Sperotti
 */

@Entity(foreignKeys = [ForeignKey(entity = ShoppingItem::class,
        parentColumns = arrayOf("shopping_list_id"),
        childColumns = arrayOf("id"),
        onDelete = ForeignKey.CASCADE)])

class Product(@PrimaryKey val id :Int,
              val cost : Double,
              var name :String,
              @ColumnInfo(name = "shopping_list_id") var shoppingItemId : Int) {
}