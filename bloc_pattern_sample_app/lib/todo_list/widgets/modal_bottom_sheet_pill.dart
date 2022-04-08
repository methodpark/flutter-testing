import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  final String text;

  const Pill({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
        margin: const EdgeInsets.all(15),
        child: Text(text, textScaleFactor: 1.5),
      ),
    );
  }
}
