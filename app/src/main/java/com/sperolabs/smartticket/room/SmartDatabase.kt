package com.sperolabs.smartticket.room

import androidx.room.Database
import androidx.room.RoomDatabase
import com.sperolabs.smartticket.models.Product
import com.sperolabs.smartticket.models.ShoppingItem
import com.sperolabs.smartticket.room.dao.ProductDao
import com.sperolabs.smartticket.room.dao.ShoppingItemDao

/**
 * Created by alessandros on 29/10/2018.
 * @author Alessandro Sperotti
 */

@Database(version = 1, entities = [Product::class, ShoppingItem::class])
abstract class SmartDatabase : RoomDatabase(){

    abstract fun productDao() : ProductDao
    abstract fun shoppingItemDao() : ShoppingItemDao

}