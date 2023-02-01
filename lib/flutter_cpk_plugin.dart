import 'flutter_cpk_plugin_platform_interface.dart';

class FlutterCpkPlugin {
  Future<Map<String, String>> saveBiometricConsent(
      String reliantApplicationGuid, String programGuid) {
    return FlutterCpkPluginPlatform.instance
        .saveBiometricConsent(reliantApplicationGuid, programGuid);
  }

  Future<Map<String, String>> getRegisterUserWithBiometrics(
      String reliantApplicationGuid, String programGuid, String consentId) {
    return FlutterCpkPluginPlatform.instance.getRegisterUserWithBiometrics(
        reliantApplicationGuid, programGuid, consentId);
  }

  Future<Map<String, String>> getRegisterBasicUser(
      String reliantApplicationGuid, String programGuid) {
    return FlutterCpkPluginPlatform.instance
        .getRegisterBasicUser(reliantApplicationGuid, programGuid);
  }

  Future<Map<String, String>> getWriteProfile(String reliantApplicationGuid,
      String programGuid, String rId, bool overwriteCard) {
    return FlutterCpkPluginPlatform.instance.getWriteProfile(
        reliantApplicationGuid, programGuid, rId, overwriteCard);
  }

  Future<Map<String, String>> getWritePasscode(String reliantApplicationGuid,
      String programGuid, String rId, String passcode) {
    return FlutterCpkPluginPlatform.instance
        .getWritePasscode(reliantApplicationGuid, programGuid, rId, passcode);
  }
}
