import 'package:flutter/material.dart';

class Page0 extends StatefulWidget {
  const Page0({Key? key}) : super(key: key);

  @override
  State<Page0> createState() => _Page0State();
}

class _Page0State extends State<Page0> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Form default page'),
        ),
      ),
    );
  }
}
