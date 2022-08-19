import 'package:flutter/material.dart';
import 'package:veridox/app_utils/app_constants.dart';

class CustomTextInput extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool password;
  final Function(String? value) validator;

  const CustomTextInput({
    Key? key,
    required this.text,
    required this.keyboardType,
    required this.password,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: kBorderRadius,
      ),
      elevation: kElevation,
      child: TextFormField(
        controller: controller,
        style:
            const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(
              color: Colors.black45, fontWeight: FontWeight.w600),
          fillColor: Colors.white,
          focusColor: Colors.black26,
          filled: true,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(kBRad)),
            borderSide: BorderSide(width: 2, color: Colors.lightBlue),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(kBRad)),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        keyboardType: keyboardType,
        obscureText: password,
        validator: (value) => validator(value),
      ),
    );
  }
}
