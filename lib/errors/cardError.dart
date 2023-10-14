// This class manages the Card Exception
class CardError implements Exception {
  final String message;

  const CardError([this.message = '']);

  String toString() => 'FormatException: $message';
}