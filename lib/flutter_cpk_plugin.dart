import 'package:flutter_cpk_plugin/compassapi.dart';

import 'flutter_cpk_plugin_platform_interface.dart';

class FlutterCpkPlugin {
  Future<SaveBiometricConsentResult> saveBiometricConsent(
      String reliantAppGUID, String programGUID) {
    return FlutterCpkPluginPlatform.instance
        .saveBiometricConsent(reliantAppGUID, programGUID);
  }

  Future<RegisterUserWithBiometricsResult> getRegisterUserWithBiometrics(
      String reliantAppGUID, String programGUID, String consentId) {
    return FlutterCpkPluginPlatform.instance
        .getRegisterUserWithBiometrics(reliantAppGUID, programGUID, consentId);
  }

  Future<RegisterBasicUserResult> getRegisterBasicUser(
      String reliantAppGUID, String programGUID) {
    return FlutterCpkPluginPlatform.instance
        .getRegisterBasicUser(reliantAppGUID, programGUID);
  }

  Future<WriteProfileResult> getWriteProfile(String reliantAppGUID,
      String programGUID, String rId, bool overwriteCard) {
    return FlutterCpkPluginPlatform.instance
        .getWriteProfile(reliantAppGUID, programGUID, rId, overwriteCard);
  }

  Future<WritePasscodeResult> getWritePasscode(
      String reliantAppGUID, String programGUID, String rId, String passcode) {
    return FlutterCpkPluginPlatform.instance
        .getWritePasscode(reliantAppGUID, programGUID, rId, passcode);
  }
}
