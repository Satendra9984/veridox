import 'package:flutter/cupertino.dart';

class SavedAssignment {
  final String caseId;
  final String type;
  // final String applicant_address;
  String status;
  final String assignedDate;
  final String applicant_phone;
  final String applicant_name;
  // final Map<String, dynamic>? formData;

  Map<String, dynamic> toJson() {
    return {
      'caseId': caseId,
      'document_type': type,
      // 'applicant_address': applicant_address,
      'status': status,
      'assigned_at': assignedDate,
      'applicant_name': applicant_name,
      'applicant_phone': applicant_phone,
      // 'report_data': formData
    };
  }

  factory SavedAssignment.fromJson(
      Map<String, dynamic> jsonData, String caseId) {
    debugPrint('received saved assignment --> ${jsonData}\n\n');

    return SavedAssignment(
      caseId: caseId,
      applicant_phone: jsonData['applicant_phone'] ?? '',
      applicant_name: jsonData['applicant_name'] ?? '',
      // applicant_address: jsonData['applicant_address'] ?? '',
      assignedDate: jsonData['assigned_at'] ?? '',
      type: jsonData['document_type'] ?? '',
      status: jsonData['status'] ?? 'working',
      // formData: formData ?? {},
    );
  }

  SavedAssignment({
    // required this.applicant_address,
    required this.caseId,
    required this.type,
    required this.status,
    required this.assignedDate,
    required this.applicant_phone,
    required this.applicant_name,
    // required this.formData,
  });
}
