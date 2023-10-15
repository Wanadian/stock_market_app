// This class is used to call the database
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_market_app/entities/cardEntity.dart';
import 'package:stock_market_app/errors/cardError.dart';

class CardRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('cards');

  // Gets all the cards object
  Future<List<CardEntity>?> getAllCards() async {
    List<CardEntity> cards = [];

    try {
      await collection.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          cards.add(CardEntity.fromDBJson(
              (result.data() as Map<String, dynamic>), result.id));
        }
      });
    } catch (error) {
      throw CardError(error.toString());
    }

    return cards;
  }

  // Gets card object with its unique label
  Future<CardEntity?> getCard(String label) async {
    CardEntity? card;

    try {
      card = await collection
          .where('label', isEqualTo: label)
          .limit(1)
          .get()
          .then((querySnapshot) => querySnapshot.docs.isNotEmpty
              ? CardEntity.fromDBJson(
                  (querySnapshot.docs.first.data() as Map<String, dynamic>),
                  querySnapshot.docs.first.id)
              : null);
    } catch (error) {
      throw CardError(error.toString());
    }

    return card;
  }

  // Creates user's card in the database
  Future<void> addCard(String label, String holderName, int number,
      int safeCode, DateTime expirationDate) {
    try {
      CardEntity card =
          CardEntity(label, holderName, number, safeCode, expirationDate);
      return collection.add(card.toJson());
    } catch (error) {
      throw CardError(error.toString());
    }
  }

  // Modifies card label
  Future<void> updateCardLabel(String newLabel, String id) async {
    try {
      await collection.doc(id).update({'label': newLabel});
    } catch (error) {
      throw CardError(error.toString());
    }
  }

  // Deletes user's card in the database
  Future<void> deleteCard(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (error) {
      throw CardError(error.toString());
    }
  }
}
