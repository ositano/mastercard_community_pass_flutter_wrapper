import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cpk_plugin/flutter_cpk_plugin.dart';
import 'package:flutter_cpk_plugin/flutter_cpk_plugin_platform_interface.dart';
import 'package:flutter_cpk_plugin/flutter_cpk_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterCpkPluginPlatform
    with MockPlatformInterfaceMixin
    implements FlutterCpkPluginPlatform {
  @override
  Future<Map<String, String>> saveBiometricConsent(
          String reliantApplicationGuid, String programGuid) =>
      Future.value(saveBiometricConsentMapLiteral);

  @override
  Future<Map<String, String>> getRegisterUserWithBiometrics(
          String reliantApplicationGuid,
          String programGuid,
          String consentId) =>
      Future.value(registerUserWithBiometricsMapLiteral);

  @override
  Future<Map<String, String>> getRegisterBasicUser(
          String reliantApplicationGuid, String programGuid) =>
      Future.value(getRegisterBasicUserMapLiteral);

  @override
  Future<Map<String, String>> getWriteProfile(String reliantApplicationGuid,
          String programGuid, String rId, bool overwriteCard) =>
      Future.value(getWriteProfileMapLiteral);

  @override
  Future<Map<String, String>> getWritePasscode(String reliantApplicationGuid,
          String programGuid, String rId, String passcode) =>
      Future.value(getWritePasscodeMapLiteral);
}

void main() {
  final FlutterCpkPluginPlatform initialPlatform =
      FlutterCpkPluginPlatform.instance;

  test('$MethodChannelFlutterCpkPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterCpkPlugin>());
  });

  test('saveBiometricConsent', () async {
    FlutterCpkPlugin flutterCpkPlugin = FlutterCpkPlugin();
    MockFlutterCpkPluginPlatform fakePlatform = MockFlutterCpkPluginPlatform();
    FlutterCpkPluginPlatform.instance = fakePlatform;

    expect(await flutterCpkPlugin.saveBiometricConsent('', ''),
        saveBiometricConsentMapLiteral);
  });

  test('getRegisterUserWithBiometrics', () async {
    FlutterCpkPlugin flutterCpkPlugin = FlutterCpkPlugin();
    MockFlutterCpkPluginPlatform fakePlatform = MockFlutterCpkPluginPlatform();
    FlutterCpkPluginPlatform.instance = fakePlatform;

    expect(await flutterCpkPlugin.getRegisterUserWithBiometrics('', '', ''),
        registerUserWithBiometricsMapLiteral);
  });

  test('getRegisterBasicUser', () async {
    FlutterCpkPlugin flutterCpkPlugin = FlutterCpkPlugin();
    MockFlutterCpkPluginPlatform fakePlatform = MockFlutterCpkPluginPlatform();
    FlutterCpkPluginPlatform.instance = fakePlatform;

    expect(await flutterCpkPlugin.getRegisterBasicUser('', ''), '40');
  });

  test('getWriteProfile', () async {
    FlutterCpkPlugin flutterCpkPlugin = FlutterCpkPlugin();
    MockFlutterCpkPluginPlatform fakePlatform = MockFlutterCpkPluginPlatform();
    FlutterCpkPluginPlatform.instance = fakePlatform;

    expect(await flutterCpkPlugin.getWriteProfile('', '', '', false), '40');
  });

  test('getWritePasscode', () async {
    FlutterCpkPlugin flutterCpkPlugin = FlutterCpkPlugin();
    MockFlutterCpkPluginPlatform fakePlatform = MockFlutterCpkPluginPlatform();
    FlutterCpkPluginPlatform.instance = fakePlatform;

    expect(await flutterCpkPlugin.getWritePasscode('', '', '', ''), '40');
  });
}
