import 'package:flutter/material.dart';
import 'package:flutter_cpk_plugin_example/color_utils.dart';

class CardWidgetStateless extends StatelessWidget {
  final String title;
  final String description;
  final String cardLabel;
  final VoidCallback onClick;
  final Icon cardIcon;
  const CardWidgetStateless(
      {super.key,
      required this.onClick,
      required this.cardLabel,
      required this.title,
      required this.description,
      required this.cardIcon});

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
            onTap: () {
              onClick();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cardLabel,
                    style: const TextStyle(color: mastercardOrange),
                  ),
                  ListTile(
                    leading: cardIcon,
                    title: Text(title),
                    subtitle: Text(description),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
