import 'package:compass_library_wrapper_plugin/compassapi.dart';

import 'compass_library_wrapper_plugin_platform_interface.dart';

class CompassLibraryWrapperPlugin {
  Future<SaveBiometricConsentResult> saveBiometricConsent(
      String reliantAppGUID, String programGUID) {
    return CompassLibraryWrapperPluginPlatform.instance
        .saveBiometricConsent(reliantAppGUID, programGUID);
  }

  Future<RegisterUserWithBiometricsResult> getRegisterUserWithBiometrics(
      String reliantAppGUID, String programGUID, String consentId) {
    return CompassLibraryWrapperPluginPlatform.instance
        .getRegisterUserWithBiometrics(reliantAppGUID, programGUID, consentId);
  }

  Future<RegisterBasicUserResult> getRegisterBasicUser(
      String reliantAppGUID, String programGUID) {
    return CompassLibraryWrapperPluginPlatform.instance
        .getRegisterBasicUser(reliantAppGUID, programGUID);
  }

  Future<WriteProfileResult> getWriteProfile(String reliantAppGUID,
      String programGUID, String rId, bool overwriteCard) {
    return CompassLibraryWrapperPluginPlatform.instance
        .getWriteProfile(reliantAppGUID, programGUID, rId, overwriteCard);
  }

  Future<WritePasscodeResult> getWritePasscode(
      String reliantAppGUID, String programGUID, String rId, String passcode) {
    return CompassLibraryWrapperPluginPlatform.instance
        .getWritePasscode(reliantAppGUID, programGUID, rId, passcode);
  }
}
