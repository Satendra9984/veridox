import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    Key? key,
    required this.text, required this.keyboardType, required this.password
  }) : super(key: key);
  final String text;
  final TextInputType keyboardType;
  final bool password;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black45, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(color: Colors.black45, fontWeight: FontWeight.w600),
        fillColor: Colors.white,
        focusColor: Colors.white,
        filled: true,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(9)),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(9)),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: password,
    );
  }
}