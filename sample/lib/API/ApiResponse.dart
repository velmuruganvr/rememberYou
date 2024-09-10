class ApiResponse {
  final bool success;
  final String message;
  final dynamic? responseBody;

  ApiResponse({
    required this.success,
    required this.message,
    this.responseBody,
  });
}