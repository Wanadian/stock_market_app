// This class allows us to call the repository and avoid direct calls to the database
import 'package:stock_market_app/entities/walletEntity.dart';
import 'package:stock_market_app/errors/walletError.dart';
import 'package:stock_market_app/repositories/walletRepository.dart';

class WalletService {
  WalletRepository walletRepository = WalletRepository();

  // Gets the wallet balance value in string format
  Future<String?> getWalletBalanceAsString() async {
    return await walletRepository.getWalletBalance();
  }

  // Credits wallet balance with a double value
  Future<void> creditWalletBalanceWithDouble(double sumToCredit) async {
    WalletEntity? wallet = await walletRepository.getWallet();

    if (wallet != null && wallet.id != null) {
      await walletRepository.updateWalletBalance(
          wallet.balance + sumToCredit, wallet.id ?? '');
    } else {
      throw WalletError('Wallet not found');
    }
  }

  // Credits wallet balance with an int value
  Future<void> creditWalletBalanceWithInt(int sumToCredit) async {
    WalletEntity? wallet = await walletRepository.getWallet();

    if (wallet != null && wallet.id != null) {
      await walletRepository.updateWalletBalance(
          wallet.balance + sumToCredit, wallet.id ?? '');
    } else {
      throw WalletError('Wallet not found');
    }
  }

  // Debits wallet balance value
  Future<void> debitWalletBalance(double sumToDebit) async {
    WalletEntity? wallet = await walletRepository.getWallet();

    if (wallet != null && wallet.id != null) {
      double newBalance = double.parse((wallet.balance - sumToDebit).toStringAsFixed(2));

      if(newBalance >= 0) {
        await walletRepository.updateWalletBalance(newBalance, wallet.id ?? '');
      } else {
        throw WalletError('Wallet balance can\'t be negative ');
      }

    } else {
      throw WalletError('Wallet not found');
    }
  }
}