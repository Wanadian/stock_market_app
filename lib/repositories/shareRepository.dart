import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_market_app/entities/share.dart';
import 'package:stock_market_app/errors/shareError.dart';

// This class is used to call the database
class ShareRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('shares');

  // Returns all the shares from the database
  Future<List<Share>?> getShares() async {
    List<Share> allShares = [];

    try {
      await collection.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          allShares
              .add(Share.fromDBJson(result.data() as Map<String, dynamic>));
        }
      });
    } catch (error) {
      throw ShareError(error.toString());
    }

    return allShares.length > 0 ? allShares : null;
  }

  // Adds a share in the database
  Future<DocumentReference> addShare(Share share) {
    return collection.add(share.toJson());
  }

  // Gets the latest refresh day from the database
  Future<DateTime?> getLatestRefreshDate() async {
    QuerySnapshot querySnapshot = await collection
        // Order by date in descending order
        .orderBy('latestRefreshDay', descending: true)
        // Limit to the first (latest) element
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      Timestamp latestRefreshDay =
          querySnapshot.docs.first.get('latestRefreshDay');
      return latestRefreshDay.toDate();
    }

    return null;
  }
}
