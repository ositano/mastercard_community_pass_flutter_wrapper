import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_cpk_plugin/flutter_cpk_plugin.dart';
import 'package:flutter_cpk_plugin_example/biometricConsentScreen.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MyAppState();
}

class _MyAppState extends State<MainScreen> {
  static const String _programGuid = '8b00c113-6347-4b74-830f-268d267c04c1';
  static const String _reliantAppGuid = '1cf89559-98fb-4080-b24b-6e43a062b239';
  static const String _reliantAppGuidKey = 'RELIANT_APP_GUID';
  static const String _programGuidKey = 'PROGRAM_GUID';
  static const String _consentIdKey = 'CONSENT_ID';
  static const String _passcodeKey = 'PASSCODE';
  static const String _rIdKey = 'RID';
  static const String _overwriteCardKey = 'OVERWRITE_CARD';

  final _flutterCpkPlugin = FlutterCpkPlugin();
  final _channel = const MethodChannel('flutter_cpk_plugin');

  String _rId = '';
  String _jWt = '';
  String _passcode = '12345';
  String _consentId = '';
  String _writeProfileStatus = '';
  String _writePasscodeStatus = '';

  @override
  void initState() {
    super.initState();
    // initCpkConnectionState(_reliantAppGuid);
  }

  Future<void> saveBiometricConsent(
      String reliantApplicationGuid, String programGuid) async {
    String result;
    try {
      result = await _channel.invokeMethod('saveBiometricConsent', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid
      });
    } on PlatformException {
      result = '';
    }

    if (!mounted) return;
    setState(() {
      _consentId = result;
    });
  }

  Future<void> getWriteProfile(String reliantApplicationGuid,
      String programGuid, String rId, bool overwriteCard) async {
    String result;
    try {
      result = await _channel.invokeMethod('getWriteProfile', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid,
        _rIdKey: rId,
        _overwriteCardKey: overwriteCard
      });
    } on PlatformException {
      result = '';
    }

    if (!mounted) return;
    setState(() {
      _writeProfileStatus = result;
    });
  }

  Future<void> getWritePasscode(String reliantApplicationGuid,
      String programGuid, String rId, String passcode) async {
    String result;
    try {
      result = await _channel.invokeMethod('getWritePasscode', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid,
        _rIdKey: rId,
        _passcodeKey: passcode
      });
    } on PlatformException {
      result = '';
    }

    if (!mounted) return;
    setState(() {
      _writePasscodeStatus = result;
    });
  }

  Future<void> getRegisterUserWithBiometrics(String reliantApplicationGuid,
      String programGuid, String consentId) async {
    String result;
    try {
      result = await _channel.invokeMethod('getRegisterUserWithBiometrics', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid,
        _consentIdKey: consentId
      });
    } on PlatformException {
      result = '';
    }

    if (!mounted) return;
    setState(() {
      _jWt = result;
    });
  }

  Future<void> getRegisterBasicUser(
      String reliantApplicationGuid, String programGuid) async {
    String result;
    try {
      result = await _channel.invokeMethod('getRegisterBasicUser', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid
      });
    } on PlatformException {
      result = '';
    }

    if (!mounted) return;
    setState(() {
      _rId = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Reliant Application'),
          backgroundColor: const Color.fromRGBO(247, 158, 27, 1),
        ),
        body: Padding(
            padding: const EdgeInsets.all(40),
            child: Center(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 20), //apply padding horizontal or vertical only
                child: Text(
                  "This will include all user setup actions that facilitate the onboarding of Users for Community Pass Digital ID, multi-wallet and acceptance accounts.",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BiometricConsentScreen()));
                      },
                      child: const Text("Pre-Transaction Phase")))
            ]))));
  }
}

// Container(
//         padding: const EdgeInsets.all(32),
//         child: Row(children: [
//           Expanded(
//               /*1*/
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                 Container(
//                   child: Text('Consent ID: $_consentId',
//                       style: TextStyle(
//                         color: Colors.grey[500],
//                       )),
//                 ),
//                 Container(
//                   child: ElevatedButton(
//                     child: const Text('Save Biometric Consent'),
//                     onPressed: () {
//                       saveBiometricConsent(_reliantAppGuid, _programGuid);
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //       builder: (context) => const SecondRoute()),
//                       // );
//                     },
//                     style:
//                         OutlinedButton.styleFrom(backgroundColor: Colors.black),
//                   ),
//                 ),
//                 Container(
//                   child: Text('jWt: $_jWt',
//                       style: TextStyle(
//                         color: Colors.grey[500],
//                       )),
//                 ),
//                 Container(
//                   child: ElevatedButton(
//                     child: const Text('Register user with biometric'),
//                     onPressed: () {
//                       getRegisterUserWithBiometrics(
//                           _reliantAppGuid, _programGuid, _consentId);
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //       builder: (context) => const SecondRoute()),
//                       // );
//                     },
//                     style:
//                         OutlinedButton.styleFrom(backgroundColor: Colors.black),
//                   ),
//                 ),
//                 Container(
//                   child:
//                       Text('Response from write profile: $_writeProfileStatus',
//                           style: TextStyle(
//                             color: Colors.grey[500],
//                           )),
//                 ),
//                 Container(
//                   child: ElevatedButton(
//                     child: const Text('Write Profile'),
//                     onPressed: () {
//                       getWriteProfile(
//                           _reliantAppGuid, _programGuid, _rId, false);
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //       builder: (context) => const SecondRoute()),
//                       // );
//                     },
//                     style:
//                         OutlinedButton.styleFrom(backgroundColor: Colors.black),
//                   ),
//                 ),
//                 Container(
//                   child: Text(
//                       'Response from write passcode: $_writePasscodeStatus',
//                       style: TextStyle(
//                         color: Colors.grey[500],
//                       )),
//                 ),
//                 Container(
//                   child: ElevatedButton(
//                     child: const Text('Write Passcode'),
//                     onPressed: () {
//                       getWritePasscode(
//                           _reliantAppGuid, _programGuid, _rId, _passcode);
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //       builder: (context) => const SecondRoute()),
//                       // );
//                     },
//                     style:
//                         OutlinedButton.styleFrom(backgroundColor: Colors.black),
//                   ),
//                 ),
//                 Container(
//                   child: Text('Response from register basic user: $_rId',
//                       style: TextStyle(
//                         color: Colors.grey[500],
//                       )),
//                 ),
//                 Container(
//                   child: ElevatedButton(
//                     child: const Text('Register Basic User'),
//                     onPressed: () {
//                       getRegisterBasicUser(_reliantAppGuid, _programGuid);
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //       builder: (context) => const SecondRoute()),
//                       // );
//                     },
//                     style:
//                         OutlinedButton.styleFrom(backgroundColor: Colors.black),
//                   ),
//                 ),
//  ]))
//     ]),
//   ),
