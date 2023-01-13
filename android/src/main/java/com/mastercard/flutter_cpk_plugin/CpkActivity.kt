package com.mastercard.flutter_cpk_plugin

import android.app.Activity
import android.os.Bundle
import android.util.Log
import android.view.View
import com.mastercard.flutter_cpk_plugin.databinding.ActivityCpkBinding
import android.view.WindowManager
import androidx.core.content.ContextCompat

class CpkActivity : CompassKernelUIController.CompassKernelActivity() {
    private lateinit var binding: ActivityCpkBinding

    companion object {
        private const val TAG = "CpkActivity"
        private const val RELIANT_APP_GUID = "" // Add the reliant APP GUID here.
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
        window.statusBarColor = ContextCompat.getColor(this, android.R.color.black)

        binding = ActivityCpkBinding.inflate(layoutInflater)
        setContentView(binding.root)

        connectKernelService()
    }

    private fun connectKernelService(overrideValidation: Boolean = false) {
        if (!overrideValidation && hasActiveKernelConnection) {
            binding.textViewKernelConnectionStatus.visibility = View.GONE
            return
        }

        connectKernelService(RELIANT_APP_GUID) { isSuccess, errorCode, errorMessage ->
            when (isSuccess) {
                true -> {
                    Log.d(TAG, "Connected to Kernel successfully")

                    intent.putExtra("success", true)
                    setResult(Activity.RESULT_OK, intent)
                    finish()
                }
                false -> {
                    Log.e(
                        TAG,
                        "Could not connect to Kernel. Code: $errorCode. Message: $errorMessage"
                    )

                    intent.putExtra("success", false)
                    intent.putExtra("errorCode", errorCode)
                    intent.putExtra("errorMessage", errorMessage)
                    setResult(Activity.RESULT_CANCELED, intent)
                    finish()
                }
            }
        }
    }
}