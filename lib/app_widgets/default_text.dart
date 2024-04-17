import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDefaultText extends StatefulWidget {
  final bool password;
  final String text;

  const CustomDefaultText({
    Key? key,
    required this.text,
    required this.password,
  }) : super(key: key);

  @override
  State<CustomDefaultText> createState() => _CustomDefaultTextState();
}

class _CustomDefaultTextState extends State<CustomDefaultText> {
  String _getDefaultText() {
    return widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 15),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0.5),
      // height: 40,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.grey.shade400,
          //   offset: const Offset(0.0, 0.0), //(x,y)
          //   blurRadius: 2.5,
          // ),
        ],
      ),
      child: Text(
        _getDefaultText(),
        style: TextStyle(
          fontSize: 17.5,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}
