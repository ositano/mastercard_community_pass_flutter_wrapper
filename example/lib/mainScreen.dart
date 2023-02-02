import 'package:flutter/material.dart';
import 'package:flutter_cpk_plugin_example/biometricConsentScreen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Flutter Reliant Application',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(247, 158, 27, 1),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: const <Widget>[
              Spacer(),
              StatelessCardWidget(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class StatelessCardWidget extends StatelessWidget {
  const StatelessCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        elevation: 6,
        shadowColor: const Color.fromARGB(80, 191, 191, 191),
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Color.fromARGB(80, 191, 191, 191),
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: InkWell(
            //     // splashColor: Colors.white,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BiometricConsentScreen()));
            },
            child: SizedBox(
              width: double.infinity,
              height: 120,
              child: Column(
                children: const <Widget>[
                  ListTile(
                    leading: Icon(Icons.logout_outlined),
                    title: Text('Pre-Transactions Phase'),
                    subtitle: Text(
                        'You will complete user setup and on-boarding in this phase.'),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
