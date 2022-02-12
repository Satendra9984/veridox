import 'package:flutter/material.dart';

class CustomSnackBar {
  void _showSnackBar(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}