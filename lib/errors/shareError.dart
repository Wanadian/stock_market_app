class ShareError implements Exception {
  final String message;

  const ShareError([this.message = '']);

  String toString() => 'FormatException: $message';
}