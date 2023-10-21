import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/deleteCreditCard.dart';
import 'package:stock_market_app/screens/modifyBalance.dart';
import 'package:stock_market_app/screens/paymentMethod.dart';
import 'package:stock_market_app/services/cardService.dart';
import 'package:stock_market_app/widgets/form/fields/dropdownInputWidget.dart';

import '../context/inheritedServices.dart';
import '../entities/cardEntity.dart';
import '../services/walletService.dart';
import '../widgets/form/formWidget.dart';

class SavedCreditCards extends StatefulWidget {
  SavedCreditCards({Key? key, required int amount})
      : _amount = amount,
        super(key: key);

  int _amount;

  @override
  State<SavedCreditCards> createState() => _SavedCreditCardsState();
}

class _SavedCreditCardsState extends State<SavedCreditCards> {
  Future<List<String>?>? _cardList;

  GlobalKey<FormState> _cardDetailsForm = GlobalKey<FormState>();

  _creditAccount(WalletService walletService) async {
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
    double screenWidth = MediaQuery.of(context).size.width;
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
                        Navigator.push(
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
                    Text('Your cards',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    DropdownInputWidget(
                      items: cardList.data!,
                      label: 'Select a card',
                    )
                  ],
                  onPressed: () {
                    _creditAccount(inheritedServices.walletService);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModifyBalance()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DeleteCreditCard(amount: widget._amount)));
              },
            ),
          );
        }));
  }
}
