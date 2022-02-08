import 'package:flutter/material.dart';

class AssignmentsHomePage extends StatelessWidget {
  static String assignmentsHomePage = 'assignmentHomePage';
  const AssignmentsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
      ),
      body: Container(
        child: const Text('Ass home page'),
      ),
    );
  }
}
