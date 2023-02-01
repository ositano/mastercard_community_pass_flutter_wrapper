package com.mastercard.flutter_cpk_plugin.route

import android.app.Activity
import android.content.Intent
import com.mastercard.flutter_cpk_plugin.ui.WritePasscodeCompassApiHandlerActivity
import com.mastercard.flutter_cpk_plugin.util.ErrorCode
import com.mastercard.flutter_cpk_plugin.util.Key
import com.mastercard.flutter_cpk_plugin.util.ResponseKeys
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class ConsumerDevicePasscodeAPIRoute(private val activity: Activity) {
    companion object {
        val REQUEST_CODE_RANGE = 500 until 600

        const val WRITE_PASSCODE_REQUEST_CODE = 500
    }

    fun startWritePasscodeIntent(call: MethodCall){
        val reliantAppGuid = call.argument<String>(Key.RELIANT_APP_GUID)!!
        val programGuid = call.argument<String>(Key.PROGRAM_GUID)!!
        val rId = call.argument<String>(Key.RID)!!
        val passcode = call.argument<String>(Key.PASSCODE)!!

        val intent = Intent(activity, WritePasscodeCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.RELIANT_APP_GUID, reliantAppGuid)
            putExtra(Key.PROGRAM_GUID, programGuid)
            putExtra(Key.RID, rId)
            putExtra(Key.PASSCODE, passcode)
        }

        activity.startActivityForResult(intent, WRITE_PASSCODE_REQUEST_CODE)
    }

    fun handleWritePasscodeIntentResponse(
        resultCode: Int,
        data: Intent?,
        result: MethodChannel.Result
    ) {
        when (resultCode) {
            Activity.RESULT_OK -> result.success(
                    hashMapOf(ResponseKeys.RESPONSE_STATUS to data?.extras?.get(Key.DATA)
                ))
            Activity.RESULT_CANCELED -> {
                val code = data?.getIntExtra(Key.ERROR_CODE, ErrorCode.UNKNOWN).toString()
                val message = data?.getStringExtra(Key.ERROR_MESSAGE)!!
                result.error(code, message, null)
            }
        }
    }
}