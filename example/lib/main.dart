import 'package:flutter/material.dart';
import 'mainScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Reliant Application',
        theme: ThemeData(primaryColor: const Color.fromRGBO(247, 158, 27, 1)),
        home: const MainScreen());
  }
}


  // Future<void> saveBiometricConsent(
  //     String reliantApplicationGuid, String programGuid) async {
  //   String result;
  //   try {
  //     result = await _channel.invokeMethod('saveBiometricConsent', {
  //       _reliantAppGuidKey: reliantApplicationGuid,
  //       _programGuidKey: programGuid
  //     });
  //   } on PlatformException {
  //     result = '';
  //   }

  //   if (!mounted) return;
  //   setState(() {
  //     _consentId = result;
  //   });
  // }

  // Future<void> getWriteProfile(String reliantApplicationGuid,
  //     String programGuid, String rId, bool overwriteCard) async {
  //   String result;
  //   try {
  //     result = await _channel.invokeMethod('getWriteProfile', {
  //       _reliantAppGuidKey: reliantApplicationGuid,
  //       _programGuidKey: programGuid,
  //       _rIdKey: rId,
  //       _overwriteCardKey: overwriteCard
  //     });
  //   } on PlatformException {
  //     result = '';
  //   }

  //   if (!mounted) return;
  //   setState(() {
  //     _writeProfileStatus = result;
  //   });
  // }

  // Future<void> getWritePasscode(String reliantApplicationGuid,
  //     String programGuid, String rId, String passcode) async {
  //   String result;
  //   try {
  //     result = await _channel.invokeMethod('getWritePasscode', {
  //       _reliantAppGuidKey: reliantApplicationGuid,
  //       _programGuidKey: programGuid,
  //       _rIdKey: rId,
  //       _passcodeKey: passcode
  //     });
  //   } on PlatformException {
  //     result = '';
  //   }

  //   if (!mounted) return;
  //   setState(() {
  //     _writePasscodeStatus = result;
  //   });
  // }

  // Future<void> getRegisterUserWithBiometrics(String reliantApplicationGuid,
  //     String programGuid, String consentId) async {
  //   String result;
  //   try {
  //     result = await _channel.invokeMethod('getRegisterUserWithBiometrics', {
  //       _reliantAppGuidKey: reliantApplicationGuid,
  //       _programGuidKey: programGuid,
  //       _consentIdKey: consentId
  //     });
  //   } on PlatformException {
  //     result = '';
  //   }

  //   if (!mounted) return;
  //   setState(() {
  //     _jWt = result;
  //   });
  // }

  // Future<void> getRegisterBasicUser(
  //     String reliantApplicationGuid, String programGuid) async {
  //   String result;
  //   try {
  //     result = await _channel.invokeMethod('getRegisterBasicUser', {
  //       _reliantAppGuidKey: reliantApplicationGuid,
  //       _programGuidKey: programGuid
  //     });
  //   } on PlatformException {
  //     result = '';
  //   }

  //   if (!mounted) return;
  //   setState(() {
  //     _rId = result;
  //   });
  // }
