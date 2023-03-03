abstract class UserException implements Exception {
  final String message;
  final int code;

  UserException({
    required this.message,
    required this.code,
  });
}

class UserDefaultException extends UserException {
  UserDefaultException({
    required super.message,
    required super.code,
  });
}

class UserNotFoundException extends UserException {
  UserNotFoundException({
    required super.message,
    required super.code,
  });
}
