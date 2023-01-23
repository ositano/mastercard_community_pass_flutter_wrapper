package com.mastercard.flutter_cpk_plugin.ui

import CompassApiHandlerActivity
import com.mastercard.compass.base.Constants
import com.mastercard.flutter_cpk_plugin.util.Key.PROGRAM_GUID
import com.mastercard.flutter_cpk_plugin.util.Key.RID
import com.mastercard.flutter_cpk_plugin.util.Key.OVERWRITE_CARD

class WriteProfileCompassApiHandlerActivity : CompassApiHandlerActivity<String>() {

    override suspend fun callCompassApi() {
        val programGuid: String = intent.getStringExtra(PROGRAM_GUID)!!
        val rId: String = intent.getStringExtra(RID)!!
        val overwriteCard: Boolean = intent.getBooleanExtra(OVERWRITE_CARD, false)

        val intent = compassKernelServiceInstance.getWriteProfileActivityIntent(
            programGuid, rId
        )

        intent?.putExtra(Constants.EXTRA_OVERWRITE_CARD, overwriteCard)
        compassApiActivityResult.launch(intent)
    }
}