class SavedAssignment {
  final String caseId;
  final String type;
  final String address;
  String status;
  final String assignedDate;
  final String phone;
  final String name;
  final Map<String, dynamic>? formData;

  Map<String, dynamic> toJson() {
    return {
      'caseId': caseId,
      'document_type': type,
      'address': address,
      'status': status,
      'assigned_at': assignedDate,
      'name': name,
      'phone': phone,
      'report_data': formData
    };
  }

  factory SavedAssignment.fromJson(Map<String, dynamic> jsonData,
      Map<String, dynamic>? formData, String caseId) {
    return SavedAssignment(
      caseId: caseId,
      phone: jsonData['phone'] ?? '',
      name: jsonData['name'] ?? '',
      address: jsonData['address'] ?? '',
      assignedDate: jsonData['assigned_at'] ?? '',
      type: jsonData['document_type'] ?? '',
      status: jsonData['status'] ?? 'working',
      formData: formData ?? {},
    );
  }

  SavedAssignment({
    required this.address,
    required this.caseId,
    required this.type,
    required this.status,
    required this.assignedDate,
    required this.phone,
    required this.name,
    required this.formData,
  });
}
