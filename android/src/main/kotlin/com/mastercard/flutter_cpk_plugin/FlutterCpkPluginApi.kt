package com.mastercard.flutter_cpk_plugin

// Add plugin API's here

fun getPlatformVersion(): String{
    return "Android ${android.os.Build.VERSION.RELEASE}"
}