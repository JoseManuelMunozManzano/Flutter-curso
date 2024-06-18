class ConnectionTimeout implements Exception {}
class WrongCredentials implements Exception {}
class InvalidToken implements Exception {}

// Error más genérico
class CustomError implements Exception {

  final String message;
  final bool loggedRequired;  // En true, se graba en un lugar persistente para logs
  // final int errorCode;

  CustomError(this.message, [this.loggedRequired = false]);
}
