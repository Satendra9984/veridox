import 'package:flutter/material.dart';

import '../app_utils/app_constants.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.text,
    required this.onPress,
    this.icon,
  }) : super(key: key);
  final String text;
  final Function onPress;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: const Color(0XFF0e4a86),
        onPrimary: Colors.white,
        fixedSize: const Size(390, 57),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: kBorderRadius,
        ),
      ),
      onPressed: () {
        onPress();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(
            width: 12,
          ),
          icon ?? Container()
        ],
      ),
    );
  }
}
