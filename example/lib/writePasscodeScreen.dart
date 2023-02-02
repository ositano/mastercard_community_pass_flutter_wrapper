import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_cpk_plugin_example/color_utils.dart';
import 'package:flutter_cpk_plugin_example/writeSuccessfulScreen.dart';

class WritePasscodeScreen extends StatefulWidget {
  Map<String, String> navigationParams;
  // WritePasscodeScreen({super.key, required this.value});
  WritePasscodeScreen({super.key, required this.navigationParams});

  @override
  State<WritePasscodeScreen> createState() =>
      _WritePasscodeScreenState(navigationParams);
}

class _WritePasscodeScreenState extends State<WritePasscodeScreen>
    with TickerProviderStateMixin {
  Map<String, String> receivedParams;
  _WritePasscodeScreenState(this.receivedParams);

  final myController = TextEditingController();
  late AnimationController controller;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

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

  static const String _programGuid = '8b00c113-6347-4b74-830f-268d267c04c1';
  static const String _reliantAppGuid = '1cf89559-98fb-4080-b24b-6e43a062b239';

  // request keys
  static const String _reliantAppGuidKey = 'RELIANT_APP_GUID';
  static const String _programGuidKey = 'PROGRAM_GUID';
  static const String _passcodeKey = 'PASSCODE';
  static const String _rIdKey = 'RID';
  String globalError = '';
  bool globalLoading = false;

  // response keys
  static const String _responseStatusKey = 'responseStatus';
  final _channel = const MethodChannel('flutter_cpk_plugin');

  Future<void> getWritePasscode(String reliantApplicationGuid,
      String programGuid, String rId, String passcode) async {
    globalLoading = true;
    var result = {};
    String e = '';

    try {
      result = await _channel.invokeMethod('getWritePasscode', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid,
        _rIdKey: rId,
        _passcodeKey: passcode
      });
    } on PlatformException catch (ex) {
      e = '${ex.code} ${ex.message}';
    }

    if (!mounted) return;
    setState(() {
      if (result[_responseStatusKey] == 'Success') {
        globalLoading = false;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WriteSuccessfulScreen(navigationParams: {
            "rId": receivedParams['rId']!,
            "consumerDeviceNumber": receivedParams['consumerDeviceNumber']!,
          }),
        ));
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
          title: const Text('Write Passcode'),
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
                    'Part 4: Write Passcode',
                    style: TextStyle(fontSize: 20),
                  )),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'This step calls the getWritePasscode API used to write a Passcode to the card. This is initiated by the Reliant Application to CPK after a successful user registration.',
                    style: TextStyle(fontSize: 16),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextField(
                  controller: myController,
                  cursorColor: mastercardYellow,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: mastercardOrange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: mastercardYellow),
                    ),
                    hintText: 'Enter a 6 digit passcode',
                  ),
                ),
              ),
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
                  // height: 100,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 50),
                              backgroundColor: mastercardOrange),
                          onPressed: (() {
                            getWritePasscode(
                                _reliantAppGuid,
                                _programGuid,
                                receivedParams['rId']!,
                                myController.text.toString());
                          }),
                          child: const Text('Start registration')))),
            ]));
  }
}
