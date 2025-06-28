class NoInternetException implements Exception {
  NoInternetException([this.message = 'No internet connection']);

  final String message;

  @override
  String toString() => message;
}
