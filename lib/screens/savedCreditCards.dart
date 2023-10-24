import 'package:flutter/material.dart';

import 'package:stock_market_app/screens/deleteCreditCard.dart';
import 'package:stock_market_app/screens/paymentMethod.dart';
import 'package:stock_market_app/services/cardService.dart';
import 'package:stock_market_app/widgets/form/fields/dropdownFieldWidget.dart';
import 'package:stock_market_app/context/inheritedServices.dart';
import 'package:stock_market_app/entities/cardEntity.dart';
import 'package:stock_market_app/services/walletService.dart';
import 'package:stock_market_app/widgets/form/formWidget.dart';
import 'package:stock_market_app/screens/balance.dart';

//ignore: must_be_immutable
class SavedCreditCards extends StatefulWidget {
  int _amount;

  SavedCreditCards({Key? key, required int amount})
      : _amount = amount,
        super(key: key);

  @override
  State<SavedCreditCards> createState() => _SavedCreditCardsState();
}

class _SavedCreditCardsState extends State<SavedCreditCards> {
  Future<List<String>?>? _cardList;
  GlobalKey<FormState> _cardDetailsForm = GlobalKey<FormState>();

  Future<void> _creditAccount(WalletService walletService) async {
    await walletService.creditWalletBalanceWithInt(widget._amount);
  }

  Future<List<String>?> _getAllCards(CardService cardService) async {
    List<String> cardNameList = [];
    List<CardEntity>? cardList = await cardService.getAllCards();
    for (CardEntity card in cardList!) {
      cardNameList.add(card.label);
    }
    return cardNameList;
  }

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    var inheritedServices = InheritedServices.of(context);

    _cardList = _getAllCards(inheritedServices.cardService);

    return FutureBuilder<List<String>?>(
        future: _cardList,
        builder: ((context, cardList) {
          return Scaffold(
            body: Container(
                child: Column(children: [
              Container(height: screenHeight * 0.07),
              Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                      color: Colors.white,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PaymentMethod(amount: widget._amount)));
                      })),
              Container(height: screenHeight * 0.23),
              if (cardList.hasData) ...[
                FormWidget(
                  key: _cardDetailsForm,
                  fields: [
                    Text('Select a card',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    DropdownFieldWidget(
                      items: cardList.data!,
                      label: 'Select a card',
                    )
                  ],
                  onPressed: () async {
                    await _creditAccount(inheritedServices.walletService);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Balance()));
                  },
                ),
              ] else if (cardList.hasError) ...[
                Text("Something went wrong, we can't load your cards",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 15))
              ] else ...[
                const CircularProgressIndicator()
              ]
            ])),
            floatingActionButton: FloatingActionButton.extended(
              heroTag: 'delete-credit-card',
              foregroundColor: Colors.red,
              backgroundColor: Colors.white,
              label: Text('Delete card'),
              icon: Icon(Icons.delete),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DeleteCreditCard(amount: widget._amount)));
              },
            ),
          );
        }));
  }
}
