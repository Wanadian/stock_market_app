import 'package:stock_market_app/entities/userSharesEntity.dart';
import 'package:stock_market_app/errors/userShareError.dart';
import 'package:stock_market_app/repositories/userSharesRepository.dart';
import 'package:stock_market_app/services/shareService.dart';

// This class allows us to call the repository and a Future<dynamic> direct calls to the database
class UserSharesService {
  UserSharesRepository userSharesRepository = UserSharesRepository();
  ShareService shareService = ShareService();

  // Returns all the user's shares
  Future<List<UserSharesEntity>?> getAllUserShares() async {
    return await userSharesRepository.getAllUserShares();
  }

  // Returns a user's shares by symbol
  Future<UserSharesEntity?> getUserShares(String symbol) async {
    return await userSharesRepository.getUserShares(symbol);
  }

  // Adds user's shares by symbol
  Future<void> addUserShares(String symbol, int nbSharesToAdd) async {
    UserSharesEntity? userShare = await this.getUserShares(symbol);

    if (userShare != null && userShare.id != null) {
      userSharesRepository.incrementUserShares(
          userShare.nbShares + nbSharesToAdd, userShare.id ?? '');
    } else {
      userSharesRepository.addUserShares(symbol, nbSharesToAdd);
    }

    await shareService.removeNbShares(symbol, nbSharesToAdd);
  }

  // Removes user's shares by symbol
  Future<void> removeUserShares(String symbol, int nbSharesToAdd) async {
    UserSharesEntity? userShare = await this.getUserShares(symbol);

    if (userShare != null && userShare.id != null) {
      int newNbShares = userShare.nbShares - nbSharesToAdd;
      if (newNbShares >= 0) {
        userSharesRepository.decrementUserShares(
            userShare.nbShares - nbSharesToAdd, userShare.id ?? '');
      } else {
        userSharesRepository.deleteUserShares(userShare.id ?? '');
      }
    } else {
      throw UserSharesError('No share with the symbol $symbol in the wallet');
    }

    await shareService.addNbShares(symbol, nbSharesToAdd);
  }

  // Gets the number of user's shares (of a symbol)
  Future<int?> getUserNbShares(String symbol) async {
    return (await userSharesRepository.getUserShares(symbol))?.nbShares;
  }

  // Returns the balance of the global user's shares (with all the symbols and shares)
  Future<double> getUserSharesBalance(Map<String, double> sharesPrices) async {
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
