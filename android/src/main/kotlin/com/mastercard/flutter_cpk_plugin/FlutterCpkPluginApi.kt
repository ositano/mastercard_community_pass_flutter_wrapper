package com.mastercard.flutter_cpk_plugin

fun getCpkConnectionStatus(appGuid: String): String {
    return "Reliant App GUID $appGuid";
}

fun getPlatformVersion(): String{
    return "Android ${android.os.Build.VERSION.RELEASE}"
}