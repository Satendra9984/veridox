import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:veridox/models/assignment_model.dart';

class AssignmentProvider extends ChangeNotifier {
  List<AssignmentModel> _tasks = [
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
    AssignmentModel(
        address: 'xyz',
        caseId: 'sbi123456',
        description: 'description',
        type: 'type'),
  ];

  List<AssignmentModel> get tasks {
    return [..._tasks];
  }

  List<AssignmentModel> get oldFirstTasks {
    List<AssignmentModel> oldFirstList = [..._tasks];
    oldFirstList.sort((a, b) => b.assignedDate.compareTo(a.assignedDate));

    return oldFirstList;
  }
}
