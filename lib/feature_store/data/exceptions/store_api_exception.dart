class StoreApiException implements Exception {
  final String message;

  StoreApiException(this.message);

  @override
  String toString() {
    return 'StoreApiException: $message';
  }
}