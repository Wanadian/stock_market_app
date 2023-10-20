import 'package:stock_market_app/entities/shareEntity.dart';
import 'package:stock_market_app/entities/userSharesEntity.dart';
import 'package:stock_market_app/errors/shareError.dart';
import 'package:stock_market_app/errors/userShareError.dart';
import 'package:stock_market_app/errors/walletError.dart';
import 'package:stock_market_app/repositories/userSharesRepository.dart';
import 'package:stock_market_app/services/shareService.dart';
import 'package:stock_market_app/services/walletService.dart';

// This class allows us to call the repository and avoid direct calls to the database
class UserSharesService {
  UserSharesRepository userSharesRepository = UserSharesRepository();
  ShareService shareService = ShareService();
  WalletService walletService = WalletService();

  // Returns all the user's shares
  Future<List<UserSharesEntity>?> getAllUserShares() async {
    return await userSharesRepository.getAllUserShares();
  }

  // Returns a user's shares by symbol
  Future<UserSharesEntity?> getUserShares(String symbol) async {
    return await userSharesRepository.getUserShares(symbol);
  }

  // Adds user's shares by symbol, returns true if we can add the share
  Future<bool> addUserShares(String symbol, int nbSharesToAdd) async {
    if(nbSharesToAdd > 0) {

      UserSharesEntity? userShare = await this.getUserShares(symbol);
      ShareEntity? share = await shareService.getLatestShare(symbol);
      String? balance = await walletService.getWalletBalanceAsString();

      if (share == null) {
        throw ShareError('Share not found');
      }

      if (balance == null) {
        throw WalletError('Wallet balance not found');
      }

      if (((double.parse(balance) - share.price * nbSharesToAdd) < 0) || share.nbShares - nbSharesToAdd < 0) {
        return false;
      }

      if (userShare != null && userShare.id != null) {
        await userSharesRepository.incrementUserShares(
            userShare.nbShares + nbSharesToAdd, userShare.id ?? '');
      } else {
        await userSharesRepository.addUserShares(symbol, nbSharesToAdd);
      }

      await shareService.removeNbShares(symbol, nbSharesToAdd);
      await walletService.debitWalletBalance(share.price * nbSharesToAdd);
      return true;
    }

    return false;
  }

  // Removes user's shares by symbol
  Future<void> removeUserShares(String symbol, int nbSharesToRemove) async {
    if(nbSharesToRemove > 0) {

      UserSharesEntity? userShare = await this.getUserShares(symbol);
      ShareEntity? share = await shareService.getLatestShare(symbol);

      if (share == null) {
        throw ShareError('Share not found');
      }

      if (userShare != null && userShare.id != null) {
        int newNbShares = userShare.nbShares - nbSharesToRemove;

        if (newNbShares > 0) {
          await userSharesRepository.decrementUserShares(userShare.nbShares - nbSharesToRemove, userShare.id ?? '');
          await shareService.addNbShares(symbol, nbSharesToRemove);
          await walletService.creditWalletBalanceWithDouble(share.price * nbSharesToRemove);
        } else {
          await userSharesRepository.deleteUserShares(userShare.id ?? '');
          await shareService.addNbShares(symbol, userShare.nbShares);
          await walletService.creditWalletBalanceWithDouble(share.price * userShare.nbShares);
        }

      } else {
        throw UserSharesError('No share with the symbol $symbol in the wallet');
      }
    }
  }

  // Gets the number of user's shares (of a symbol)
  Future<int?> getUserNbShares(String symbol) async {
    return (await userSharesRepository.getUserShares(symbol))?.nbShares;
  }

  // Returns the balance's estimation of the global user's shares (with all the symbols and shares)
  Future<double> getUserSharesBalanceEstimation(Map<String, double> sharesPrices) async {
    double balance = 0;

    List<UserSharesEntity>? allUserShares =
        await userSharesRepository.getAllUserShares();

    if (allUserShares != null) {
      for (var userShares in allUserShares) {
        balance += userShares.nbShares * sharesPrices[userShares.symbol]!;
      }
    }

    return balance;
  }
}
