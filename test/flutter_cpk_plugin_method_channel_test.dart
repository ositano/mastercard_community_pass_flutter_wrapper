import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cpk_plugin/flutter_cpk_plugin_method_channel.dart';

void main() {
  MethodChannelFlutterCpkPlugin platform = MethodChannelFlutterCpkPlugin();
  const MethodChannel channel = MethodChannel('flutter_cpk_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('saveBiometricConsent', () async {
    expect(await platform.saveBiometricConsent('', ''),
        saveBiometricConsentMapLiteral);
  });

  test('getRegisterUserWithBiometrics', () async {
    expect(await platform.getRegisterUserWithBiometrics('', '', ''),
        registerUserWithBiometricsMapLiteral);
  });

  test('getRegisterBasicUser', () async {
    expect(await platform.getRegisterBasicUser('', ''),
        getRegisterBasicUserMapLiteral);
  });

  test('getWriteProfile', () async {
    expect(await platform.getWriteProfile('', '', '', false),
        getWriteProfileMapLiteral);
  });

  test('getWritePasscode', () async {
    expect(await platform.getWritePasscode('', '', '', ''),
        getWritePasscodeMapLiteral);
  });
}
