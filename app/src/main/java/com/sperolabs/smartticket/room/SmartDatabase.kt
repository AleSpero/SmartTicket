package com.sperolabs.smartticket.room

import androidx.room.Database
import com.sperolabs.smartticket.models.Product
import com.sperolabs.smartticket.models.ShoppingItem

/**
 * Created by alessandros on 29/10/2018.
 * @author Alessandro Sperotti
 */

@Database(version = 1, entities = [Product::class, ShoppingItem::class])
class SmartDatabase {
}