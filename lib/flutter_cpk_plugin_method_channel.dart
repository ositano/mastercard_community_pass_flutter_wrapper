import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cpk_plugin/compassapi.dart';

import 'flutter_cpk_plugin_platform_interface.dart';

/// An implementation of [FlutterCpkPluginPlatform] that uses method channels.
class PigeonFlutterCpkPlugin extends FlutterCpkPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_cpk_plugin');
  final CommunityPassApi _api = CommunityPassApi();

  @override
  Future<SaveBiometricConsentResult> saveBiometricConsent(
      String reliantAppGUID, String programGUID) async {
    return _api.saveBiometricConsent(reliantAppGUID, programGUID);
  }

  @override
  Future<RegisterUserWithBiometricsResult> getRegisterUserWithBiometrics(
      String reliantAppGUID, String programGUID, String consentId) async {
    return _api.getRegisterUserWithBiometrics(
        reliantAppGUID, programGUID, consentId);
  }

  @override
  Future<RegisterBasicUserResult> getRegisterBasicUser(
      String reliantAppGUID, String programGUID) async {
    return _api.getRegisterBasicUser(reliantAppGUID, programGUID);
  }

  @override
  Future<WriteProfileResult> getWriteProfile(String reliantAppGUID,
      String programGUID, String rId, bool overwriteCard) async {
    return _api.getWriteProfile(
        reliantAppGUID, programGUID, rId, overwriteCard);
  }

  @override
  Future<WritePasscodeResult> getWritePasscode(String reliantAppGUID,
      String programGUID, String rId, String passcode) async {
    return _api.getWritePasscode(reliantAppGUID, programGUID, rId, passcode);
  }
}
