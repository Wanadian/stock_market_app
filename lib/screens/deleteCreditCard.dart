import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/modifyBalance.dart';
import 'package:stock_market_app/screens/paymentMethod.dart';
import 'package:stock_market_app/services/cardService.dart';
import 'package:stock_market_app/widgets/form/fields/dropdownFieldWidget.dart';

import '../context/inheritedServices.dart';
import '../entities/cardEntity.dart';
import '../widgets/form/formWidget.dart';

class DeleteCreditCard extends StatefulWidget {
  int _amount;

  DeleteCreditCard({Key? key, required int amount})
      : _amount = amount,
        super(key: key);

  @override
  State<DeleteCreditCard> createState() => _DeleteCreditCardState();
}

class _DeleteCreditCardState extends State<DeleteCreditCard> {
  Future<List<String>?>? _cardList;
  String _cardToDeleteLabel = '';
  GlobalKey<FormState> _cardDetailsForm = GlobalKey<FormState>();

  void _deleteCreditCard(CardService cardService) {
    cardService.deleteCard(_cardToDeleteLabel);
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
                  DropdownFieldWidget(
                    items: cardList.data!,
                    label: 'Select a card',
                    onChange: (String? value) {
                      setState(() {
                        _cardToDeleteLabel = value == null ? '' : value;
                      });
                    },
                  )
                ],
                onPressed: () {
                  if (_cardToDeleteLabel != '') {
                    _deleteCreditCard(inheritedServices.cardService);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ModifyBalance()));
                  }
                },
              ),
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
