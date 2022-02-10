import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:veridox/models/assignment_model.dart';

import 'assignment_list.dart';

class AssignmentsHomePage extends StatelessWidget {
  static String assignmentsHomePage = 'assignmentHomePage';
  AssignmentsHomePage({Key? key}) : super(key: key);

  List<AssignmentModel> assignments = [
    AssignmentModel(
        address: 'xyz',
        caseId: 'sbi123456',
        description: 'description',
        type: 'type'),
    AssignmentModel(
        address: 'xyz',
        caseId: 'sbi123456',
        description: 'description',
        type: 'type'),
    AssignmentModel(
        address: 'xyz',
        caseId: 'sbi123456',
        description: 'description',
        type: 'type'),
    AssignmentModel(
        address: 'xyz',
        caseId: 'sbi123456',
        description: 'description',
        type: 'type'),
    AssignmentModel(
        address: 'xyz',
        caseId: 'sbi123456',
        description: 'description',
        type: 'type'),
    AssignmentModel(
        address: 'xyz',
        caseId: 'sbi123456',
        description: 'description',
        type: 'type'),
    AssignmentModel(
        address: 'xyz',
        caseId: 'sbi123456',
        description: 'description',
        type: 'type'),
    AssignmentModel(
        address: 'xyz',
        caseId: 'sbi123456',
        description: 'description',
        type: 'type'),
    AssignmentModel(
        address: 'xyz',
        caseId: 'sbi123456',
        description: 'description',
        type: 'type'),
    AssignmentModel(
        address: 'xyz',
        caseId: 'sbi123456',
        description: 'description',
        type: 'type'),
    AssignmentModel(
        address: 'xyz',
        caseId: 'sbi123456',
        description: 'description',
        type: 'type'),
  ];

  // final User = context.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
      ),
      body: AssignmentList(),
      // bottom navigation bar
    );
  }
}
