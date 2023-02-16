package com.mastercard.compass.cp3.lib.flutter_wrapper.route

import android.app.Activity
import android.content.Intent
import com.mastercard.compass.cp3.java_flutter_wrapper.CompassApiFlutter
import com.mastercard.compass.cp3.java_flutter_wrapper.CompassApiFlutter.WritePasscodeResult
import com.mastercard.compass.cp3.lib.flutter_wrapper.ui.WritePasscodeCompassApiHandlerActivity
import com.mastercard.compass.cp3.lib.flutter_wrapper.util.ErrorCode
import com.mastercard.compass.cp3.lib.flutter_wrapper.util.Key

class ConsumerDevicePasscodeAPIRoute(private val activity: Activity) {
    private lateinit var consumerDevicePasscodeResult: CompassApiFlutter.Result<WritePasscodeResult>

    companion object {
        val REQUEST_CODE_RANGE = 500 until 600

        const val WRITE_PASSCODE_REQUEST_CODE = 500
    }

    fun startWritePasscodeIntent(reliantGUID: String, programGUID: String, rId: String, passcode: String, result: CompassApiFlutter.Result<WritePasscodeResult>?){
        val intent = Intent(activity, WritePasscodeCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.RELIANT_APP_GUID, reliantGUID)
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
                val code = data?.getIntExtra(Key.ERROR_CODE, ErrorCode.UNKNOWN)
                val message = data?.getStringExtra(Key.ERROR_MESSAGE)!!
                consumerDevicePasscodeResult.error(CompassThrowable(code, message))
            }
        }
    }
}