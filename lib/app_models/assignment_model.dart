import 'package:veridox/app_utils/constants.dart';
import 'package:flutter/material.dart';

class Assignment with ChangeNotifier {
  final String caseId;
  final String type;
  final String description;
  final String address;
  final Status status;
  final DateTime assignedDate;

  Assignment({
    required this.address,
    required this.caseId,
    required this.description,
    required this.type,
    this.status = Status.active,
    required this.assignedDate,
  });
}
