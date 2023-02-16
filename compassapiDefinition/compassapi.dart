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
  final String consentID;
  final ResponseStatus responseStatus;

  SaveBiometricConsentResult(this.consentID, this.responseStatus);
}

class RegisterUserWithBiometricsResult {
  final String bioToken;
  final String programGUID;
  final String rID;
  final EnrolmentStatus enrolmentStatus;

  RegisterUserWithBiometricsResult(
      this.bioToken, this.programGUID, this.rID, this.enrolmentStatus);
}

class RegisterBasicUserResult {
  final String rID;

  RegisterBasicUserResult(this.rID);
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
      String reliantGUID, String programGUID);

  @async
  RegisterUserWithBiometricsResult getRegisterUserWithBiometrics(
      String reliantGUID, String programGUID, String consentID);

  @async
  RegisterBasicUserResult getRegisterBasicUser(
      String reliantGUID, String programGUID);

  @async
  WriteProfileResult getWriteProfile(
      String reliantGUID, String programGUID, String rID, bool overwriteCard);

  @async
  WritePasscodeResult getWritePasscode(
      String reliantGUID, String programGUID, String rID, String passcode);
}
