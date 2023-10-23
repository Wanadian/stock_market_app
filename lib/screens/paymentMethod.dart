import 'package:flutter/material.dart';

import 'package:stock_market_app/screens/modifyBalance.dart';
import 'package:stock_market_app/screens/newCreditCard.dart';
import 'package:stock_market_app/screens/savedCreditCards.dart';
import 'package:stock_market_app/services/cardService.dart';
import 'package:stock_market_app/widgets/buttonWidget.dart';
import 'package:stock_market_app/context/inheritedServices.dart';
import 'package:stock_market_app/entities/cardEntity.dart';

//ignore: must_be_immutable
class PaymentMethod extends StatefulWidget {
  int _amount;

  PaymentMethod({Key? key, required int amount})
      : _amount = amount,
        super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  Future<List<CardEntity>?>? _cardList;

  Future<List<CardEntity>?> _getAllCards(CardService cardService) async {
    return await cardService.getAllCards();
  }

  Function()? _getSavedCardsOnPressed(List<CardEntity>? cardList) {
    if (_cardList == null) {
      return null;
    }
    return cardList!.isEmpty
        ? null
        : () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SavedCreditCards(amount: widget._amount)));
          };
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var inheritedServices = InheritedServices.of(context);

    _cardList = _getAllCards(inheritedServices.cardService);

    return FutureBuilder<List<CardEntity>?>(
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
                              builder: (context) => ModifyBalance()));
                    })),
            Container(height: screenHeight * 0.23),
            if (cardList.hasData) ...[
              Column(children: [
                ButtonWidget.textButton(
                    label: 'Add new card',
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewCreditCard(amount: widget._amount)));
                    },
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.8),
                Container(height: screenHeight * 0.05),
                ButtonWidget.textButton(
                    label: 'Use saved card',
                    onPressed: _getSavedCardsOnPressed(cardList.data),
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.8)
              ])
            ] else if (cardList.hasError) ...[
              Text("Something went wrong, we can't load your cards",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 15))
            ] else ...[
              const CircularProgressIndicator()
            ]
          ])));
        }));
  }
}
