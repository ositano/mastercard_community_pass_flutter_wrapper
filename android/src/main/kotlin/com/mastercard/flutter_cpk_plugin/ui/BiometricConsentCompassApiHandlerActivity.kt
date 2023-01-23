package com.mastercard.flutter_cpk_plugin.ui

import CompassApiHandlerActivity

import com.mastercard.compass.base.ConsentValue
import com.mastercard.compass.model.consent.Consent
import com.mastercard.flutter_cpk_plugin.util.Key

class BiometricConsentCompassApiHandlerActivity: CompassApiHandlerActivity<String>() {
    override suspend fun callCompassApi() {
        val programGuid: String = intent.getStringExtra(Key.PROGRAM_GUID)!!

        val consent = Consent(ConsentValue.ACCEPT, programGuid)
        val response = compassKernelServiceInstance.saveBiometricConsent(consent)
        val consentId = response.consentId

        getNonIntentCompassApiResults(consentId)
    }
}