import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_cpk_plugin/flutter_cpk_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _connectionStatus = 'Not';
  final String _reliantAppGuid = "0943743843434342";
  final _flutterCpkPlugin = FlutterCpkPlugin();
  final _channel = const MethodChannel('flutter_cpk_plugin');

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initCpkConnectionState(_reliantAppGuid);
  }

  Future<void> initCpkConnectionState(String appGuid) async {
    String result;
    try {
      result = await _channel
          .invokeMethod('getCpkConnectionStatus', {'appGuid': appGuid});
    } on PlatformException {
      result = 'Failed to get the connection status';
    }

    if (!mounted) return;

    setState(() {
      _connectionStatus = result;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterCpkPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CPK connection example'),
          backgroundColor: Colors.black,
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Row(children: [
            Expanded(
                /*1*/
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  /*2*/
                  Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text('Running on: $_platformVersion\n')),
                  Container(
                    child: Text(
                        'Community Pass Service connected: $_connectionStatus',
                        style: TextStyle(
                          color: Colors.grey[500],
                        )),
                  ),
                ]))
          ]),
        ),
      ),
    );
  }
}
