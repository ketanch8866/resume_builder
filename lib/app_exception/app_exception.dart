class AppException implements Exception {
  final message;
  final prefix;
  AppException([this.message, this.prefix]);
  @override
  String toString() {
    return '$message $prefix';
  }
}

class InternetException extends AppException {
  InternetException(String message) : super(message, "No Internet connection");
}

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(message, "Something went wrong while fatching data");
}

class InvalidInputDataException extends AppException {
  InvalidInputDataException(String message)
      : super(message, "Input wrong data");
}
