import 'package:dio/dio.dart';

class ExceptionHandler implements Exception {
  String message;
  int? statusCode;
  ExceptionHandler({this.message = 'unknown error', this.statusCode});
  @override
  String toString() => '[$statusCode].$message}';

  static ExceptionHandler fromResponse(Response response) {
    final String message =
        response.data['message'] ?? 'An unknown error occurred.';
    final int? statusCode = response.statusCode;

    return ExceptionHandler(
      message: message,
      statusCode: statusCode,
    );
  }
}
