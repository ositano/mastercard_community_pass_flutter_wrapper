package com.mastercard.flutter_cpk_plugin.route

import android.app.Activity
import android.content.Intent
import com.mastercard.flutter_cpk_plugin.compassapi.CompassApiFlutter
import com.mastercard.flutter_cpk_plugin.compassapi.CompassApiFlutter.WritePasscodeResult
import com.mastercard.flutter_cpk_plugin.ui.WritePasscodeCompassApiHandlerActivity
import com.mastercard.flutter_cpk_plugin.util.ErrorCode
import com.mastercard.flutter_cpk_plugin.util.Key

class ConsumerDevicePasscodeAPIRoute(private val activity: Activity) {
    private lateinit var consumerDevicePasscodeResult: CompassApiFlutter.Result<WritePasscodeResult>

    companion object {
        val REQUEST_CODE_RANGE = 500 until 600

        const val WRITE_PASSCODE_REQUEST_CODE = 500
    }

    fun startWritePasscodeIntent(reliantAppGUID: String, programGUID: String, rId: String, passcode: String, result: CompassApiFlutter.Result<WritePasscodeResult>?){
        val intent = Intent(activity, WritePasscodeCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.RELIANT_APP_GUID, reliantAppGUID)
            putExtra(Key.PROGRAM_GUID, programGUID)
            putExtra(Key.RID, rId)
            putExtra(Key.PASSCODE, passcode)
        }

        consumerDevicePasscodeResult = result!!
        activity.startActivityForResult(intent, WRITE_PASSCODE_REQUEST_CODE)
    }

    fun handleWritePasscodeIntentResponse(
        resultCode: Int,
        data: Intent?,
    ) {
        when (resultCode) {
            Activity.RESULT_OK -> {
                val result = WritePasscodeResult.Builder()
                    .setResponseStatus(CompassApiFlutter.ResponseStatus.SUCCESS)
                    .build()
                consumerDevicePasscodeResult.success(result)
            }
            Activity.RESULT_CANCELED -> {
                val code = data?.getIntExtra(Key.ERROR_CODE, ErrorCode.UNKNOWN).toString()
                val message = data?.getStringExtra(Key.ERROR_MESSAGE)!!
                consumerDevicePasscodeResult.error(Throwable(message))
            }
        }
    }
}