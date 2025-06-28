class AppException implements Exception {
  AppException({
    this.message = 'Something went wrong.',
    this.code = '',
    Map<String, dynamic>? extra,
  }) {
    if (extra != null) {
      this.extra.addAll(extra);
    }
  }

  final String message;
  final String code;
  final Map<String, dynamic> extra = {};

  @override
  String toString() {
    return 'AppException(message: $message, code: $code, extra: $extra)';
  }
}
