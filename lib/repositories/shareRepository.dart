import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_market_app/entities/shareEntity.dart';
import 'package:stock_market_app/errors/shareError.dart';

// This class is used to call the database
class ShareRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('shares');

  // Returns all the shares from the database
  Future<List<ShareEntity>?> getAllShares() async {
    List<ShareEntity> allShares = [];

    try {
      await collection.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          allShares
              .add(ShareEntity.fromDBJson(result.data() as Map<String, dynamic>, result.id));
        }
      });
    } catch (error) {
      throw ShareError(error.toString());
    }

    return allShares.length > 0 ? allShares : null;
  }

  // Returns all the shares price for an unique symbol from the database
  Future<List<ShareEntity>?> getSymbolSharesPrices(String symbol) async {
    List<ShareEntity> allShares = [];

    try {
      await collection
          .where('symbol', isEqualTo: symbol)
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          allShares
              .add(ShareEntity.fromDBJson(result.data() as Map<String, dynamic>, result.id));
        }
      });
    } catch (error) {
      throw ShareError(error.toString());
    }

    return allShares.length > 0 ? allShares : null;
  }

  // Returns the latest shares for all symbol
  Future<List<ShareEntity>?> getLatestShares(List<String> symbols) async {
    List<ShareEntity>? latestShares;

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
                  .map((doc) => ShareEntity.fromDBJson(doc.data() as Map<String, dynamic>, doc.id))
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
  Future<ShareEntity?> getLatestShare(String symbol) async {
    ShareEntity? latestShare;

    try {
      latestShare = await collection
          .where('symbol', isEqualTo: symbol)
          .orderBy('latestTradingDay', descending: true)
          .limit(1)
          .get()
          .then((snapshot) =>
            snapshot.docs
            .map((doc) => ShareEntity.fromDBJson(doc.data() as Map<String, dynamic>, doc.id))
            .first
          );
    } catch (error) {
      throw ShareError(error.toString());
    }

    return latestShare;
  }

  // Returns the variation in percent of the price between the two latest shares
  Future<double?> getPriceDifference(String symbol) async {
    List<ShareEntity> shares = [];

    try {
      return await collection
          .where('symbol', isEqualTo: symbol)
          .orderBy('latestTradingDay', descending: true)
          .limit(2)
          .get()
          .then((snapshot) => {
            for (var result in snapshot.docs) {
              shares.add(ShareEntity.fromDBJson((result.data() as Map<String, dynamic>), result.id))
            }
          }).then((_) =>
            shares.length == 2 ? (((shares[0].price * 100) / shares[1].price) - 100) : null
          );
    } catch (error) {
      throw ShareError(error.toString());
    }
  }

  // Adds a share in the database
  Future<DocumentReference> addShare(ShareEntity share) {
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
