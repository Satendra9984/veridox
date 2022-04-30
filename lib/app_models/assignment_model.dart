import 'package:veridox/app_utils/constants.dart';
import 'package:flutter/material.dart';

class Assignment {
  final String caseId;
  final String type;
  final String description;
  final String address;
  final String status;
  final DateTime assignedDate;

  Map<String, dynamic> toJson() {
    return {
      'caseId': caseId,
      'type': type,
      'description': description,
      'address': address,
      'status': status,
      'assignedDate': assignedDate.toString()
    };
  }

  factory Assignment.fromJson(Map<String, dynamic> jsonData) {
    return Assignment(
      address: jsonData['address'],
      caseId: jsonData['caseId'],
      assignedDate: DateTime.parse(
        jsonData['assignedDate'].toDate().toString(),
      ),
      type: jsonData['type'],
      description: jsonData['description'],
    );
  }

  Assignment({
    required this.address,
    required this.caseId,
    required this.description,
    required this.type,
    this.status = 'active',
    required this.assignedDate,
  });
}
