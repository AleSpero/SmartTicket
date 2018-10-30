package com.sperolabs.smartticket

import android.app.Application
import com.sperolabs.smartticket.helpers.DatabaseDataSource

/**
 * Created by alessandros on 30/10/2018.
 * @author Alessandro Sperotti
 */
class SmartTicketApplication : Application() {

    override fun onCreate() {
        DatabaseDataSource.initDb(this)
        super.onCreate()
    }

}