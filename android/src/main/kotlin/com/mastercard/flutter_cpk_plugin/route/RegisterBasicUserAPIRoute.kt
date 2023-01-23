package com.mastercard.flutter_cpk_plugin.route

import android.app.Activity
import android.content.Intent
import com.mastercard.flutter_cpk_plugin.ui.RegisterBasicUserCompassApiHandlerActivity
import com.mastercard.flutter_cpk_plugin.util.ErrorCode
import com.mastercard.flutter_cpk_plugin.util.Key
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class RegisterBasicUserAPIRoute(private val activity: Activity) {
    companion object {
        val REQUEST_CODE_RANGE = 400 until 500

        const val REGISTER_BASIC_USER_REQUEST_CODE = 400
    }

    fun startRegisterBasicUserIntent(call: MethodCall){
        val programGuid = call.argument<String>(Key.PROGRAM_GUID)!!
        val reliantAppGuid = call.argument<String>(Key.RELIANT_APP_GUID)!!

        val intent = Intent(activity, RegisterBasicUserCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.PROGRAM_GUID, programGuid)
            putExtra(Key.RELIANT_APP_GUID, reliantAppGuid)
        }

        activity.startActivityForResult(intent, REGISTER_BASIC_USER_REQUEST_CODE)
    }

    fun handleRegisterBasicUserIntentResponse(
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