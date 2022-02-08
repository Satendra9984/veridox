import 'package:veridox/models/constants.dart';

class AssignmentModel {
  final String caseId;
  final String type;
  final String description;
  final String address;
  final Status status;

  AssignmentModel(
      {required this.address,
      required this.caseId,
      required this.description,
      required this.type,
      this.status = Status.active});
}
