import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.os.Parcelable
import android.util.Log
import androidx.lifecycle.lifecycleScope
import com.mastercard.flutter_cpk_plugin.CompassKernelUIController
import com.mastercard.flutter_cpk_plugin.R
import com.mastercard.flutter_cpk_plugin.ui.util.CompassIntentResponse
import com.mastercard.flutter_cpk_plugin.ui.util.CompassResultContract
import com.mastercard.flutter_cpk_plugin.util.ErrorCode.UNKNOWN
import com.mastercard.flutter_cpk_plugin.util.Key.DATA
import com.mastercard.flutter_cpk_plugin.util.Key.ERROR_CODE
import com.mastercard.flutter_cpk_plugin.util.Key.ERROR_MESSAGE
import com.mastercard.flutter_cpk_plugin.util.Key.RELIANT_APP_GUID

abstract class CompassApiHandlerActivity<T> : CompassKernelUIController.CompassKernelActivity() {

    companion object {
        protected const val TAG = "CompassApiIntentHandlerActivity"
    }

    protected val compassApiActivityResult = registerForActivityResult(CompassResultContract<T>()){
        when(it){
            is CompassIntentResponse.Success -> successFinishActivity(it.data)
            is CompassIntentResponse.Error -> errorFoundFinishActivity(it.code, it.message)
        }
    }

    lateinit var reliantAppGuid: String

    abstract suspend fun callCompassApi()

    private fun successFinishActivity(data: T){
        val intent = Intent().apply {
            when (data) {
                is String -> putExtra(DATA, data)
               is Parcelable -> putExtra(DATA, data)
            }
        }
        setResult(Activity.RESULT_OK, intent)
        finish()
    }

    private fun errorFoundFinishActivity(errorCode: Int?, errorMessage: String?) {
        val intent = Intent().apply {
            putExtra(ERROR_CODE, errorCode ?: UNKNOWN)
            putExtra(ERROR_MESSAGE, errorMessage ?: getString(R.string.error_unknown))
        }
        setResult(RESULT_CANCELED, intent)
        finish()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setTheme(R.style.Theme_Transparent)

        reliantAppGuid = intent.getStringExtra(RELIANT_APP_GUID)!!
        connectKernelService()
    }

    private fun connectKernelService() {
        connectKernelService(reliantAppGuid) { isSuccess, errorCode, errorMessage ->
            when (isSuccess) {
                true -> {
                    Log.d(TAG, "Connected to Kernel successfully")
                    startCompassCoroutine()
                }
                false -> {
                    Log.e(
                        TAG,
                        "Could not connect to Kernel. Code: $errorCode. Message: $errorMessage"
                    )
                    errorFoundFinishActivity(errorCode, errorMessage)
                }
            }
        }
    }

    private fun startCompassCoroutine() = lifecycleScope.launchWhenCreated {
        callCompassApi()
    }

}