class SymbolError implements Exception {
  final String message;

  const SymbolError([this.message = '']);

  String toString() => 'FormatException: $message';
}