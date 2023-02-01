package com.mastercard.flutter_cpk_plugin.ui

import CompassApiHandlerActivity
import android.util.Log
import com.mastercard.compass.base.OperationMode
import com.mastercard.compass.model.biometrictoken.Modality
import com.mastercard.flutter_cpk_plugin.util.Key

class RegisterUserForBioTokenCompassApiHandlerActivity: CompassApiHandlerActivity<String>() {
    override suspend fun callCompassApi() {
        val reliantAppGuid: String = intent.getStringExtra(Key.RELIANT_APP_GUID)!!
        val programGuid: String = intent.getStringExtra(Key.PROGRAM_GUID)!!
        val consentId: String = intent.getStringExtra(Key.CONSENT_ID)!!

        val listOfModalities = mutableListOf<Modality>().apply {
//            add(Modality.FACE)
            add(Modality.LEFT_PALM)
            add(Modality.RIGHT_PALM)
        }

        val jwt = helper.generateBioTokenJWT(
            reliantAppGuid, programGuid, consentId, listOfModalities)

        val intent = compassKernelServiceInstance.getRegisterUserForBioTokenActivityIntent(
            jwt,
            reliantAppGuid,
            OperationMode.BEST_AVAILABLE
        )

        compassApiActivityResult.launch(intent)
    }

}