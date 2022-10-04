class FormResponse {
  final String id;
  final String name;
  final Map<String, dynamic> data;
  final String createdBy;
  final String createdAt;

  FormResponse(
      {required this.name,
      required this.id,
      required this.data,
      required this.createdBy,
      required this.createdAt});
}
