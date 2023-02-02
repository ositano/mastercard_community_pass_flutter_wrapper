import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_cpk_plugin_example/color_utils.dart';
import 'package:flutter_cpk_plugin_example/writeProfileScreen.dart';

class RegisterBasicUserScreen extends StatefulWidget {
  String value;
  RegisterBasicUserScreen({super.key, required this.value});

  @override
  State<RegisterBasicUserScreen> createState() =>
      _RegisterBasicUserScreenState(value);
}

class _RegisterBasicUserScreenState extends State<RegisterBasicUserScreen>
    with TickerProviderStateMixin {
  String value;
  _RegisterBasicUserScreenState(this.value);

  static const String _programGuid = '8b00c113-6347-4b74-830f-268d267c04c1';
  static const String _reliantAppGuid = '1cf89559-98fb-4080-b24b-6e43a062b239';
  static const String _reliantAppGuidKey = 'RELIANT_APP_GUID';
  static const String _programGuidKey = 'PROGRAM_GUID';
  static const String _rIdKey = 'rId';

  final _channel = const MethodChannel('flutter_cpk_plugin');

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

  Future<void> getRegisterBasicUser(
      String reliantApplicationGuid, String programGuid) async {
    globalLoading = true;
    var result = {};
    String e = '';

    try {
      result = await _channel.invokeMethod('getRegisterBasicUser', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid,
      });
    } on PlatformException catch (ex) {
      e = '${ex.code} ${ex.message}';
    }

    if (!mounted) return;
    setState(() {
      if (result[_rIdKey] != null) {
        globalLoading = false;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WriteProfileScreen(navigationParams: {
                  "rId": result[_rIdKey],
                  "registrationType": 'BASIC_USER',
                })));
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
          title: const Text('Basic user Registration'),
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
                    'Part 2: Register Basic User',
                    style: TextStyle(fontSize: 20),
                  )),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'This step calls the getRegisterBasicUser API method and returns a rId.',
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
                            getRegisterBasicUser(_reliantAppGuid, _programGuid);
                          }),
                          child: const Text('Start registration')))),
            ]));
  }
}
