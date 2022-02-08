import 'package:flutter/material.dart';
import 'package:veridox/models/assignment_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: assignments.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) => Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(assignments[index].caseId),
                  Text(assignments[index].description),
                  Text(assignments[index].address),
                  Text(assignments[index].type),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
