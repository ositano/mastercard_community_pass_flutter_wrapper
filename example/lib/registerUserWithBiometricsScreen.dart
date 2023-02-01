import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_cpk_plugin_example/writeProfileScreen.dart';

class RegisterUserWithBiometricsScreen extends StatefulWidget {
  String value;
  RegisterUserWithBiometricsScreen({super.key, required this.value});

  @override
  State<RegisterUserWithBiometricsScreen> createState() =>
      _RegisterUserWithBiometricsScreenState(value);
}

class _RegisterUserWithBiometricsScreenState
    extends State<RegisterUserWithBiometricsScreen> {
  String value;
  _RegisterUserWithBiometricsScreenState(this.value);

  static const String _programGuid = '8b00c113-6347-4b74-830f-268d267c04c1';
  static const String _reliantAppGuid = '1cf89559-98fb-4080-b24b-6e43a062b239';
  static const String _reliantAppGuidKey = 'RELIANT_APP_GUID';
  static const String _programGuidKey = 'PROGRAM_GUID';
  static const String _consentIdKey = 'CONSENT_ID';
  static const String _rIdKey = 'rId';
  static const String _enrolmentStatusKey = 'enrolmentStatus';
  static const String _bioTokenKkey = 'bioToken';

  final _channel = const MethodChannel('flutter_cpk_plugin');

  String globalRID = '';
  String globalEnrolmentStatus = '';
  String globalBioToken = '';
  bool _isButtonDisabled = true;

  Future<void> getRegisterUserWithBiometrics(String reliantApplicationGuid,
      String programGuid, String consentId) async {
    var result;
    try {
      result = await _channel.invokeMethod('getRegisterUserWithBiometrics', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid,
        _consentIdKey: consentId
      });
    } on PlatformException {
      result = {};
    }

    if (!mounted) return;
    setState(() {
      globalRID = result[_rIdKey];
      globalEnrolmentStatus = result[_enrolmentStatusKey];
      globalBioToken = result[_bioTokenKkey];
      _isButtonDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register User With Biometrics'),
          backgroundColor: const Color.fromRGBO(247, 158, 27, 1),
        ),
        body: Padding(
            padding: const EdgeInsets.all(40),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical:
                            10), //apply padding horizontal or vertical only
                    child:
                        globalRID.isNotEmpty && globalEnrolmentStatus.isNotEmpty
                            ? Text(
                                "rId: $globalRID Enrolment Status: $globalEnrolmentStatus",
                                style: const TextStyle(fontSize: 16.0),
                              )
                            : null,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: globalRID.isNotEmpty
                          ? ElevatedButton(
                              onPressed: _isButtonDisabled
                                  ? null
                                  : () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            WriteProfileScreen(
                                                navigationParams: {
                                              "rId": globalRID,
                                              "registrationType":
                                                  'BIOMETRIC_USER',
                                            }),
                                      ));
                                    },
                              child: const Text("Go to Write Profile"))
                          : ElevatedButton(
                              onPressed: () {
                                getRegisterUserWithBiometrics(
                                    _reliantAppGuid, _programGuid, value);
                              },
                              child: const Text(
                                  "Start biometric user registration")))
                ]))));
  }
}
