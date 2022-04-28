import 'package:flutter/cupertino.dart';

import '../app_utils/constants.dart';

class SavedAssignment with ChangeNotifier {
  final String caseId;
  final String type;
  final String description;
  final String address;
  final Status status;
  final DateTime assignedDate;
  final Map<String, dynamic> json;

  SavedAssignment(
      {required this.address,
      required this.caseId,
      required this.description,
      required this.type,
      this.status = Status.active,
      required this.assignedDate,
      required this.json});
}
