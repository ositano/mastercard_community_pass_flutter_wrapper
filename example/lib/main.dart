import 'package:flutter/material.dart';
import 'package:flutter_cpk_plugin_example/mainScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Reliant Application',
        theme: ThemeData(primaryColor: const Color.fromRGBO(247, 158, 27, 1)),
        home: const MainScreen());
  }
}
