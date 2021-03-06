/// Assignment Model for the basic details of the assignment
class Assignment {
  final String caseId;
  final String type;
  final String address;
  final String status;
  final String assignedDate;
  final String phone;
  final String name;

  Map<String, dynamic> toJson() {
    return {
      'caseId': caseId,
      'document_type': type,
      'address': address,
      'status': status,
      'assigned_to': assignedDate,
      'name': name
    };
  }

  factory Assignment.fromJson(Map<String, dynamic> jsonData, String caseId) {
    return Assignment(
      caseId: caseId,
      phone: jsonData['phone'],
      name: jsonData['name'],
      address: jsonData['address'],
      assignedDate: jsonData['assigned_at'],
      type: jsonData['document_type'],
      status: jsonData['status'],
    );
  }

  Assignment({
    required this.address,
    required this.caseId,
    // required this.description,
    required this.type,
    required this.status,
    required this.assignedDate,
    required this.phone,
    required this.name,
  });
}
