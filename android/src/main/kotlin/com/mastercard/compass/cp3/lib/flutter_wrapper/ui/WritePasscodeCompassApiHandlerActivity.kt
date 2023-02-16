package com.mastercard.compass.cp3.lib.flutter_wrapper.ui

import CompassApiHandlerActivity
import com.mastercard.compass.cp3.lib.flutter_wrapper.util.Key

class WritePasscodeCompassApiHandlerActivity: CompassApiHandlerActivity<String>() {
    override suspend fun callCompassApi() {
        val passcode = intent.getStringExtra(Key.PASSCODE)!!
        val programGUID: String = intent.getStringExtra(Key.PROGRAM_GUID)!!
        val rId: String = intent.getStringExtra(Key.RID)!!

        val intent = compassKernelServiceInstance.getWritePasscodeActivityIntent(
            passcode,
            rId,
            programGUID
        )

        compassApiActivityResult.launch(intent)
    }
}