import 'package:flutter/material.dart';
import 'package:compass_library_wrapper_plugin_example/mainScreen.dart';
import 'color_utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Community Pass Flutter Reliant Application',
        theme: ThemeData(primaryColor: mastercardOrange),
        home: const MainScreen());
  }
}
