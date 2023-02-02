import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_cpk_plugin_example/color_utils.dart';
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

class _WriteProfileScreenState extends State<WriteProfileScreen>
    with TickerProviderStateMixin {
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

  String globalError = '';
  bool globalLoading = false;
  bool overwriteCardValue = false;

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

  Future<void> getWriteProfile(String reliantApplicationGuid,
      String programGuid, String rId, bool overwriteCard) async {
    globalLoading = true;
    var result = {};
    String e = '';

    try {
      result = await _channel.invokeMethod('getWriteProfile', {
        _reliantAppGuidKey: reliantApplicationGuid,
        _programGuidKey: programGuid,
        _rIdKey: rId,
        _overwriteCardKey: overwriteCard
      });
    } on PlatformException catch (ex) {
      e = '${ex.code} ${ex.message}';
    }

    if (!mounted) return;
    setState(() {
      if (result[_consumerDeviceNumberResponseKey] != null) {
        globalLoading = false;
        if (receivedParams['registrationType'] == "BIOMETRIC_USER") {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WriteSuccessfulScreen(navigationParams: {
              "rId": receivedParams['rId']!,
              "consumerDeviceNumber": result[_consumerDeviceNumberResponseKey],
            }),
          ));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WritePasscodeScreen(navigationParams: {
              "rId": receivedParams['rId']!,
              "consumerDeviceNumber": result[_consumerDeviceNumberResponseKey],
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
          title: const Text('Write Profile on Card'),
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
                    'Part 3: Write Card',
                    style: TextStyle(fontSize: 20),
                  )),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'This step calls the writeProfile API method. The kernel will perform a write operation on the card and return a rId.',
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
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  child: CheckboxListTile(
                    title: const Text("Overwrite card"),
                    value: overwriteCardValue,
                    activeColor: mastercardOrange,
                    onChanged: (newValue) {
                      setState(() {
                        overwriteCardValue = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  )),
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
                            getWriteProfile(_reliantAppGuid, _programGuid,
                                receivedParams['rId']!, overwriteCardValue);
                          }),
                          child: const Text('Write Profile on Card')))),
            ]));
  }
}
