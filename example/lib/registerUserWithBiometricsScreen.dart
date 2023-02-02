import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cpk_plugin_example/color_utils.dart';
import 'package:flutter_cpk_plugin_example/main.dart';
import 'package:flutter_cpk_plugin_example/utils.dart';
import 'package:flutter_cpk_plugin_example/writeProfileScreen.dart';

class RegisterUserWithBiometricsScreen extends StatefulWidget {
  String value;
  RegisterUserWithBiometricsScreen({super.key, required this.value});

  @override
  State<RegisterUserWithBiometricsScreen> createState() =>
      _RegisterUserWithBiometricsScreenState(value);
}

class _RegisterUserWithBiometricsScreenState
    extends State<RegisterUserWithBiometricsScreen>
    with TickerProviderStateMixin {
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

  String globalError = '';
  bool globalLoading = false;
  bool isDialogOpen = false;

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

  Future<void> getRegisterUserWithBiometrics(String reliantApplicationGuid,
      String programGuid, String consentId) async {
    globalLoading = true;
    var result = {};
    String e = '';

    try {
      result = await _channel.invokeMethod('getRegisterUserWithBiometrics', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid,
        _consentIdKey: consentId
      });
    } on PlatformException catch (ex) {
      e = '${ex.code} ${ex.message}';
    }

    if (!mounted) return;
    setState(() {
      if (result[_rIdKey] != null) {
        globalLoading = false;
        if (result[_enrolmentStatusKey] == 'EXISTING') {
          Future.delayed(Duration.zero, () {
            showAlert(context, result[_rIdKey]);
          });
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WriteProfileScreen(navigationParams: {
              "rId": result[_rIdKey],
              "registrationType": 'BIOMETRIC_USER',
            }),
          ));
        }
      } else {
        globalLoading = false;
        globalError = e;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register User With Biometrics'),
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
                          style:
                              const TextStyle(fontSize: 12, color: Colors.red),
                        )
                      : null),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'Part 2: Register Biometric User',
                    style: TextStyle(fontSize: 20),
                  )),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'This step calls the getRegisterUserWithBiometrics API method. The kernel will perform capture, validate biometric hashes created via a one to many search, create the Compass and return a R-ID as part of the process.',
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
              SizedBox(
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 50),
                              backgroundColor: mastercardOrange),
                          onPressed: (() {
                            getRegisterUserWithBiometrics(
                                _reliantAppGuid, _programGuid, value);
                          }),
                          child: const Text('Start registration')))),
            ]));
  }

  void showAlert(BuildContext context, rId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('User Found In Records!'),
              content: const Text(
                  'A match of the biometrics hashes of this user has been found in our records.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  )),
                  child: const Text('Cancel Registration',
                      style: TextStyle(color: mastercardRed)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WriteProfileScreen(navigationParams: {
                      "rId": rId,
                      "registrationType": 'BIOMETRIC_USER',
                    }),
                  )),
                  child: const Text(
                    'Continue with Registration',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ));
  }
}
