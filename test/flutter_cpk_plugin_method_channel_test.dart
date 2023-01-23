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
    expect(await platform.saveBiometricConsent('', ''), '42');
  });

  test('getRegisterUserWithBiometrics', () async {
    expect(await platform.getRegisterUserWithBiometrics('', '', ''), '42');
  });

  test('getRegisterBasicUser', () async {
    expect(await platform.getRegisterBasicUser('', ''), '42');
  });

  test('getWriteProfile', () async {
    expect(await platform.getWriteProfile('', '', '', false), '42');
  });

  test('getWritePasscode', () async {
    expect(await platform.getWritePasscode('', '', '', ''), '42');
  });
}
