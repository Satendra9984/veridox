import 'package:flutter/material.dart';

class CompletedAssignemtsPage extends StatelessWidget {
  const CompletedAssignemtsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Completed Assignments'),
      ),
      body: const Center(
        child: Text('Ho gaya complete le le'),
      ),
    );
  }
}
