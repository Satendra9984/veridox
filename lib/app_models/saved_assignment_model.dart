import 'package:flutter/cupertino.dart';

class SavedAssignment {
  final String caseId;
  final String type;
  final String description;
  final String address;
  final String status;
  final DateTime assignedDate;
  Map<String, dynamic> formData;

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

  factory SavedAssignment.fromJson(
      Map<String, dynamic> jsonData, Map<String, dynamic> formData) {
    return SavedAssignment(
      address: jsonData['address'],
      caseId: jsonData['caseId'],
      assignedDate: DateTime.parse(
        jsonData['assignedDate'].toDate().toString(),
      ),
      type: jsonData['type'],
      description: jsonData['description'],
      formData: formData,
    );
  }

  SavedAssignment(
      {required this.address,
      required this.caseId,
      required this.description,
      required this.type,
      this.status = 'working',
      required this.assignedDate,
      required this.formData});
}
