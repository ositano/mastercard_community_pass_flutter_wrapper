package com.mastercard.compass.cp3.lib.flutter_wrapper.ui

import CompassApiHandlerActivity

import com.mastercard.compass.base.ConsentValue
import com.mastercard.compass.model.consent.Consent
import com.mastercard.compass.model.consent.ConsentResponse
import com.mastercard.compass.cp3.lib.flutter_wrapper.util.Key

class BiometricConsentCompassApiHandlerActivity: CompassApiHandlerActivity<ConsentResponse>() {
    override suspend fun callCompassApi() {
        val programGUID: String = intent.getStringExtra(Key.PROGRAM_GUID)!!

        val consent = Consent(ConsentValue.ACCEPT, programGUID)
        val response = compassKernelServiceInstance.saveBiometricConsent(consent)

        getNonIntentCompassApiResults(response)
    }
}