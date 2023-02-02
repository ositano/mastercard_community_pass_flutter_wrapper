// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_cpk_plugin_example/color_utils.dart';
import 'package:flutter_cpk_plugin_example/registerBasicUserScreen.dart';
import 'package:flutter_cpk_plugin_example/registerUserWithBiometricsScreen.dart';
import 'package:flutter/services.dart';
import 'color_utils.dart';

class BiometricConsentScreen extends StatefulWidget {
  const BiometricConsentScreen({super.key});

  @override
  State<BiometricConsentScreen> createState() => _BiometricConsentScreenState();
}

class _BiometricConsentScreenState extends State<BiometricConsentScreen>
    with TickerProviderStateMixin {
  final _channel = const MethodChannel('flutter_cpk_plugin');

  static const String _programGuid = '8b00c113-6347-4b74-830f-268d267c04c1';
  static const String _reliantAppGuid = '1cf89559-98fb-4080-b24b-6e43a062b239';
  static const String _reliantAppGuidKey = 'RELIANT_APP_GUID';
  static const String _programGuidKey = 'PROGRAM_GUID';
  static const String _consentIdKey = 'consentId';

  String _consentId = '';
  String globalError = '';
  bool globalLoading = false;

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> saveBiometricConsent(
      String reliantApplicationGuid, String programGuid) async {
    globalLoading = true;
    var result = {};
    String e = '';
    try {
      result = await _channel.invokeMethod('saveBiometricConsent', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid
      });
    } on PlatformException catch (ex) {
      e = '${ex.code} ${ex.message}';
    }

    // check whether this [state] object is currentyl in a tree
    if (!mounted) return;

    // update state
    setState(() {
      if (result[_consentIdKey] != null) {
        globalLoading = false;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RegisterUserWithBiometricsScreen(
                    value: result[_consentIdKey])));
      } else {
        globalError = e;
        globalLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Biometrics Consent'),
          backgroundColor: mastercardOrange,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: globalError.isNotEmpty
                    ? Text(
                        'Error: $globalError',
                        style: const TextStyle(fontSize: 12, color: Colors.red),
                      )
                    : null),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  'Part 1: Capture Consent',
                  style: TextStyle(fontSize: 20),
                )),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  'This step calls the saveBiometricConsent API method. In this step, we check that a user has consented to capturing and storing their biometrics. If a user declines. You will register using passcode.',
                  style: TextStyle(fontSize: 16),
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: globalLoading
                    ? LinearProgressIndicator(
                        value: controller.value,
                        color: mastercardOrange,
                        backgroundColor: gray,
                        semanticsLabel: 'Linear progress indicator',
                      )
                    : null),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(100, 50),
                            ),
                            onPressed: (() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterBasicUserScreen(
                                        value: _consentId,
                                      )));
                            }),
                            child: const Text(
                              'Deny Consent',
                              style: TextStyle(color: mastercardOrange),
                            )))),
                Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 50),
                                backgroundColor: mastercardOrange),
                            onPressed: (() {
                              saveBiometricConsent(
                                  _reliantAppGuid, _programGuid);
                            }),
                            child: const Text('Grant Consent'))))
              ],
            )
          ],
        ));
  }
}
