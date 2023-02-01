import 'package:flutter/material.dart';
import 'package:flutter_cpk_plugin_example/main.dart';

class WriteSuccessfulScreen extends StatefulWidget {
  Map<String, String> navigationParams;
  // WriteSuccessfulScreen({super.key, required this.value});
  WriteSuccessfulScreen({super.key, required this.navigationParams});

  @override
  State<WriteSuccessfulScreen> createState() =>
      _WriteSuccessfulScreenState(navigationParams);
}

class _WriteSuccessfulScreenState extends State<WriteSuccessfulScreen> {
  Map<String, String> receivedParams;
  _WriteSuccessfulScreenState(this.receivedParams);

  String consumerDeviceNumber = '';
  String rId = '';

  @override
  void initState() {
    super.initState();
    consumerDeviceNumber = receivedParams['consumerDeviceNumber']!;
    rId = receivedParams['rId']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registraton Successful'),
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
                    child: Text(
                      "Consumer Device Number: $consumerDeviceNumber rId: $rId ",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyApp(),
                            ));
                          },
                          child: const Text("Go Back Home")))
                ]))));
  }
}
