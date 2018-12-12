package com.sperolabs.smartticket.ocr

import android.app.Activity
import android.content.Context
import android.graphics.*
import android.os.Bundle
import android.util.Log
import android.widget.ImageView
import android.widget.Toast
import com.google.android.gms.tasks.Task
import com.google.firebase.ml.vision.FirebaseVision
import com.google.firebase.ml.vision.common.FirebaseVisionImage
import com.google.firebase.ml.vision.common.FirebaseVisionImageMetadata
import com.google.firebase.ml.vision.text.FirebaseVisionText
import com.google.firebase.ml.vision.text.FirebaseVisionTextRecognizer
import com.sperolabs.smartticket.R
import com.sperolabs.smartticket.utils.CameraUtils
import io.fotoapparat.Fotoapparat
import io.fotoapparat.characteristic.LensPosition
import io.fotoapparat.configuration.CameraConfiguration
import io.fotoapparat.configuration.UpdateConfiguration
import io.fotoapparat.preview.Frame
import io.fotoapparat.selector.*
import io.fotoapparat.util.FrameProcessor
import io.fotoapparat.view.CameraView
import com.google.android.gms.common.util.IOUtils.toByteArray
import android.graphics.ImageFormat.NV21
import android.hardware.Camera
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import android.os.Build
import android.util.SparseIntArray
import android.view.Surface
import java.io.ByteArrayOutputStream


/**
 * Created by alessandros on 02/11/2018.
 * @author Alessandro Sperotti
 */
class OcrActivity : Activity() {

    private lateinit var fotoApparat: Fotoapparat
    private lateinit var cameraView: CameraView
    private lateinit var textRecognizer : FirebaseVisionTextRecognizer
    private var currentProcessingTask : Task<FirebaseVisionText>? = null

    companion object {
    private val ORIENTATIONS = SparseIntArray()
        init {
            ORIENTATIONS.append(Surface.ROTATION_0, 90)
            ORIENTATIONS.append(Surface.ROTATION_90, 0)
            ORIENTATIONS.append(Surface.ROTATION_180, 270)
            ORIENTATIONS.append(Surface.ROTATION_270, 180)
        }
    }

    //private var stFrameProcessor: FrameProcessor = {frame -> }

    private var isBackCamera = false
    private var flashEnabled = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_ocr)

        var cameraSide = findViewById<ImageView>(R.id.cameraSide)
        var flashButton = findViewById<ImageView>(R.id.flash)

        cameraView = findViewById(R.id.camera)

        //Init text processor
        textRecognizer = FirebaseVision.getInstance().onDeviceTextRecognizer
        //TODO vedi come funziona cloud e valuta?


        fotoApparat = Fotoapparat(
                context = this,
                view = cameraView, // view which will draw the camera preview
               cameraConfiguration = CameraConfiguration(
                       frameProcessor = initFrameProcessor()
               )
        )
        cameraSide.setOnClickListener {
            fotoApparat.switchTo(
                    if(fotoApparat.isAvailable { LensPosition.Back } and isBackCamera) back() else front(),
                    CameraConfiguration.default())
            isBackCamera = isBackCamera.not()
        }

        flashButton.setOnClickListener {

            flashEnabled = flashEnabled.not()

            val flashType = if(flashEnabled) torch() else off()
            val flashIcon = if(isBackCamera and flashEnabled) R.drawable.ic_flash_on else R.drawable.ic_flash_off

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

    fun initFrameProcessor() : FrameProcessor {
        //Metodo che inizializza (e definisce) il comportamento del frame processor
        return {frame ->

            //TODO se sta processando allora droppa il frame attuale

            if(currentProcessingTask == null ||
                    (currentProcessingTask != null && currentProcessingTask!!.isComplete)) {

                //Calcolo metadata
                val imgMetadata = FirebaseVisionImageMetadata.Builder()
                        .setWidth(1600)
                        .setHeight(1200) //Todo regolati con questi parametri
                        .setFormat(FirebaseVisionImageMetadata.IMAGE_FORMAT_NV21)
                        /* TODO riguarda If you use the Camera2 API, capture images in ImageFormat.YUV_420_888 format.
                    If you use the older Camera API, capture images in ImageFormat.NV21 format.*/
                        .setRotation(
                                getRotationCompensation(if(isBackCamera) Camera.CameraInfo.CAMERA_FACING_FRONT
                                else Camera.CameraInfo.CAMERA_FACING_BACK, this,this)
                        ) //TODO rotationcompensation non funziona bene, debugga
                        .build()

                //debug

                /*val yuvImage = YuvImage(frame.image, ImageFormat.NV21, 1600, 1200, null)
                val os = ByteArrayOutputStream()
                yuvImage.compressToJpeg(Rect(0, 0, 1600, 1200), 100, os)
                val jpegByteArray = os.toByteArray()
                val bitmap = BitmapFactory.decodeByteArray(jpegByteArray, 0, jpegByteArray.size)*/


                //ottengo immagine
                var firebaseImg = FirebaseVisionImage.fromByteArray(frame.image, imgMetadata)

                //Processo!
               currentProcessingTask = textRecognizer.processImage(firebaseImg)
                        //TODO valuta di aggiungere oncompletelistener al posto di questi due
                        .addOnSuccessListener {
                            //TODO wip
                            it.textBlocks.forEach { block ->
                                block.lines.forEach { line ->
                                    line.elements.forEach { element ->
                                        element.boundingBox
                                    }
                                }
                            }
                            Log.d("TEXT_PROCESSOR", it.text)
                           // Toast.makeText(this, it.text, Toast.LENGTH_LONG).show()

                        }

                        .addOnFailureListener {
                            //TODO che faccio?
                            Log.d("TEXT_PROCESSOR_ERROR", it.message)

                        }
            }

        }
    }

    /**
     * Get the angle by which an image must be rotated given the device's current
     * orientation.
     */
    @Throws(CameraAccessException::class)
    private fun getRotationCompensation(cameraId: Int, activity: Activity, context: Context): Int {
        // Get the device's current rotation relative to its "native" orientation.
        // Then, from the ORIENTATIONS table, look up the angle the image must be
        // rotated to compensate for the device's rotation.
        val deviceRotation = activity.windowManager.defaultDisplay.rotation
        var rotationCompensation = ORIENTATIONS.get(deviceRotation)

        // On most devices, the sensor orientation is 90 degrees, but for some
        // devices it is 270 degrees. For devices with a sensor orientation of
        // 270, rotate the image an additional 180 ((270 + 270) % 360) degrees.
        val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
        val sensorOrientation = cameraManager
                .getCameraCharacteristics(cameraId.toString())
                .get(CameraCharacteristics.SENSOR_ORIENTATION)!!
        rotationCompensation = (rotationCompensation + sensorOrientation + 270) % 360

        // Return the corresponding FirebaseVisionImageMetadata rotation value.
        val result: Int
        when (rotationCompensation) {
            0 -> result = FirebaseVisionImageMetadata.ROTATION_0
            90 -> result = FirebaseVisionImageMetadata.ROTATION_90
            180 -> result = FirebaseVisionImageMetadata.ROTATION_180
            270 -> result = FirebaseVisionImageMetadata.ROTATION_270
            else -> {
                result = FirebaseVisionImageMetadata.ROTATION_0
                Log.e("OcrActivity", "Bad rotation value: $rotationCompensation")
            }
        }
        return result
    }

}