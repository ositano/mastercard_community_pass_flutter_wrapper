package com.mastercard.compass.cp3.lib.flutter_wrapper

import android.app.Activity
import android.content.Context
import android.content.Intent
import com.mastercard.compass.cp3.java_flutter_wrapper.CompassApiFlutter
import com.mastercard.compass.cp3.java_flutter_wrapper.CompassApiFlutter.CommunityPassApi
import com.mastercard.compass.cp3.lib.flutter_wrapper.route.*
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class CompassLibraryWrapperPlugin: FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener, CommunityPassApi {
  private lateinit var context: Context
  private lateinit var activity: Activity

  private val consumerDeviceApiRoute: ConsumerDeviceAPIRoute by lazy {
    ConsumerDeviceAPIRoute(activity)
  }
  private val registerUserWithBiometricsAPIRoute: RegisterUserWithBiometricsAPIRoute by lazy {
    RegisterUserWithBiometricsAPIRoute(activity)
  }
  private val registerBasicUserAPIRoute: RegisterBasicUserAPIRoute by lazy {
    RegisterBasicUserAPIRoute(activity)
  }
  private val consumerDevicePasscodeAPIRoute: ConsumerDevicePasscodeAPIRoute by lazy {
    ConsumerDevicePasscodeAPIRoute(activity)
  }
  private val biometricConsentAPIRoute: BiometricConsentAPIRoute by lazy {
    BiometricConsentAPIRoute(activity)
  }

  private lateinit var helperObject: CompassKernelUIController.CompassHelper

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    CommunityPassApi.setup(binding.binaryMessenger, this)
    context = binding.applicationContext
    helperObject = CompassKernelUIController.CompassHelper(context);
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    CommunityPassApi.setup(binding.binaryMessenger, null)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    TODO("Not yet implemented")
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    when(requestCode){
      in BiometricConsentAPIRoute.REQUEST_CODE_RANGE -> handleApiRouteResponse(requestCode, resultCode, data)
      in ConsumerDeviceAPIRoute.REQUEST_CODE_RANGE -> handleApiRouteResponse(requestCode, resultCode, data)
      in ConsumerDevicePasscodeAPIRoute.REQUEST_CODE_RANGE -> handleApiRouteResponse(requestCode, resultCode, data)
      in RegisterUserWithBiometricsAPIRoute.REQUEST_CODE_RANGE -> handleApiRouteResponse(requestCode, resultCode, data)
      in RegisterBasicUserAPIRoute.REQUEST_CODE_RANGE -> handleApiRouteResponse(requestCode, resultCode, data)
    }
    return true;
  }

  override fun saveBiometricConsent(
    reliantGUID: String,
    programGUID: String,
    result: CompassApiFlutter.Result<CompassApiFlutter.SaveBiometricConsentResult>?
  ) {
    biometricConsentAPIRoute.startBiometricConsentIntent(reliantGUID, programGUID, result);
  }

  override fun getRegisterUserWithBiometrics(
    reliantGUID: String,
    programGUID: String,
    consentId: String,
    result: CompassApiFlutter.Result<CompassApiFlutter.RegisterUserWithBiometricsResult>?
  ) {
    registerUserWithBiometricsAPIRoute.startRegisterUserWithBiometricsIntent(reliantGUID, programGUID, consentId, result)
  }

  override fun getRegisterBasicUser(
    reliantGUID: String,
    programGUID: String,
    result: CompassApiFlutter.Result<CompassApiFlutter.RegisterBasicUserResult>?
  ) {
    registerBasicUserAPIRoute.startRegisterBasicUserIntent(reliantGUID, programGUID, result)
  }

  override fun getWritePasscode(
    reliantGUID: String,
    programGUID: String,
    rId: String,
    passcode: String,
    result: CompassApiFlutter.Result<CompassApiFlutter.WritePasscodeResult>?
  ) {
    consumerDevicePasscodeAPIRoute.startWritePasscodeIntent(reliantGUID, programGUID, rId, passcode, result)
  }

  override fun getWriteProfile(
    reliantGUID: String,
    programGUID: String,
    rId: String,
    overwriteCard: Boolean,
    result: CompassApiFlutter.Result<CompassApiFlutter.WriteProfileResult>?
  ) {
    consumerDeviceApiRoute.startWriteProfileIntent(reliantGUID, programGUID, rId, overwriteCard, result)
  }

  private fun handleApiRouteResponse(
    requestCode: Int,
    resultCode: Int,
    data: Intent?
  ) {
    when (requestCode) {
      BiometricConsentAPIRoute.BIOMETRIC_CONSENT_REQUEST_CODE -> biometricConsentAPIRoute.handleBiometricConsentIntentResponse(resultCode, data)
      ConsumerDeviceAPIRoute.WRITE_PROFILE_REQUEST_CODE -> consumerDeviceApiRoute.handleWriteProfileIntentResponse(resultCode, data)
      ConsumerDevicePasscodeAPIRoute.WRITE_PASSCODE_REQUEST_CODE -> consumerDevicePasscodeAPIRoute.handleWritePasscodeIntentResponse(resultCode, data)
      RegisterUserWithBiometricsAPIRoute.REGISTER_BIOMETRICS_REQUEST_CODE -> registerUserWithBiometricsAPIRoute.handleRegisterUserWithBiometricsIntentResponse(resultCode, data, helperObject)
      RegisterBasicUserAPIRoute.REGISTER_BASIC_USER_REQUEST_CODE -> registerBasicUserAPIRoute.handleRegisterBasicUserIntentResponse(resultCode, data,)
    }
  }
}
