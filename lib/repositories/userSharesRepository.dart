import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_market_app/entities/userShares.dart';
import 'package:stock_market_app/errors/userShareError.dart';

// This class is used to call the database
class UserSharesRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('userShares');

  // Gets all the user's shares (of all symbols)
  Future<List<UserShares>?> getAllUserShares() async {
    List<UserShares> userShares = [];

    try {
      await collection.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          userShares.add(UserShares.fromDBJson(
              (result.data() as Map<String, dynamic>), result.id));
        }
      });
    } catch (error) {
      throw UserSharesError(error.toString());
    }

    return userShares.length > 0 ? userShares : null;
  }

  // Returns the user's shares by the symbol from database
  Future<UserShares?> getUserShares(String symbol) async {
    UserShares? userShares;

    try {
      await collection
          .where('symbol', isEqualTo: symbol)
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          userShares = UserShares.fromDBJson(
              (result.data() as Map<String, dynamic>), result.id);
        }
      });
    } catch (error) {
      throw UserSharesError(error.toString());
    }

    return userShares;
  }

  // Adds user's shares by symbol in the database
  void incrementUserShares(int newNbShares, String id) async {
    try {
      await collection.doc(id).update({'nbShares': newNbShares});
    } catch (error) {
      throw UserSharesError(error.toString());
    }
  }

  // Creates user's shares by symbol in the database
  Future<DocumentReference> addUserShares(String symbol, int nbShares) {
    try {
      UserShares userShares = UserShares(symbol, nbShares);
      return collection.add(userShares.toJson());
    } catch (error) {
      throw UserSharesError(error.toString());
    }
  }

  // Removes user's shares by symbol in the database
  void decrementUserShares(int newNbShares, String id) async {
    try {
      await collection.doc(id).update({'nbShares': newNbShares});
    } catch (error) {
      throw UserSharesError(error.toString());
    }
  }

  // Deletes user's shares by symbol in the database
  void deleteUserShares(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (error) {
      throw UserSharesError(error.toString());
    }
  }
}