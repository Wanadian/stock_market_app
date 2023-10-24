// This class manages the Symbol Exception
class SymbolError implements Exception {
  final String message;

  const SymbolError([this.message = '']);

  String toString() => 'FormatException: $message';
}