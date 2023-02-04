import 'package:flutter_cpk_plugin/compassapi.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_cpk_plugin_method_channel.dart';

abstract class FlutterCpkPluginPlatform extends PlatformInterface {
  /// Constructs a FlutterCpkPluginPlatform.
  FlutterCpkPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterCpkPluginPlatform _instance = PigeonFlutterCpkPlugin();

  /// The default instance of [FlutterCpkPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterCpkPlugin].
  static FlutterCpkPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterCpkPluginPlatform] when
  /// they register themselves.
  static set instance(FlutterCpkPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<SaveBiometricConsentResult> saveBiometricConsent(
      String reliantAppGUID, String programGUID) async {
    throw UnimplementedError(
        'saveBiometricConsent() has not been implemented.');
  }

  Future<RegisterUserWithBiometricsResult> getRegisterUserWithBiometrics(
      String reliantAppGUID, String programGUID, String consentId) async {
    throw UnimplementedError(
        'getRegisterUserWithBiometrics() has not been implemented.');
  }

  Future<RegisterBasicUserResult> getRegisterBasicUser(
      String reliantAppGUID, String programGUID) async {
    throw UnimplementedError(
        'getRegisterBasicUser() has not been implemented.');
  }

  Future<WriteProfileResult> getWriteProfile(String reliantAppGUID,
      String programGUID, String rId, bool overwriteCard) async {
    throw UnimplementedError('getWriteProfile() has not been implemented.');
  }

  Future<WritePasscodeResult> getWritePasscode(String reliantAppGUID,
      String programGUID, String rId, String passcode) async {
    throw UnimplementedError('getWritePasscode() has not been implemented.');
  }
}
