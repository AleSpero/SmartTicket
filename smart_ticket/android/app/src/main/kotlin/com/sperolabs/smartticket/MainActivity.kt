package com.sperolabs.smartticket

import android.content.Intent
import android.os.Bundle
import com.google.firebase.FirebaseApp
import com.sperolabs.smartticket.ocr.OcrActivity
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

  val ST_CHANNEL = "smartTicket"
  val METHOD_OCR = "startOcr"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    //Rimango in ascolto per method channel dell'ocr
    MethodChannel(flutterView, ST_CHANNEL).setMethodCallHandler { methodCall, result ->

      when(methodCall.method){
        METHOD_OCR -> startActivity(Intent(this@MainActivity, OcrActivity::class.java))
      }
    }

    //Init firebase
    FirebaseApp.initializeApp(this)
  }
}
