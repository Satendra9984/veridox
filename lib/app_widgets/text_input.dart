import 'package:flutter/material.dart';
import 'package:veridox/app_utils/app_constants.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    Key? key,
    required this.text, required this.keyboardType, required this.password, required this.controller
  }) : super(key: key);
  final String text;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool password;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: kBorderRadius,
      ),
      elevation: kElevation,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(color: Colors.black45, fontWeight: FontWeight.w600),
          fillColor: Colors.white,
          focusColor: Colors.black26,
          filled: true,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(kBRad)),
            borderSide: BorderSide(width: 2, color: Color(0XFF0e4a86)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(kBRad)),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        keyboardType: keyboardType,
        obscureText: password,
      ),
    );
  }
}