// This class allows us to call the repository and avoid direct calls to the database
import 'package:stock_market_app/entities/cardEntity.dart';
import 'package:stock_market_app/errors/cardError.dart';
import 'package:stock_market_app/repositories/cardRepository.dart';

class CardService {
  CardRepository cardRepository = CardRepository();

  // Gets the wallet balance value
  Future<List<CardEntity>?> getAllCards() async {
    return await cardRepository.getAllCards();
  }

  // Gets card with its unique label
  Future<CardEntity?> getCard(String label) async {
    return await cardRepository.getCard(label);
  }

  Future<void> addCard(String label, String holderName, int number,
      int safeCode, DateTime expirationDate) async {

    if (await cardRepository.getCard(label) != null) {
      throw CardError('The label: $label is already used');
    }

    await cardRepository.addCard(
        label, holderName, number, safeCode, expirationDate);
  }

  Future<void> updateLabel(String label, String newLabel) async {
    if (await cardRepository.getCard(newLabel) != null) {
      throw CardError('The label: $newLabel is already used');
    }

    CardEntity? card = await cardRepository.getCard(label);

    if (card != null && card.id != null) {
      await cardRepository.updateCardLabel(newLabel, card.id ?? '');
    } else {
      throw CardError('Card with label: $label not found');
    }
  }

  Future<void> deleteCard(String label) async {
    CardEntity? card = await cardRepository.getCard(label);

    if (card != null && card.id != null) {
      await cardRepository.deleteCard(card.id ?? '');
    } else {
      throw CardError('Card with label: $label not found');
    }
  }
}
