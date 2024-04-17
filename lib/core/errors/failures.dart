abstract class Failure {
  final String message;
  final String statusCode;

  Failure({
    required this.message,
    required this.statusCode,
  });
}
