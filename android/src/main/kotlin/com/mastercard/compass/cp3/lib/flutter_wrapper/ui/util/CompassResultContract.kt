package com.mastercard.compass.cp3.lib.flutter_wrapper.ui.util

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.activity.result.contract.ActivityResultContract
import com.mastercard.compass.base.Constants

class CompassResultContract<T> : ActivityResultContract<Intent, CompassIntentResponse<T>>() {
    override fun createIntent(context: Context, input: Intent): Intent = input

    override fun parseResult(resultCode: Int, intent: Intent?): CompassIntentResponse<T> {
        return when(resultCode){
            Activity.RESULT_OK -> {
                val response = intent?.extras?.get(Constants.EXTRA_DATA)
                @Suppress("UNCHECKED_CAST")
                return CompassIntentResponse.Success(response as T)
            }
            else -> getErrorFromIntent(intent)
        }
    }

    private fun getErrorFromIntent(data: Intent?): CompassIntentResponse.Error {
        val code = data?.extras?.getInt(Constants.EXTRA_ERROR_CODE) ?: 0
        val message = data?.extras?.getString(Constants.EXTRA_ERROR_MESSAGE) ?: ""
        return CompassIntentResponse.Error(code, message)
    }

}

sealed class CompassIntentResponse<out T : Any?>{
    data class Success<T>(val data: T): CompassIntentResponse<T>()
    data class Error(val code: Int, val message: String): CompassIntentResponse<Nothing>()
}