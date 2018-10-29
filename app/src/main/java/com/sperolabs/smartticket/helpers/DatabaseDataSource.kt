package com.sperolabs.smartticket.helpers

import android.content.Context
import androidx.room.Room
import com.sperolabs.smartticket.room.SmartDatabase
import java.lang.RuntimeException

/**
 * Created by alessandros on 29/10/2018.
 * @author Alessandro Sperotti
 */
class DatabaseDataSource {

    init {
        if(mInstance != null)
            throw RuntimeException("Use getDbInstance() instead")
    }

    companion object {

        @Volatile
        private var stDbInstance : SmartDatabase? = null

        @Volatile
        private var mInstance : DatabaseDataSource? = null

        fun initDb(context: Context) : DatabaseDataSource {
            //TODO syncronized?
            if(mInstance == null){
                mInstance = DatabaseDataSource()

                //Inizializzo db dell'app
                stDbInstance = Room.databaseBuilder(context,
                        SmartDatabase::class.java,
                        "SmartTicketDb.db")//TODO nome db stringa
                        .allowMainThreadQueries()
                        .build()//TODO VERIFICA
            }

            return mInstance!!
        }

        fun getStDbInstance() : SmartDatabase {
            if(stDbInstance == null) throw RuntimeException("StDb not initialized")
            else return stDbInstance!!
        }

    }

}