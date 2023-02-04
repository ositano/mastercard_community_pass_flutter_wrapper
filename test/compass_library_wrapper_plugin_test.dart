import 'package:compass_library_wrapper_plugin/compassapi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:compass_library_wrapper_plugin/compass_library_wrapper_plugin.dart';
import 'package:compass_library_wrapper_plugin/compass_library_wrapper_plugin_platform_interface.dart';
import 'package:compass_library_wrapper_plugin/compass_library_wrapper_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCompassLibraryWrapperPluginPlatform
    with MockPlatformInterfaceMixin
    implements CompassLibraryWrapperPluginPlatform {
  @override
  Future<SaveBiometricConsentResult> saveBiometricConsent(
          String reliantApplicationGuid, String programGuid) =>
      Future.value(SaveBiometricConsentResult(
          consentId: '', responseStatus: ResponseStatus.SUCCESS));

  @override
  Future<RegisterUserWithBiometricsResult> getRegisterUserWithBiometrics(
          String reliantApplicationGuid,
          String programGuid,
          String consentId) =>
      Future.value(RegisterUserWithBiometricsResult(
          bioToken: '',
          enrolmentStatus: EnrolmentStatus.EXISTING,
          programGUID: '',
          rId: ''));

  @override
  Future<RegisterBasicUserResult> getRegisterBasicUser(
          String reliantApplicationGuid, String programGuid) =>
      Future.value(RegisterBasicUserResult(rId: ''));

  @override
  Future<WriteProfileResult> getWriteProfile(String reliantApplicationGuid,
          String programGuid, String rId, bool overwriteCard) =>
      Future.value(WriteProfileResult(consumerDeviceNumber: ''));

  @override
  Future<WritePasscodeResult> getWritePasscode(String reliantApplicationGuid,
          String programGuid, String rId, String passcode) =>
      Future.value(WritePasscodeResult(responseStatus: ResponseStatus.SUCCESS));
}

void main() {
  final CompassLibraryWrapperPluginPlatform initialPlatform =
      CompassLibraryWrapperPluginPlatform.instance;

  test('$PigeonCompassLibraryWrapperPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<PigeonCompassLibraryWrapperPlugin>());
  });

  test('saveBiometricConsent', () async {
    CompassLibraryWrapperPlugin compassLibraryWrapperPluginInstance =
        CompassLibraryWrapperPlugin();
    MockCompassLibraryWrapperPluginPlatform fakePlatform =
        MockCompassLibraryWrapperPluginPlatform();
    CompassLibraryWrapperPluginPlatform.instance = fakePlatform;

    expect(
        await compassLibraryWrapperPluginInstance.saveBiometricConsent('', ''),
        SaveBiometricConsentResult(
            consentId: '', responseStatus: ResponseStatus.SUCCESS));
  });

  test('getRegisterUserWithBiometrics', () async {
    CompassLibraryWrapperPlugin compassLibraryWrapperPluginInstance =
        CompassLibraryWrapperPlugin();
    MockCompassLibraryWrapperPluginPlatform fakePlatform =
        MockCompassLibraryWrapperPluginPlatform();
    CompassLibraryWrapperPluginPlatform.instance = fakePlatform;

    expect(
        await compassLibraryWrapperPluginInstance.getRegisterUserWithBiometrics(
            '', '', ''),
        RegisterUserWithBiometricsResult(
            bioToken: '',
            programGUID: '',
            rId: '',
            enrolmentStatus: EnrolmentStatus.EXISTING));
  });

  test('getRegisterBasicUser', () async {
    CompassLibraryWrapperPlugin compassLibraryWrapperPluginInstance =
        CompassLibraryWrapperPlugin();
    MockCompassLibraryWrapperPluginPlatform fakePlatform =
        MockCompassLibraryWrapperPluginPlatform();
    CompassLibraryWrapperPluginPlatform.instance = fakePlatform;

    expect(
        await compassLibraryWrapperPluginInstance.getRegisterBasicUser('', ''),
        RegisterBasicUserResult(rId: ''));
  });

  test('getWriteProfile', () async {
    CompassLibraryWrapperPlugin compassLibraryWrapperPluginInstance =
        CompassLibraryWrapperPlugin();
    MockCompassLibraryWrapperPluginPlatform fakePlatform =
        MockCompassLibraryWrapperPluginPlatform();
    CompassLibraryWrapperPluginPlatform.instance = fakePlatform;

    expect(
        await compassLibraryWrapperPluginInstance.getWriteProfile(
            '', '', '', false),
        WriteProfileResult(consumerDeviceNumber: ''));
  });

  test('getWritePasscode', () async {
    CompassLibraryWrapperPlugin compassLibraryWrapperPluginInstance =
        CompassLibraryWrapperPlugin();
    MockCompassLibraryWrapperPluginPlatform fakePlatform =
        MockCompassLibraryWrapperPluginPlatform();
    CompassLibraryWrapperPluginPlatform.instance = fakePlatform;

    expect(
        await compassLibraryWrapperPluginInstance.getWritePasscode(
            '', '', '', ''),
        WritePasscodeResult(responseStatus: ResponseStatus.SUCCESS));
  });
}
