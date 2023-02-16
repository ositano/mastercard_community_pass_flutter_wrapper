package com.mastercard.compass.cp3.lib.flutter_wrapper.route

import android.app.Activity
import android.content.Intent
import com.mastercard.compass.cp3.java_flutter_wrapper.CompassApiFlutter
import com.mastercard.compass.jwt.RegisterUserForBioTokenResponse
import com.mastercard.compass.cp3.lib.flutter_wrapper.CompassKernelUIController
import com.mastercard.compass.cp3.java_flutter_wrapper.CompassApiFlutter.EnrolmentStatus
import com.mastercard.compass.cp3.java_flutter_wrapper.CompassApiFlutter.RegisterUserWithBiometricsResult
import com.mastercard.compass.cp3.lib.flutter_wrapper.ui.RegisterUserForBioTokenCompassApiHandlerActivity
import com.mastercard.compass.cp3.lib.flutter_wrapper.util.ErrorCode
import com.mastercard.compass.cp3.lib.flutter_wrapper.util.Key

class RegisterUserWithBiometricsAPIRoute(private val activity: Activity) {
    private lateinit var registerBiometricUserApiRouteResult: CompassApiFlutter.Result<RegisterUserWithBiometricsResult>
    companion object {
        val REQUEST_CODE_RANGE = 300 until 400
        const val TAG = "REGISTER_USER_WITH_BIOMETRICS"
        const val REGISTER_BIOMETRICS_REQUEST_CODE = 300
    }

    fun startRegisterUserWithBiometricsIntent(reliantGUID: String, programGUID: String, consentId: String, result: CompassApiFlutter.Result<RegisterUserWithBiometricsResult>?){
        val intent = Intent(activity, RegisterUserForBioTokenCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.RELIANT_APP_GUID, reliantGUID)
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
                    .setRID (response.rId)
                    .build()

                registerBiometricUserApiRouteResult.success(result)
            }
            Activity.RESULT_CANCELED -> {
                val code = data?.getIntExtra(Key.ERROR_CODE, ErrorCode.UNKNOWN)
                val message = data?.getStringExtra(Key.ERROR_MESSAGE) ?: "Unknown error"
                registerBiometricUserApiRouteResult.error(CompassThrowable(code, message))
            }
        }
    }
}

class CompassThrowable(private val code: Int?, message: String): Throwable(message){
    override fun toString(): String = code.toString()
}

private fun parseEnrolmentStatus (param: String): EnrolmentStatus{
    return if(param.isNotEmpty()){
        EnrolmentStatus.EXISTING
    } else {
        EnrolmentStatus.NEW
    }
}