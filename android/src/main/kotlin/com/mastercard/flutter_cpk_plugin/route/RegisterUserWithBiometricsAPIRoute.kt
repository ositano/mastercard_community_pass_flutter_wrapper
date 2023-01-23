package com.mastercard.flutter_cpk_plugin.route

import android.app.Activity
import android.content.Intent
import com.mastercard.compass.base.Constants
import com.mastercard.compass.jwt.RegisterUserForBioTokenResponse
import com.mastercard.flutter_cpk_plugin.ui.RegisterUserForBioTokenCompassApiHandlerActivity
import com.mastercard.flutter_cpk_plugin.util.ErrorCode
import com.mastercard.flutter_cpk_plugin.util.Key
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class RegisterUserWithBiometricsAPIRoute(private val activity: Activity) {
    companion object {
        val REQUEST_CODE_RANGE = 300 until 400

        const val REGISTER_BIOMETRICS_REQUEST_CODE = 300
    }

    fun startRegisterUserWithBiometricsIntent(call: MethodCall){
        val programGuid = call.argument<String>(Key.PROGRAM_GUID)!!
        val reliantAppGuid = call.argument<String>(Key.RELIANT_APP_GUID)!!
        val consentId = call.argument<String>(Key.CONSENT_ID)

        val intent = Intent(activity, RegisterUserForBioTokenCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.PROGRAM_GUID, programGuid)
            putExtra(Key.RELIANT_APP_GUID, reliantAppGuid)
            putExtra(Key.CONSENT_ID, consentId)
        }

        activity.startActivityForResult(intent, REGISTER_BIOMETRICS_REQUEST_CODE)
    }

    fun handleRegisterUserWithBiometricsIntentResponse(
        resultCode: Int,
        data: Intent?,
        result: MethodChannel.Result
    ) {
        when (resultCode) {
            Activity.RESULT_OK -> result.success(data?.extras?.get(Key.DATA))
            Activity.RESULT_CANCELED -> {
                val code = data?.getIntExtra(Key.ERROR_CODE, ErrorCode.UNKNOWN).toString()
                val message = data?.getStringExtra(Key.ERROR_MESSAGE)!!
                result.error(code, message, null)
            }
        }
    }
}