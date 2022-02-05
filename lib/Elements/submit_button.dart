import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.deepPurpleAccent,
          fixedSize: const Size(390, 57),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          )
      ),
      onPressed: () {},
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0XFFC925E3)),),
    );
  }
}
