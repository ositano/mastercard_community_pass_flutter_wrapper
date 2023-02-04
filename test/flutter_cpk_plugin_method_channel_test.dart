import 'package:flutter/services.dart';
import 'package:flutter_cpk_plugin/compassapi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cpk_plugin/flutter_cpk_plugin_method_channel.dart';

void main() {
  PigeonFlutterCpkPlugin platform = PigeonFlutterCpkPlugin();
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
    expect(
        await platform.saveBiometricConsent('', ''),
        SaveBiometricConsentResult(
            consentId: '', responseStatus: ResponseStatus.SUCCESS));
  });

  test('getRegisterUserWithBiometrics', () async {
    expect(
        await platform.getRegisterUserWithBiometrics('', '', ''),
        RegisterUserWithBiometricsResult(
            bioToken: '',
            programGUID: '',
            rId: '',
            enrolmentStatus: EnrolmentStatus.EXISTING));
  });

  test('getRegisterBasicUser', () async {
    expect(await platform.getRegisterBasicUser('', ''),
        RegisterBasicUserResult(rId: ''));
  });

  test('getWriteProfile', () async {
    expect(await platform.getWriteProfile('', '', '', false),
        WriteProfileResult(consumerDeviceNumber: ''));
  });

  test('getWritePasscode', () async {
    expect(await platform.getWritePasscode('', '', '', ''),
        WritePasscodeResult(responseStatus: ResponseStatus.SUCCESS));
  });
}
