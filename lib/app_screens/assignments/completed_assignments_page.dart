import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompletedAssignmentsPage extends StatefulWidget {
  const CompletedAssignmentsPage({Key? key}) : super(key: key);

  @override
  State<CompletedAssignmentsPage> createState() =>
      _CompletedAssignmentsPageState();
}

class _CompletedAssignmentsPageState extends State<CompletedAssignmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'Completed Assignments Page',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
