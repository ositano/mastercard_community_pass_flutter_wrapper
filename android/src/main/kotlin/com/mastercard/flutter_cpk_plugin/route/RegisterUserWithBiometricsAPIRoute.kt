package com.mastercard.flutter_cpk_plugin.route

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import com.mastercard.compass.base.Constants
import com.mastercard.compass.jwt.JWTResponseParser
import com.mastercard.compass.jwt.RegisterUserForBioTokenResponse
import com.mastercard.flutter_cpk_plugin.CompassKernelUIController
import com.mastercard.flutter_cpk_plugin.compassapi.CompassApiFlutter
import com.mastercard.flutter_cpk_plugin.compassapi.CompassApiFlutter.EnrolmentStatus
import com.mastercard.flutter_cpk_plugin.compassapi.CompassApiFlutter.RegisterUserWithBiometricsResult
import com.mastercard.flutter_cpk_plugin.ui.RegisterUserForBioTokenCompassApiHandlerActivity
import com.mastercard.flutter_cpk_plugin.util.ErrorCode
import com.mastercard.flutter_cpk_plugin.util.Key
import com.mastercard.flutter_cpk_plugin.util.ResponseKeys
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.security.PublicKey

class RegisterUserWithBiometricsAPIRoute(private val activity: Activity) {
    private lateinit var registerBiometricUserApiRouteResult: CompassApiFlutter.Result<RegisterUserWithBiometricsResult>
    companion object {
        val REQUEST_CODE_RANGE = 300 until 400
        const val TAG = "REGISTER_USER_WITH_BIOMETRICS"
        const val REGISTER_BIOMETRICS_REQUEST_CODE = 300
    }

    fun startRegisterUserWithBiometricsIntent(reliantAppGUID: String, programGUID: String, consentId: String, result: CompassApiFlutter.Result<RegisterUserWithBiometricsResult>?){
        val intent = Intent(activity, RegisterUserForBioTokenCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.RELIANT_APP_GUID, reliantAppGUID)
            putExtra(Key.PROGRAM_GUID, programGUID)
            putExtra(Key.CONSENT_ID, consentId)
        }
        registerBiometricUserApiRouteResult = result!!
        activity.startActivityForResult(intent, REGISTER_BIOMETRICS_REQUEST_CODE)
    }

    fun handleRegisterUserWithBiometricsIntentResponse(
        resultCode: Int,
        data: Intent?,
        helperObject: CompassKernelUIController.CompassHelper
    ) {

        when (resultCode) {
            Activity.RESULT_OK -> {
                val jwt = data?.extras?.getString(Key.DATA).toString()
                val response: RegisterUserForBioTokenResponse = helperObject.parseBioTokenJWT(jwt)

                val result = RegisterUserWithBiometricsResult.Builder()
                    .setBioToken(response.bioToken)
                    .setEnrolmentStatus(parseEnrolmentStatus(response.bioToken))
                    .setProgramGUID(response.programGUID)
                    .setRId(response.rId)
                    .build()

                registerBiometricUserApiRouteResult.success(result)
            }
            Activity.RESULT_CANCELED -> {
                val code = data?.getIntExtra(Key.ERROR_CODE, ErrorCode.UNKNOWN).toString()
                val message = data?.getStringExtra(Key.ERROR_MESSAGE) ?: "Unknown error"
                registerBiometricUserApiRouteResult.error(Throwable(message))
            }
        }
    }
}


fun parseEnrolmentStatus (param: String): EnrolmentStatus{
    return if(param.isNotEmpty()){
        EnrolmentStatus.EXISTING
    } else {
        EnrolmentStatus.NEW
    }
}