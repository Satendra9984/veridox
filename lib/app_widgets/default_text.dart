import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDefaultText extends StatefulWidget {
  final bool password;
  final String text;
  final TextEditingController controller;

  const CustomDefaultText({
    Key? key,
    required this.text,
    required this.password,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomDefaultText> createState() => _CustomDefaultTextState();
}

class _CustomDefaultTextState extends State<CustomDefaultText> {
  String _getDefaultText() {
    widget.controller.text = widget.text;
    return widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 15),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0.5),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.grey.shade400,
        // ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(0.0, 15), //(x,y)
            blurRadius: 10,
          ),
        ],
      ),
      child: Text(
        _getDefaultText(),
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
