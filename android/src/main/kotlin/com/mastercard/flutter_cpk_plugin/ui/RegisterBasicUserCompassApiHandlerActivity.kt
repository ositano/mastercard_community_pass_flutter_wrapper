package com.mastercard.flutter_cpk_plugin.ui

import CompassApiHandlerActivity
import com.mastercard.compass.model.biometrictoken.FormFactor
import com.mastercard.compass.model.passcode.RegisterBasicUserRequestV2
import com.mastercard.flutter_cpk_plugin.util.Key

class RegisterBasicUserCompassApiHandlerActivity: CompassApiHandlerActivity<String>() {
    override suspend fun callCompassApi() {
        val programGuid: String = intent.getStringExtra(Key.PROGRAM_GUID)!!

        val intent = compassKernelServiceInstance.getRegisterBasicUserActivityIntent(
            RegisterBasicUserRequestV2(programGuid, FormFactor.NONE)
        )

        compassApiActivityResult.launch(intent)
    }
}