class RestClientException implements Exception {
  final String message;
  final int code;

  RestClientException({
    required this.message,
    required this.code,
  });
}