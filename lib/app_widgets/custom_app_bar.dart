import 'package:flutter/material.dart';

AppBar customAppBar({String label = ''}) {
  return AppBar(
    elevation: 0.5,
    centerTitle: true,
    toolbarHeight: 50.0,
    backgroundColor: const Color(0xFFecf8ff),
    title: Text(
      label,
      style: const TextStyle(
        color: Color(0XFF0e4a86),
        fontSize: 18,
      ),
    ),
  );
}
