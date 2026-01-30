class TtsException implements Exception {
  final String message;
  final dynamic originalError;

  TtsException(this.message, [this.originalError]);

  @override
  String toString() =>
      'TtsException: $message${originalError != null ? " ($originalError)" : ""}';
}
