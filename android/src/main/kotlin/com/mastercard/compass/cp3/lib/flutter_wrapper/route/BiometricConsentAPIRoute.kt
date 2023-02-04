package com.mastercard.compass.cp3.lib.flutter_wrapper.route

import android.app.Activity
import android.content.Intent
import com.mastercard.compass.model.consent.ConsentResponse
import com.mastercard.compass.cp3.java_flutter_wrapper.CompassApiFlutter
import com.mastercard.compass.cp3.java_flutter_wrapper.CompassApiFlutter.SaveBiometricConsentResult
import com.mastercard.compass.cp3.lib.flutter_wrapper.ui.BiometricConsentCompassApiHandlerActivity
import com.mastercard.compass.cp3.lib.flutter_wrapper.util.ErrorCode
import com.mastercard.compass.cp3.lib.flutter_wrapper.util.Key

class BiometricConsentAPIRoute(private val activity: Activity) {
    private lateinit var biometricConsentResult: CompassApiFlutter.Result<SaveBiometricConsentResult>

    companion object {
        val REQUEST_CODE_RANGE = 600 until 700

        const val BIOMETRIC_CONSENT_REQUEST_CODE = 600
    }

    fun startBiometricConsentIntent(reliantAppGuid: String, programGuid: String, result: CompassApiFlutter.Result<SaveBiometricConsentResult>?){
        val intent = Intent(activity, BiometricConsentCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.PROGRAM_GUID, programGuid)
            putExtra(Key.RELIANT_APP_GUID, reliantAppGuid )
        }

        biometricConsentResult = result!!
        activity.startActivityForResult(intent, BIOMETRIC_CONSENT_REQUEST_CODE)
    }

    fun handleBiometricConsentIntentResponse(
        resultCode: Int,
        data: Intent?
    ) {

        when (resultCode) {
            Activity.RESULT_OK -> {
                val response: ConsentResponse = data?.extras?.get(Key.DATA) as ConsentResponse
                val result = SaveBiometricConsentResult.Builder()
                    .setConsentId(response.consentId).setResponseStatus(CompassApiFlutter.ResponseStatus.SUCCESS).build()

                biometricConsentResult.success(result)
            }
            Activity.RESULT_CANCELED -> {
                val code = data?.getIntExtra(Key.ERROR_CODE, ErrorCode.UNKNOWN).toString()
                val message = data?.getStringExtra(Key.ERROR_MESSAGE) ?: "Unknown error"
                biometricConsentResult.error(Throwable(message))
            }
        }
    }
}