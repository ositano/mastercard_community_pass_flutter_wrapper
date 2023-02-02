package com.mastercard.flutter_cpk_plugin.route

import android.app.Activity
import android.content.Intent
import com.mastercard.compass.model.consent.ConsentResponse
import com.mastercard.flutter_cpk_plugin.ui.BiometricConsentCompassApiHandlerActivity
import com.mastercard.flutter_cpk_plugin.util.ErrorCode
import com.mastercard.flutter_cpk_plugin.util.Key
import com.mastercard.flutter_cpk_plugin.util.ResponseKeys
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class BiometricConsentAPIRoute(private val activity: Activity) {
    companion object {
        val REQUEST_CODE_RANGE = 600 until 700

        const val BIOMETRIC_CONSENT_REQUEST_CODE = 600
    }

    fun startBiometricConsentIntent(call: MethodCall){
        val programGuid = call.argument<String>(Key.PROGRAM_GUID)!!
        val reliantAppGuid = call.argument<String>(Key.RELIANT_APP_GUID)!!

        val intent = Intent(activity, BiometricConsentCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.PROGRAM_GUID, programGuid)
            putExtra(Key.RELIANT_APP_GUID, reliantAppGuid )
        }

        activity.startActivityForResult(intent, BIOMETRIC_CONSENT_REQUEST_CODE)
    }

    fun handleBiometricConsentIntentResponse(
        resultCode: Int,
        data: Intent?,
        result: MethodChannel.Result
    ) {

        when (resultCode) {
            Activity.RESULT_OK -> {
                val response: ConsentResponse = data?.extras?.get(Key.DATA) as ConsentResponse
                result.success(
                    hashMapOf(
                        ResponseKeys.CONSENT_ID to response.consentId,
                        ResponseKeys.RESPONSE_STATUS to response.responseStatus.toString()
                    )
                )
            }
            Activity.RESULT_CANCELED -> {
                val code = data?.getIntExtra(Key.ERROR_CODE, ErrorCode.UNKNOWN).toString()
                val message = data?.getStringExtra(Key.ERROR_MESSAGE) ?: "Unknown error"
                result.error(code, message, null)
            }
        }
    }
}