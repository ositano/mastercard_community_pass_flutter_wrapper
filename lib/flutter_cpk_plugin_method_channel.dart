import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_cpk_plugin_platform_interface.dart';

var saveBiometricConsentMapLiteral = {'consentId': ''};
var registerUserWithBiometricsMapLiteral = {
  'rId': '',
  'enrolmentStatus': '',
  'bioToken': '',
  'programGUID': ''
};
var getRegisterBasicUserMapLiteral = {'rId': ''};
var getWritePasscodeMapLiteral = {
  'responseStatus': '',
};

var getWriteProfileMapLiteral = {
  'consumerDeviceNumber': '',
};

typedef IntList = Map<String, String>;

/// An implementation of [FlutterCpkPluginPlatform] that uses method channels.
class MethodChannelFlutterCpkPlugin extends FlutterCpkPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_cpk_plugin');
  static const String _reliantAppGuidKey = 'RELIANT_APP_GUID';
  static const String _programGuidKey = 'PROGRAM_GUID';
  static const String _consentIdKey = 'CONSENT_ID';
  static const String _passcodeKey = 'PASSCODE';
  static const String _rIdKey = 'RID';
  static const String _overwriteCardKey = 'OVERWRITE_CARD';

  @override
  Future<Map<String, String>> saveBiometricConsent(
      String reliantApplicationGuid, String programGuid) async {
    try {
      final result = await methodChannel.invokeMethod('saveBiometricConsent', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid
      });
      return result;
    } on PlatformException catch (ex) {
      return {"code": ex.code, "message": ex.message ?? "Uknown error"};
    }
  }

  @override
  Future<Map<String, String>> getRegisterUserWithBiometrics(
      String reliantApplicationGuid,
      String programGuid,
      String consentId) async {
    try {
      final result =
          await methodChannel.invokeMethod('getRegisterUserWithBiometrics', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid,
        _consentIdKey: consentId
      });
      return result;
    } on PlatformException catch (ex) {
      return {"code": ex.code, "message": ex.message ?? "Uknown error"};
    }
  }

  @override
  Future<Map<String, String>> getRegisterBasicUser(
      String reliantApplicationGuid, String programGuid) async {
    try {
      final result = await methodChannel.invokeMethod('getRegisterBasicUser', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid
      });
      return result;
    } on PlatformException catch (ex) {
      return {"code": ex.code, "message": ex.message ?? "Uknown error"};
    }
  }

  @override
  Future<Map<String, String>> getWriteProfile(String reliantApplicationGuid,
      String programGuid, String rId, bool overwriteCard) async {
    try {
      final result = await methodChannel.invokeMethod('getWriteProfile', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid,
        _rIdKey: rId,
        _overwriteCardKey: overwriteCard
      });
      return result;
    } on PlatformException catch (ex) {
      return {"code": ex.code, "message": ex.message ?? "Uknown error"};
    }
  }

  @override
  Future<Map<String, String>> getWritePasscode(String reliantApplicationGuid,
      String programGuid, String rId, String passcode) async {
    try {
      final result = await methodChannel.invokeMethod('getWritePasscode', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid,
        _rIdKey: rId,
        _passcodeKey: passcode
      });
      return result;
    } on PlatformException catch (ex) {
      return {"code": ex.code, "message": ex.message ?? "Uknown error"};
    }
  }
}
