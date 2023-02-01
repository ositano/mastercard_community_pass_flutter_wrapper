import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_cpk_plugin_example/writeProfileScreen.dart';

class RegisterBasicUserScreen extends StatefulWidget {
  String value;
  RegisterBasicUserScreen({super.key, required this.value});

  @override
  State<RegisterBasicUserScreen> createState() =>
      _RegisterBasicUserScreenState(value);
}

class _RegisterBasicUserScreenState extends State<RegisterBasicUserScreen> {
  String value;
  _RegisterBasicUserScreenState(this.value);

  static const String _programGuid = '8b00c113-6347-4b74-830f-268d267c04c1';
  static const String _reliantAppGuid = '1cf89559-98fb-4080-b24b-6e43a062b239';
  static const String _reliantAppGuidKey = 'RELIANT_APP_GUID';
  static const String _programGuidKey = 'PROGRAM_GUID';
  static const String _rIdKey = 'rId';

  final _channel = const MethodChannel('flutter_cpk_plugin');

  String globalRID = '';
  bool _isButtonDisabled = true;

  Future<void> getRegisterBasicUser(
      String reliantApplicationGuid, String programGuid) async {
    var result;
    try {
      result = await _channel.invokeMethod('getRegisterBasicUser', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid,
      });
    } on PlatformException {
      result = {};
    }

    if (!mounted) return;
    setState(() {
      globalRID = result[_rIdKey];
      _isButtonDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Basic user Registration'),
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
                    child: globalRID.isNotEmpty
                        ? Text(
                            "rId: $globalRID ",
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
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WriteProfileScreen(
                                                      navigationParams: {
                                                        "rId": globalRID,
                                                        "registrationType":
                                                            'BASIC_USER',
                                                      })));
                                    },
                              child: const Text("Go to Write Profile"))
                          : ElevatedButton(
                              onPressed: () {
                                getRegisterBasicUser(
                                    _reliantAppGuid, _programGuid);
                              },
                              child:
                                  const Text("Start basic user registration")))
                ]))));
  }
}
