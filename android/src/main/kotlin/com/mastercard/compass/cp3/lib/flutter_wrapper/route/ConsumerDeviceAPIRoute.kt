package com.mastercard.compass.cp3.lib.flutter_wrapper.route

import android.app.Activity
import android.content.Intent
import com.mastercard.compass.cp3.java_flutter_wrapper.CompassApiFlutter
import com.mastercard.compass.cp3.java_flutter_wrapper.CompassApiFlutter.WriteProfileResult
import com.mastercard.compass.cp3.lib.flutter_wrapper.ui.WriteProfileCompassApiHandlerActivity
import com.mastercard.compass.cp3.lib.flutter_wrapper.util.ErrorCode
import com.mastercard.compass.cp3.lib.flutter_wrapper.util.Key

class ConsumerDeviceAPIRoute( private val activity: Activity ) {
    private lateinit var consumerDeviceResult: CompassApiFlutter.Result<WriteProfileResult>

    companion object {
        val REQUEST_CODE_RANGE = 200 until 300

        const val WRITE_PROFILE_REQUEST_CODE = 200
    }

    fun startWriteProfileIntent(reliantGUID: String, programGUID: String, rId: String, overwriteCard: Boolean, result: CompassApiFlutter.Result<WriteProfileResult>?){
        val intent = Intent(activity, WriteProfileCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.RELIANT_APP_GUID, reliantGUID)
            putExtra(Key.PROGRAM_GUID, programGUID)
            putExtra(Key.RID, rId)
            putExtra(Key.OVERWRITE_CARD, overwriteCard)
        }

        consumerDeviceResult = result!!;
        activity.startActivityForResult(intent, WRITE_PROFILE_REQUEST_CODE)
    }

    fun handleWriteProfileIntentResponse(
        resultCode: Int,
        data: Intent?,
    ) {
        when (resultCode) {
            Activity.RESULT_OK -> {
                val result = WriteProfileResult.Builder()
                    .setConsumerDeviceNumber(data?.extras?.get(Key.DATA).toString())
                    .build()
                consumerDeviceResult.success(result)
            }
            Activity.RESULT_CANCELED -> {
                val code = data?.getIntExtra(Key.ERROR_CODE, ErrorCode.UNKNOWN)
                val message = data?.getStringExtra(Key.ERROR_MESSAGE)!!
                consumerDeviceResult.error(CompassThrowable(code, message))
            }
        }
    }
}