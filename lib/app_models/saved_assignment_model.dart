class SavedAssignment {
  final String caseId;
  final String type;
  String status;
  final String assignedDate;
  final String applicant_phone;
  final String applicant_name;

  Map<String, dynamic> toJson() {
    return {
      'caseId': caseId,
      'document_type': type,
      'status': status,
      'assigned_at': assignedDate,
      'applicant_name': applicant_name,
      'applicant_phone': applicant_phone,
    };
  }

  factory SavedAssignment.fromJson(
      Map<String, dynamic> jsonData, String caseId) {
    return SavedAssignment(
      caseId: caseId,
      applicant_phone: jsonData['applicant_phone'] ?? '',
      applicant_name: jsonData['applicant_name'] ?? '',
      assignedDate: jsonData['assigned_at'] ?? '',
      type: jsonData['document_type'] ?? '',
      status: jsonData['status'] ?? 'working',
    );
  }

  SavedAssignment({
    required this.caseId,
    required this.type,
    required this.status,
    required this.assignedDate,
    required this.applicant_phone,
    required this.applicant_name,
  });
}
