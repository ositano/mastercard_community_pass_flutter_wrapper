import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_cpk_plugin_example/writePasscodeScreen.dart';
import 'package:flutter_cpk_plugin_example/writeSuccessfulScreen.dart';

class WriteProfileScreen extends StatefulWidget {
  Map<String, String> navigationParams;
  // WriteProfileScreen({super.key, required this.value});
  WriteProfileScreen({super.key, required this.navigationParams});

  @override
  State<WriteProfileScreen> createState() =>
      _WriteProfileScreenState(navigationParams);
}

class _WriteProfileScreenState extends State<WriteProfileScreen> {
  Map<String, String> receivedParams;
  _WriteProfileScreenState(this.receivedParams);

  static const String _programGuid = '8b00c113-6347-4b74-830f-268d267c04c1';
  static const String _reliantAppGuid = '1cf89559-98fb-4080-b24b-6e43a062b239';

  // request keys
  static const String _reliantAppGuidKey = 'RELIANT_APP_GUID';
  static const String _programGuidKey = 'PROGRAM_GUID';
  static const String _overwriteCardKey = 'OVERWRITE_CARD';
  static const String _rIdKey = 'RID';

  // response keys
  static const String _consumerDeviceNumberResponseKey = 'consumerDeviceNumber';

  final _channel = const MethodChannel('flutter_cpk_plugin');
  String globalConsumerDeviceNumber = '';

  Future<void> getWriteProfile(String reliantApplicationGuid,
      String programGuid, String rId, bool overwriteCard) async {
    var result = {};
    try {
      result = await _channel.invokeMethod('getWriteProfile', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid,
        _rIdKey: rId,
        _overwriteCardKey: overwriteCard
      });
    } on PlatformException catch (ex) {
      result = {};
    }

    if (!mounted) return;
    setState(() {
      globalConsumerDeviceNumber = result[_consumerDeviceNumberResponseKey];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Write Profile on Card'),
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
                    child: globalConsumerDeviceNumber.isNotEmpty
                        ? Text(
                            "Consumer Device Number: $globalConsumerDeviceNumber",
                            style: const TextStyle(fontSize: 16.0),
                          )
                        : null,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: globalConsumerDeviceNumber.isNotEmpty &&
                              receivedParams['registrationType'] ==
                                  "BIOMETRIC_USER"
                          ? ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      WriteSuccessfulScreen(navigationParams: {
                                    "rId": receivedParams['rId']!,
                                    "consumerDeviceNumber":
                                        globalConsumerDeviceNumber,
                                  }),
                                ));
                              },
                              child: const Text("Go to success page"))
                          : null),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: globalConsumerDeviceNumber.isEmpty
                          ? ElevatedButton(
                              onPressed: () {
                                getWriteProfile(_reliantAppGuid, _programGuid,
                                    receivedParams['rId']!, true);
                              },
                              child: const Text("Write Profile on Card"))
                          : null),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: globalConsumerDeviceNumber.isNotEmpty &&
                              receivedParams['registrationType'] == "BASIC_USER"
                          ? ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      WritePasscodeScreen(navigationParams: {
                                    "rId": receivedParams['rId']!,
                                    "consumerDeviceNumber":
                                        globalConsumerDeviceNumber,
                                    "registrationType": 'BIOMETRIC_USER',
                                  }),
                                ));
                              },
                              child: const Text("Go to write passcode"))
                          : null),
                ]))));
  }
}
