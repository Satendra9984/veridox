import 'package:flutter/material.dart';

class TextDisplay extends StatelessWidget {
  const TextDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Contact Ability',
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
