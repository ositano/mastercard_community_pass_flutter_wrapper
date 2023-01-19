package com.mastercard.flutter_cpk_plugin.ui

import CompassApiHandlerActivity
import com.mastercard.flutter_cpk_plugin.util.Key.PROGRAM_GUID
import com.mastercard.flutter_cpk_plugin.util.Key.RID

class WriteProfileCompassApiHandlerActivity : CompassApiHandlerActivity<String>() {

    override suspend fun callCompassApi() {
        val programGuid: String = intent.getStringExtra(PROGRAM_GUID)!!
        val rId: String = intent.getStringExtra(RID)!!

        val intent = compassKernelServiceInstance.getWriteProfileActivityIntent(
            programGuid, rId
        )

        compassApiActivityResult.launch(intent)
    }
}