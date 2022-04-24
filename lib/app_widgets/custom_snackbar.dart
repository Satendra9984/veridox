import 'package:flutter/material.dart';

class CustomSnackBar {
  void showSnackBar(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(snackBar);
  }
}