import 'package:veridox/models/constants.dart';

class AssignmentDescription {
  final String caseId;
  final String type;
  final String description;
  final String address;
  final Status status;

  AssignmentDescription(
      {required this.address,
      required this.caseId,
      required this.description,
      required this.type,
      this.status = Status.active});
}
