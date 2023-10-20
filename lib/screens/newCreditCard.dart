import 'package:flutter/material.dart';
import 'package:stock_market_app/entities/cardEntity.dart';
import 'package:stock_market_app/screens/modifyBalance.dart';
import 'package:stock_market_app/services/cardService.dart';
import 'package:stock_market_app/widgets/form/dropdownInputWidget.dart';

import '../context/inheritedServices.dart';
import '../services/walletService.dart';
import '../widgets/form/fields/dateFieldWidget.dart';
import '../widgets/form/fields/numberFieldWidget.dart';
import '../widgets/form/fields/textFieldWidget.dart';
import '../widgets/form/formWidget.dart';

class NewCreditCard extends StatefulWidget {
  NewCreditCard({Key? key, required int amount})
      : _amount = amount,
        super(key: key);

  int _amount;

  @override
  State<NewCreditCard> createState() => _NewCreditCardState();
}

class _NewCreditCardState extends State<NewCreditCard> {
  String _cardLabel = '';
  String _cardHolderName = '';
  int _cardNumber = -1;
  int _cardSafeCode = -1;
  DateTime _cardExpirationDate = DateTime.now();

  GlobalKey<FormState> _cardDetailsForm = GlobalKey<FormState>();

  TextEditingController _cardLabelController = TextEditingController();
  TextEditingController _cardHolderNameController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cardSafeCodeController = TextEditingController();

  _creditAccount(WalletService walletService) async {
    await walletService.creditWalletBalance(0.0);
  }

  _saveCardIfNew(CardService cardService) async {
    bool exists = false;
    List<CardEntity>? cardList = await cardService.getAllCards();
    for (CardEntity card in cardList!) {
      if (card.label == _cardLabel) {
        exists = true;
      }
    }
    if (!exists) {
      cardService.addCard(_cardLabel, _cardHolderName, _cardNumber,
          _cardSafeCode, _cardExpirationDate);
    }
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var inheritedServices = InheritedServices.of(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                            builder: (context) => ModifyBalance()));
                  })),
          Text('New card',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          Container(height: screenHeight * 0.05),
          FormWidget(
            key: _cardDetailsForm,
            fields: [
              TextFieldWidget(
                controller: _cardLabelController,
                validator: (value) {
                  if (value == '' || value == null) {
                    return "Please enter the card holder's name";
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    if (value != null) {
                      _cardLabel = value;
                    }
                  });
                },
                label: 'Name you want to give to this card',
              ),
              TextFieldWidget(
                controller: _cardHolderNameController,
                validator: (value) {
                  if (value == '' || value == null) {
                    return "Please enter the card holder's name";
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    if (value != null) {
                      _cardHolderName = value;
                    }
                  });
                },
                label: 'Name on the card',
              ),
              NumberFieldWidget(
                controller: _cardNumberController,
                validator: (value) {
                  if (value == '' || value == null || int.parse(value) < 0) {
                    return 'Please enter a valid card number';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    if (value != null) {
                      _cardNumber = int.parse(value);
                    }
                  });
                },
                label: 'Card number',
              ),
              NumberFieldWidget(
                controller: _cardSafeCodeController,
                validator: (value) {
                  if (value == '' || value == null || int.parse(value) < 0) {
                    return 'Please enter a valid card safe code';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    if (value != null) {
                      _cardSafeCode = int.parse(value);
                    }
                  });
                },
                label: 'Card safe code',
              ),
              DateFieldWidget(
                onChange: (DateTime date) {
                  _cardExpirationDate = date;
                },
                label: 'Expiration date',
              ),
            ],
            onPressed: () {
              _creditAccount(inheritedServices.walletService);
              _saveCardIfNew(inheritedServices.cardService);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ModifyBalance()));
            },
          ),
        ])));
  }
}
