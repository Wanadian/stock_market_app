class UserSharesError implements Exception {
  final String message;

  const UserSharesError([this.message = '']);

  String toString() => 'FormatException: $message';
}