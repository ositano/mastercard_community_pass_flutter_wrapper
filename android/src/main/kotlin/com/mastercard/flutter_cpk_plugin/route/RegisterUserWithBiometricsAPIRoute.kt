package com.mastercard.flutter_cpk_plugin.route

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import com.mastercard.compass.base.Constants
import com.mastercard.compass.jwt.JWTResponseParser
import com.mastercard.compass.jwt.RegisterUserForBioTokenResponse
import com.mastercard.flutter_cpk_plugin.CompassKernelUIController
import com.mastercard.flutter_cpk_plugin.ui.RegisterUserForBioTokenCompassApiHandlerActivity
import com.mastercard.flutter_cpk_plugin.util.ErrorCode
import com.mastercard.flutter_cpk_plugin.util.Key
import com.mastercard.flutter_cpk_plugin.util.ResponseKeys
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.security.PublicKey

class RegisterUserWithBiometricsAPIRoute(private val activity: Activity) {
    companion object {
        val REQUEST_CODE_RANGE = 300 until 400
        const val TAG = "REGISTER_USER_WITH_BIOMETRICS"
        const val REGISTER_BIOMETRICS_REQUEST_CODE = 300
    }

    fun startRegisterUserWithBiometricsIntent(call: MethodCall){
        val reliantAppGuid = call.argument<String>(Key.RELIANT_APP_GUID)!!
        val programGuid = call.argument<String>(Key.PROGRAM_GUID)!!
        val consentId = call.argument<String>(Key.CONSENT_ID)!!

        val intent = Intent(activity, RegisterUserForBioTokenCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.RELIANT_APP_GUID, reliantAppGuid)
            putExtra(Key.PROGRAM_GUID, programGuid)
            putExtra(Key.CONSENT_ID, consentId)
        }

        activity.startActivityForResult(intent, REGISTER_BIOMETRICS_REQUEST_CODE)
    }

    fun handleRegisterUserWithBiometricsIntentResponse(
        resultCode: Int,
        data: Intent?,
        result: MethodChannel.Result,
        helperObject: CompassKernelUIController.CompassHelper
    ) {

        when (resultCode) {
            Activity.RESULT_OK -> {
                val jwt = data?.extras?.getString(Key.DATA).toString()
                val response: RegisterUserForBioTokenResponse = helperObject.parseBioTokenJWT(jwt)

                result.success(
                    hashMapOf(
                        ResponseKeys.RID to response.rId,
                        ResponseKeys.ENROLMENT_STATUS to response.enrolmentStatus.toString(),
                        ResponseKeys.BIO_TOKEN to response.bioToken,
                        ResponseKeys.PROGRAM_GUID to response.programGUID
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