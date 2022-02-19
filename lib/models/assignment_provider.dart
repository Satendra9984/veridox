import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:veridox/models/assignment_model.dart';

import '../constants.dart';

class AssignmentProvider extends ChangeNotifier {
  final List<AssignmentModel> _tasks = [
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Home Loan'),
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Car Loan',
        status: Status.saved),
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Bike Loan'),
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Education Loan',
        status: Status.saved),
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Business Loan'),
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Business Loan'),
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Business Loan',
        status: Status.saved),
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Business Loan'),
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Business Loan',
        status: Status.saved),
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Business Loan'),
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Business Loan'),
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Business Loan'),
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Business Loan'),
  ];

  List<AssignmentModel> get tasks {
    return [..._tasks];
  }

  List<AssignmentModel> get savedAssignment {
    return _tasks.where((element) => element.status == Status.saved).toList();
  }

  List<AssignmentModel> get oldFirstTasks {
    List<AssignmentModel> oldFirstList = [..._tasks];
    oldFirstList.sort((a, b) => b.assignedDate.compareTo(a.assignedDate));

    return oldFirstList;
  }

  void addSaveAssignment() {
    // TODO: ADD A METHOD TO ADD IN SAVE ASSIGNMENTS
  }
}
