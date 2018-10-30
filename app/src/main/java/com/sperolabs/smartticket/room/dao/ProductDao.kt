package com.sperolabs.smartticket.room.dao

import androidx.room.Dao
import androidx.room.Insert
import com.sperolabs.smartticket.models.Product

/**
 * Created by alessandros on 29/10/2018.
 * @author Alessandro Sperotti
 */

@Dao
interface ProductDao {

    @Insert
    fun addProduct(product: Product)

}