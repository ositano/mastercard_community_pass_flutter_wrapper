import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_cpk_plugin/flutter_cpk_plugin.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _connectionStatus = 'Not';
  final String _reliantAppGuid =
      "1cf89559-98fb-4080-b24b-6e43a062b239"; // Change this with your Reliant App GUID
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
        title: const Text('Flutter Reliant Application'),
        backgroundColor: const Color.fromRGBO(247, 158, 27, 1),
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
                Container(
                  child: ElevatedButton(
                    child: const Text('Open route'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SecondRoute()),
                      );
                    },
                    style:
                        OutlinedButton.styleFrom(backgroundColor: Colors.black),
                  ),
                ),
                // Container(
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const SecondRoute()),
                //       );
                //       // ScaffoldMessenger.of(context).showSnackBar(
                //       //     const SnackBar(content: Text('Gesture Detected!')));
                //     },
                //     child: Container(
                //       height: 100,
                //       child: const Card(
                //         elevation: 5,
                //         color: Colors.black,
                //         child: Text(
                //             'Geeks for Geeks, Hello this is clickable card, tap me'),
                //       ),
                //     ),
                //   ),
                // )
              ]))
        ]),
      ),
    ));
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Consent'),
        backgroundColor: const Color.fromRGBO(247, 158, 27, 1),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
