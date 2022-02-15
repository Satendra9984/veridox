import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:veridox/models/assignment_model.dart';

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
        type: 'Car Loan'),
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Bike Loan'),
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Education Loan'),
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
    AssignmentModel(
        address: '26A Iiit kalyani, West Bengal',
        caseId: 'sbi123456',
        description: 'description',
        type: 'Business Loan'),
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
