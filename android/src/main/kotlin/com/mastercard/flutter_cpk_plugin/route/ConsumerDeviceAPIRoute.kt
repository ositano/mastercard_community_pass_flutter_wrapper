package com.mastercard.flutter_cpk_plugin.route

import android.app.Activity
import android.content.Intent
import com.mastercard.compass.base.Constants
import com.mastercard.compass.jwt.RegisterUserForBioTokenResponse
import com.mastercard.flutter_cpk_plugin.CompassKernelUIController
import com.mastercard.flutter_cpk_plugin.compassapi.CompassApiFlutter
import com.mastercard.flutter_cpk_plugin.compassapi.CompassApiFlutter.WriteProfileResult
import com.mastercard.flutter_cpk_plugin.ui.WriteProfileCompassApiHandlerActivity
import com.mastercard.flutter_cpk_plugin.util.ErrorCode
import com.mastercard.flutter_cpk_plugin.util.Key
import com.mastercard.flutter_cpk_plugin.util.ResponseKeys
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class ConsumerDeviceAPIRoute( private val activity: Activity ) {
    private lateinit var consumerDeviceResult: CompassApiFlutter.Result<WriteProfileResult>

    companion object {
        val REQUEST_CODE_RANGE = 200 until 300

        const val WRITE_PROFILE_REQUEST_CODE = 200
    }

    fun startWriteProfileIntent(reliantAppGUID: String, programGUID: String, rId: String, overwriteCard: Boolean, result: CompassApiFlutter.Result<WriteProfileResult>?){
        val intent = Intent(activity, WriteProfileCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.RELIANT_APP_GUID, reliantAppGUID)
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
                val code = data?.getIntExtra(Key.ERROR_CODE, ErrorCode.UNKNOWN).toString()
                val message = data?.getStringExtra(Key.ERROR_MESSAGE)!!
                consumerDeviceResult.error(Throwable(message))
            }
        }
    }
}