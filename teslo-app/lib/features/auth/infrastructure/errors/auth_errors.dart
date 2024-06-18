class ConnectionTimeout implements Exception {}
class WrongCredentials implements Exception {}
class InvalidToken implements Exception {}

// Error más genérico
class CustomError implements Exception {

  final String message;
  final int errorCode;

  CustomError(this.message, this.errorCode);
}
