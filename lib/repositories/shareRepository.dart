import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_market_app/entities/share.dart';
import 'package:stock_market_app/errors/shareError.dart';

// This class is used to call the database
class ShareRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('shares');

  // Returns all the shares from the database
  Future<List<Share>?> getAllShares() async {
    List<Share> allShares = [];

    try {
      await collection.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          allShares
              .add(Share.fromDBJson(result.data() as Map<String, dynamic>, result.id));
        }
      });
    } catch (error) {
      throw ShareError(error.toString());
    }

    return allShares.length > 0 ? allShares : null;
  }

  // Returns all the shares price for an unique symbol from the database
  Future<List<Share>?> getSymbolSharesPrices(String symbol) async {
    List<Share> allShares = [];

    try {
      await collection
          .where('symbol', isEqualTo: symbol)
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          allShares
              .add(Share.fromDBJson(result.data() as Map<String, dynamic>, result.id));
        }
      });
    } catch (error) {
      throw ShareError(error.toString());
    }

    return allShares.length > 0 ? allShares : null;
  }

  // Returns the latest shares for all symbol
  Future<List<Share>?> getLatestShares(List<String> symbols) async {
    List<Share>? latestShares;

    try {
      latestShares = [];

      symbols.forEach((symbol) async {
        var latestShare = await collection
            .where('symbol', isEqualTo: symbol)
            .orderBy('latestTradingDay', descending: true)
            .limit(1)
            .get()
            .then((snapshot) =>
              snapshot.docs
                  .map((doc) => Share.fromDBJson(doc.data() as Map<String, dynamic>, doc.id))
                  .first
            );

        latestShares?.add(latestShare);
      });
    } catch (error) {
      throw ShareError(error.toString());
    }

    return latestShares;
  }

  // Returns the latest share for a symbol
  Future<Share?> getLatestShare(String symbol) async {
    Share? latestShare;

    try {
      latestShare = await collection
          .where('symbol', isEqualTo: symbol)
          .orderBy('latestTradingDay', descending: true)
          .limit(1)
          .get()
          .then((snapshot) =>
            snapshot.docs
            .map((doc) => Share.fromDBJson(doc.data() as Map<String, dynamic>, doc.id))
            .first
          );
    } catch (error) {
      throw ShareError(error.toString());
    }

    return latestShare;
  }

  // Adds a share in the database
  Future<DocumentReference> addShare(Share share) {
    return collection.add(share.toJson());
  }

  // Gets the latest refresh day from the database
  Future<DateTime?> getLatestRefreshDate() async {
    Timestamp? latestRefreshDay = await collection
        // Order by date in descending order
        .orderBy('latestRefreshDay', descending: true)
        // Limit to the first (latest) element
        .limit(1)
        .get()
        .then((querySnapshot) => querySnapshot.docs.first.get('latestRefreshDay'));

    return latestRefreshDay?.toDate();
  }
  
  Future<bool> emptyDBShares() async {
    return await collection.get().then((snapshot) => {
      for (DocumentSnapshot ds in snapshot.docs){
          ds.reference.delete()
      }
    }).then((value) => true);
  }

  // Adds number shares by symbol in the database
  Future<void> incrementNbShares(int newNbShares, String id) async {
    try {
      await collection.doc(id).update({'nbShares': newNbShares});
    } catch (error) {
      throw ShareError(error.toString());
    }
  }

  // Removes shares by symbol in the database
  Future<void> decrementNbShares(int newNbShares, String id) async {
    try {
      await collection.doc(id).update({'nbShares': newNbShares});
    } catch (error) {
      throw ShareError(error.toString());
    }
  }
}
