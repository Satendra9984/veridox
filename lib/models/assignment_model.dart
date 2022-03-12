import 'package:veridox/constants.dart';
import 'package:flutter/material.dart';

class AssignmentModel with ChangeNotifier {
  final String caseId;
  final String type;
  final String description;
  final String address;
  final Status status;
  final DateTime assignedDate;

  AssignmentModel({
    required this.address,
    required this.caseId,
    required this.description,
    required this.type,
    this.status = Status.active,
    required this.assignedDate,
  });
}
