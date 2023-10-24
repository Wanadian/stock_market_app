// This class is used to call the database
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:stock_market_app/entities/walletEntity.dart';
import 'package:stock_market_app/errors/walletError.dart';

class WalletRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('wallets');

  // Gets the wallet object
  Future<WalletEntity?> getWallet() async {
    WalletEntity? wallet;

    try {
      wallet = await collection
          .limit(1)
          .get()
          .then((querySnapshot) => WalletEntity.fromDBJson((querySnapshot.docs.first.data() as Map<String, dynamic>), querySnapshot.docs.first.id));
    } catch (error) {
      throw WalletError(error.toString());
    }

    return wallet;
  }

  // Gets the wallet balance value
  Future<String?> getWalletBalance() async {
    String? balance;

    try {
      balance = await collection
          .limit(1)
          .get()
          .then((querySnapshot) => (querySnapshot.docs.first.get('balance')).toStringAsFixed(2));
    } catch (error) {
      throw WalletError(error.toString());
    }

    return balance;
  }

  // Modifies the balance's value in the database
  Future<void> updateWalletBalance(double newWalletBalance, String id) async {
    try {
      await collection.doc(id).update({'balance': newWalletBalance});
    } catch (error) {
      throw WalletError(error.toString());
    }
  }
}
