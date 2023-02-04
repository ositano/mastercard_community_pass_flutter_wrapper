import 'package:pigeon/pigeon.dart';

// flutter pub run pigeon --input compassapiDefinition/compassapi.dart
@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/compassapi.dart',
  dartTestOut: 'test/test_api.dart',
  javaOut:
      'android/src/main/java/com/mastercard/compass/cp3/java_flutter_wrapper/CompassApiFlutter.java',
  javaOptions: JavaOptions(
    package: 'com.mastercard.compass.cp3.java_flutter_wrapper',
  ),
  copyrightHeader: 'compassapiDefinition/copyright.txt',
))
enum EnrolmentStatus { EXISTING, NEW }

enum ResponseStatus { SUCCESS, FAIL }

class SaveBiometricConsentResult {
  final String consentId;
  final ResponseStatus responseStatus;

  SaveBiometricConsentResult(this.consentId, this.responseStatus);
}

class RegisterUserWithBiometricsResult {
  final String bioToken;
  final String programGUID;
  final String rId;
  final EnrolmentStatus enrolmentStatus;

  RegisterUserWithBiometricsResult(
      this.bioToken, this.programGUID, this.rId, this.enrolmentStatus);
}

class RegisterBasicUserResult {
  final String rId;

  RegisterBasicUserResult(this.rId);
}

class WriteProfileResult {
  final String consumerDeviceNumber;

  WriteProfileResult(this.consumerDeviceNumber);
}

class WritePasscodeResult {
  final ResponseStatus responseStatus;

  WritePasscodeResult(this.responseStatus);
}

@HostApi()
abstract class CommunityPassApi {
  @async
  SaveBiometricConsentResult saveBiometricConsent(
      String reliantAppGUID, String programGUID);

  @async
  RegisterUserWithBiometricsResult getRegisterUserWithBiometrics(
      String reliantAppGUID, String programGUID, String consentId);

  @async
  RegisterBasicUserResult getRegisterBasicUser(
      String reliantAppGUID, String programGUID);

  @async
  WriteProfileResult getWriteProfile(String reliantAppGUID, String programGUID,
      String rId, bool overwriteCard);

  @async
  WritePasscodeResult getWritePasscode(
      String reliantAppGUID, String programGUID, String rId, String passcode);
}
