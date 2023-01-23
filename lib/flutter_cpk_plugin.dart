import 'flutter_cpk_plugin_platform_interface.dart';

class FlutterCpkPlugin {
  Future<String> saveBiometricConsent(
      String reliantApplicationGuid, String programGuid) {
    return FlutterCpkPluginPlatform.instance
        .saveBiometricConsent(reliantApplicationGuid, programGuid);
  }

  Future<String> getRegisterUserWithBiometrics(
      String reliantApplicationGuid, String programGuid, String consentId) {
    return FlutterCpkPluginPlatform.instance.getRegisterUserWithBiometrics(
        reliantApplicationGuid, programGuid, consentId);
  }

  Future<String> getRegisterBasicUser(
      String reliantApplicationGuid, String programGuid) {
    return FlutterCpkPluginPlatform.instance
        .getRegisterBasicUser(reliantApplicationGuid, programGuid);
  }

  Future<String> getWriteProfile(String reliantApplicationGuid,
      String programGuid, String rId, bool overwriteCard) {
    return FlutterCpkPluginPlatform.instance.getWriteProfile(
        reliantApplicationGuid, programGuid, rId, overwriteCard);
  }

  Future<String> getWritePasscode(String reliantApplicationGuid,
      String programGuid, String rId, String passcode) {
    return FlutterCpkPluginPlatform.instance
        .getWritePasscode(reliantApplicationGuid, programGuid, rId, passcode);
  }
}
