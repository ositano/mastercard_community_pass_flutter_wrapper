import 'package:flutter/material.dart';
import 'package:flutter_cpk_plugin_example/registerUserWithBiometrics.dart';

import 'package:flutter/services.dart';

class BiometricConsentScreen extends StatefulWidget {
  const BiometricConsentScreen({super.key});

  @override
  State<BiometricConsentScreen> createState() => _BiometricConsentScreenState();
}

class _BiometricConsentScreenState extends State<BiometricConsentScreen> {
  final _channel = const MethodChannel('flutter_cpk_plugin');

  static const String _programGuid = '8b00c113-6347-4b74-830f-268d267c04c1';
  static const String _reliantAppGuid = '1cf89559-98fb-4080-b24b-6e43a062b239';
  static const String _reliantAppGuidKey = 'RELIANT_APP_GUID';
  static const String _programGuidKey = 'PROGRAM_GUID';

  String _consentId = '';

  @override
  void initState() {
    super.initState();
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
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 20), //apply padding horizontal or vertical only
                child: Text(
                  "Grant consent to collect biometrics (Face, Left palm and Right palm",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: _consentId.isNotEmpty
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    RegisterUserWithBiometricsScreen(
                                        value: _consentId)));
                          },
                          child: const Text("Go to user registration"))
                      : ElevatedButton(
                          onPressed: () {
                            saveBiometricConsent(_reliantAppGuid, _programGuid);
                          },
                          child: const Text("Grant")))
            ]))));
  }
}
