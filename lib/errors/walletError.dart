// This class manages the Wallet Exception
class WalletError implements Exception {
  final String message;

  const WalletError([this.message = '']);

  String toString() => 'FormatException: $message';
}