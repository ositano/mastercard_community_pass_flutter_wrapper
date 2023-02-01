import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_cpk_plugin_example/writeSuccessfulScreen.dart';

class WritePasscodeScreen extends StatefulWidget {
  Map<String, String> navigationParams;
  // WritePasscodeScreen({super.key, required this.value});
  WritePasscodeScreen({super.key, required this.navigationParams});

  @override
  State<WritePasscodeScreen> createState() =>
      _WritePasscodeScreenState(navigationParams);
}

class _WritePasscodeScreenState extends State<WritePasscodeScreen> {
  Map<String, String> receivedParams;
  _WritePasscodeScreenState(this.receivedParams);

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  static const String _programGuid = '8b00c113-6347-4b74-830f-268d267c04c1';
  static const String _reliantAppGuid = '1cf89559-98fb-4080-b24b-6e43a062b239';

  // request keys
  static const String _reliantAppGuidKey = 'RELIANT_APP_GUID';
  static const String _programGuidKey = 'PROGRAM_GUID';
  static const String _passcodeKey = 'PASSCODE';
  static const String _rIdKey = 'RID';

  // response keys
  static const String _responseStatusKey = 'responseStatus';

  final _channel = const MethodChannel('flutter_cpk_plugin');
  String responseStatus = '';
  bool _isButtonDisabled = true;

  Future<void> getWritePasscode(String reliantApplicationGuid,
      String programGuid, String rId, String passcode) async {
    var result = {};
    try {
      result = await _channel.invokeMethod('getWritePasscode', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid,
        _rIdKey: rId,
        _passcodeKey: passcode
      });
    } on PlatformException {
      result = {};
    }

    if (!mounted) return;
    setState(() {
      responseStatus = result[_responseStatusKey];
      _isButtonDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Write Passcode'),
          backgroundColor: const Color.fromRGBO(247, 158, 27, 1),
        ),
        body: Padding(
            padding: const EdgeInsets.all(40),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: myController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a 6 digit passcode',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical:
                            10), //apply padding horizontal or vertical only
                    child: responseStatus.isNotEmpty
                        ? Text(
                            "Status: $responseStatus",
                            style: const TextStyle(fontSize: 16.0),
                          )
                        : null,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: responseStatus.isNotEmpty
                          ? ElevatedButton(
                              onPressed: _isButtonDisabled
                                  ? null
                                  : () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            WriteSuccessfulScreen(
                                                navigationParams: {
                                              "rId": receivedParams['rId']!,
                                              "consumerDeviceNumber":
                                                  receivedParams[
                                                      'consumerDeviceNumber']!,
                                            }),
                                      ));
                                    },
                              child: const Text("Go to success page"))
                          : ElevatedButton(
                              onPressed: () {
                                getWritePasscode(
                                    _reliantAppGuid,
                                    _programGuid,
                                    receivedParams['rId']!,
                                    myController.text.toString());
                              },
                              child: const Text("Write passcode on card")))
                ]))));
  }
}
