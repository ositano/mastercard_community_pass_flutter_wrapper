package com.mastercard.flutter_cpk_plugin.route

import android.app.Activity
import android.content.Intent
import com.mastercard.flutter_cpk_plugin.compassapi.CompassApiFlutter
import com.mastercard.flutter_cpk_plugin.compassapi.CompassApiFlutter.RegisterBasicUserResult
import com.mastercard.flutter_cpk_plugin.ui.RegisterBasicUserCompassApiHandlerActivity
import com.mastercard.flutter_cpk_plugin.util.ErrorCode
import com.mastercard.flutter_cpk_plugin.util.Key

class RegisterBasicUserAPIRoute(private val activity: Activity) {
    private lateinit var resultTwo: CompassApiFlutter.Result<RegisterBasicUserResult>
    companion object {
        val REQUEST_CODE_RANGE = 400 until 500

        const val REGISTER_BASIC_USER_REQUEST_CODE = 400
    }

    fun startRegisterBasicUserIntent(reliantAppGUID: String, programGUID: String, result: CompassApiFlutter.Result<RegisterBasicUserResult>?){

        val intent = Intent(activity, RegisterBasicUserCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.RELIANT_APP_GUID, reliantAppGUID)
            putExtra(Key.PROGRAM_GUID, programGUID)
        }

        resultTwo = result!!
        activity.startActivityForResult(intent, REGISTER_BASIC_USER_REQUEST_CODE)
    }

    fun handleRegisterBasicUserIntentResponse(
        resultCode: Int,
        data: Intent?,
    ) {
        when (resultCode) {
            Activity.RESULT_OK -> {
                val res = RegisterBasicUserResult.Builder()
                    .setRId(data?.extras?.get(Key.DATA).toString()).build()
                resultTwo.success(res)
            }
            Activity.RESULT_CANCELED -> {
                val code = data?.getIntExtra(Key.ERROR_CODE, ErrorCode.UNKNOWN).toString()
                val message = data?.getStringExtra(Key.ERROR_MESSAGE)!!
                resultTwo.error(Throwable(message))
            }
        }
    }
}