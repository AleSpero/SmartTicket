package com.sperolabs.smartticket.ocr

import android.app.Activity
import android.os.Bundle
import android.widget.ImageView
import com.sperolabs.smartticket.R
import io.fotoapparat.Fotoapparat
import io.fotoapparat.characteristic.LensPosition
import io.fotoapparat.configuration.CameraConfiguration
import io.fotoapparat.configuration.UpdateConfiguration
import io.fotoapparat.selector.*
import io.fotoapparat.view.CameraView


/**
 * Created by alessandros on 02/11/2018.
 * @author Alessandro Sperotti
 */
class OcrActivity : Activity() {

    private lateinit var fotoApparat: Fotoapparat
    private lateinit var cameraView: CameraView

    private var isFrontCamera = false
    private var flashEnabled = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_ocr)

        var cameraSide = findViewById<ImageView>(R.id.cameraSide)
        var flashButton = findViewById<ImageView>(R.id.flash)

        cameraView = findViewById(R.id.camera)

        fotoApparat = Fotoapparat(
                context = this,
                view = cameraView                   // view which will draw the camera preview
        )

        cameraSide.setOnClickListener {
            fotoApparat.switchTo(
                    if(fotoApparat.isAvailable { LensPosition.Back } and isFrontCamera) back() else front(),
                    CameraConfiguration.default())
            isFrontCamera = isFrontCamera.not()
        }

        flashButton.setOnClickListener {

            flashEnabled = flashEnabled.not()

            val flashType = if(flashEnabled) torch() else off()
            val flashIcon = if(flashEnabled) R.drawable.ic_flash_on else R.drawable.ic_flash_off

            flashButton.setImageDrawable(getDrawable(flashIcon))
            fotoApparat.updateConfiguration(UpdateConfiguration(
                    flashMode = flashType
            ))

        }

        //fotoApparat.updateConfiguration()
    }

    override fun onStart() {
        super.onStart()
        fotoApparat.start()
    }

    override fun onStop() {
        fotoApparat.stop()
        super.onStop()
    }
}