class FineoApiException implements Exception {
  final int? statusCode;
  final String message;
  final dynamic data;

  FineoApiException(this.message, {this.statusCode, this.data});

  @override
  String toString() =>
      'FineoApiException(statusCode=$statusCode, message=$message, data=$data)';
}
