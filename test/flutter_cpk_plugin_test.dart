import 'package:flutter_cpk_plugin/compassapi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cpk_plugin/flutter_cpk_plugin.dart';
import 'package:flutter_cpk_plugin/flutter_cpk_plugin_platform_interface.dart';
import 'package:flutter_cpk_plugin/flutter_cpk_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterCpkPluginPlatform
    with MockPlatformInterfaceMixin
    implements FlutterCpkPluginPlatform {
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
  final FlutterCpkPluginPlatform initialPlatform =
      FlutterCpkPluginPlatform.instance;

  test('$PigeonFlutterCpkPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<PigeonFlutterCpkPlugin>());
  });

  test('saveBiometricConsent', () async {
    FlutterCpkPlugin flutterCpkPlugin = FlutterCpkPlugin();
    MockFlutterCpkPluginPlatform fakePlatform = MockFlutterCpkPluginPlatform();
    FlutterCpkPluginPlatform.instance = fakePlatform;

    expect(
        await flutterCpkPlugin.saveBiometricConsent('', ''),
        SaveBiometricConsentResult(
            consentId: '', responseStatus: ResponseStatus.SUCCESS));
  });

  test('getRegisterUserWithBiometrics', () async {
    FlutterCpkPlugin flutterCpkPlugin = FlutterCpkPlugin();
    MockFlutterCpkPluginPlatform fakePlatform = MockFlutterCpkPluginPlatform();
    FlutterCpkPluginPlatform.instance = fakePlatform;

    expect(
        await flutterCpkPlugin.getRegisterUserWithBiometrics('', '', ''),
        RegisterUserWithBiometricsResult(
            bioToken: '',
            programGUID: '',
            rId: '',
            enrolmentStatus: EnrolmentStatus.EXISTING));
  });

  test('getRegisterBasicUser', () async {
    FlutterCpkPlugin flutterCpkPlugin = FlutterCpkPlugin();
    MockFlutterCpkPluginPlatform fakePlatform = MockFlutterCpkPluginPlatform();
    FlutterCpkPluginPlatform.instance = fakePlatform;

    expect(await flutterCpkPlugin.getRegisterBasicUser('', ''),
        RegisterBasicUserResult(rId: ''));
  });

  test('getWriteProfile', () async {
    FlutterCpkPlugin flutterCpkPlugin = FlutterCpkPlugin();
    MockFlutterCpkPluginPlatform fakePlatform = MockFlutterCpkPluginPlatform();
    FlutterCpkPluginPlatform.instance = fakePlatform;

    expect(await flutterCpkPlugin.getWriteProfile('', '', '', false),
        WriteProfileResult(consumerDeviceNumber: ''));
  });

  test('getWritePasscode', () async {
    FlutterCpkPlugin flutterCpkPlugin = FlutterCpkPlugin();
    MockFlutterCpkPluginPlatform fakePlatform = MockFlutterCpkPluginPlatform();
    FlutterCpkPluginPlatform.instance = fakePlatform;

    expect(await flutterCpkPlugin.getWritePasscode('', '', '', ''),
        WritePasscodeResult(responseStatus: ResponseStatus.SUCCESS));
  });
}
