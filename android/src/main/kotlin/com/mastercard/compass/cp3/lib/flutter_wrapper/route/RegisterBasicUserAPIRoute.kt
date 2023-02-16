package com.mastercard.compass.cp3.lib.flutter_wrapper.route

import android.app.Activity
import android.content.Intent
import com.mastercard.compass.cp3.java_flutter_wrapper.CompassApiFlutter
import com.mastercard.compass.cp3.java_flutter_wrapper.CompassApiFlutter.RegisterBasicUserResult
import com.mastercard.compass.cp3.lib.flutter_wrapper.ui.RegisterBasicUserCompassApiHandlerActivity
import com.mastercard.compass.cp3.lib.flutter_wrapper.util.ErrorCode
import com.mastercard.compass.cp3.lib.flutter_wrapper.util.Key

class RegisterBasicUserAPIRoute(private val activity: Activity) {
    private lateinit var registerBasicUserApiRouteResult: CompassApiFlutter.Result<RegisterBasicUserResult>
    companion object {
        val REQUEST_CODE_RANGE = 400 until 500

        const val REGISTER_BASIC_USER_REQUEST_CODE = 400
    }

    fun startRegisterBasicUserIntent(reliantGUID: String, programGUID: String, result: CompassApiFlutter.Result<RegisterBasicUserResult>?){

        val intent = Intent(activity, RegisterBasicUserCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.RELIANT_APP_GUID, reliantGUID)
            putExtra(Key.PROGRAM_GUID, programGUID)
        }

        registerBasicUserApiRouteResult = result!!
        activity.startActivityForResult(intent, REGISTER_BASIC_USER_REQUEST_CODE)
    }

    fun handleRegisterBasicUserIntentResponse(
        resultCode: Int,
        data: Intent?,
    ) {
        when (resultCode) {
            Activity.RESULT_OK -> {
                val result = RegisterBasicUserResult.Builder()
                    .setRID(data?.extras?.get(Key.DATA).toString()).build()
                registerBasicUserApiRouteResult.success(result)
            }
            Activity.RESULT_CANCELED -> {
                val code = data?.getIntExtra(Key.ERROR_CODE, ErrorCode.UNKNOWN)
                val message = data?.getStringExtra(Key.ERROR_MESSAGE)!!
                registerBasicUserApiRouteResult.error(CompassThrowable(code, message))
            }
        }
    }
}