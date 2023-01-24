package com.mastercard.flutter_cpk_plugin.route

import android.app.Activity
import android.content.Intent
import com.mastercard.compass.base.Constants
import com.mastercard.compass.jwt.RegisterUserForBioTokenResponse
import com.mastercard.flutter_cpk_plugin.CompassKernelUIController
import com.mastercard.flutter_cpk_plugin.ui.WriteProfileCompassApiHandlerActivity
import com.mastercard.flutter_cpk_plugin.util.ErrorCode
import com.mastercard.flutter_cpk_plugin.util.Key
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class ConsumerDeviceAPIRoute(
    private val activity: Activity,
    private val helperObject: CompassKernelUIController.CompassHelper
) {


    companion object {
        val REQUEST_CODE_RANGE = 200 until 300

        const val WRITE_PROFILE_REQUEST_CODE = 200
    }

    fun startWriteProfileIntent(call: MethodCall){
        val reliantAppGuid = call.argument<String>(Key.RELIANT_APP_GUID)!!
        val programGuid = call.argument<String>(Key.PROGRAM_GUID)!!
        val rId = call.argument<String>(Key.RID)!!
        val overwriteCard = call.argument<Boolean>(Key.OVERWRITE_CARD)!!

        val intent = Intent(activity, WriteProfileCompassApiHandlerActivity::class.java).apply {
            putExtra(Key.RELIANT_APP_GUID, reliantAppGuid)
            putExtra(Key.PROGRAM_GUID, programGuid)
            putExtra(Key.RID, rId)
            putExtra(Key.OVERWRITE_CARD, overwriteCard)
        }

        activity.startActivityForResult(intent, WRITE_PROFILE_REQUEST_CODE)
    }

    fun handleWriteProfileIntentResponse(
        resultCode: Int,
        data: Intent?,
        result: MethodChannel.Result
    ) {
        val jwt = data?.getStringExtra(Constants.EXTRA_DATA)!!
        val response: RegisterUserForBioTokenResponse = helperObject.parseBioTokenJWT(jwt)
        val rId =  response.rId;

        when (resultCode) {
            Activity.RESULT_OK -> result.success(rId)
            Activity.RESULT_CANCELED -> {
                val code = data.getIntExtra(Key.ERROR_CODE, ErrorCode.UNKNOWN).toString()
                val message = data.getStringExtra(Key.ERROR_MESSAGE)!!
                result.error(code, message, null)
            }
        }
    }
}