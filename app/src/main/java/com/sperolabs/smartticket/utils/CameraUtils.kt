package com.sperolabs.smartticket.utils

import com.google.firebase.ml.vision.common.FirebaseVisionImageMetadata


/**
 * Created by alessandros on 11/11/2018.
 * @author Alessandro Sperotti
 */
class CameraUtils {
    companion object {

        fun getImageRotation(rotation : Int) : Int {
            return when(rotation){
                0 -> FirebaseVisionImageMetadata.ROTATION_0
                90 -> FirebaseVisionImageMetadata.ROTATION_90
                180 -> FirebaseVisionImageMetadata.ROTATION_180
                270 -> FirebaseVisionImageMetadata.ROTATION_270
                else -> FirebaseVisionImageMetadata.ROTATION_0
            }
        }


    }
}



