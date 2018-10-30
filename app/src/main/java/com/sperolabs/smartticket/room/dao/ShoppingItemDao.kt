package com.sperolabs.smartticket.room.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.sperolabs.smartticket.models.ShoppingItem

/**
 * Created by alessandros on 29/10/2018.
 * @author Alessandro Sperotti
 */

@Dao
interface ShoppingItemDao {

    @Insert
    fun addShoppingItem(item : ShoppingItem)

    @Query("SELECT * FROM shopping_item")
    fun getAllItems() : List<ShoppingItem>

}