package com.mastercard.flutter_cpk_plugin.ui

import CompassApiHandlerActivity
import com.mastercard.flutter_cpk_plugin.util.Key

class WritePasscodeCompassApiHandlerActivity: CompassApiHandlerActivity<String>() {
    override suspend fun callCompassApi() {
        val passcode = intent.getStringExtra(Key.PASSCODE)!!
        val programGuid: String = intent.getStringExtra(Key.PROGRAM_GUID)!!
        val rId: String = intent.getStringExtra(Key.RID)!!

        val intent = compassKernelServiceInstance.getWritePasscodeActivityIntent(
            passcode,
            rId,
            programGuid
        )

        compassApiActivityResult.launch(intent)
    }
}