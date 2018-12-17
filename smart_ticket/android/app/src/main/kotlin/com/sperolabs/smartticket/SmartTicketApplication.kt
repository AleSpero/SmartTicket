package com.sperolabs.smartticket

import android.app.Application
import com.google.firebase.FirebaseApp
import io.flutter.app.FlutterApplication

/**
 * Created by alessandros on 16/12/2018.
 * @author Alessandro Sperotti
 */
class SmartTicketApplication : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()
        FirebaseApp.initializeApp(this)
    }
}