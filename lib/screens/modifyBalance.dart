import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_market_app/widgets/buttonWidget.dart';

import '../widgets/form/fields/dateFieldWidget.dart';
import '../widgets/form/fields/numberFieldWidget.dart';
import '../widgets/form/fields/textFieldWidget.dart';
import '../widgets/form/formWidget.dart';
import 'balance.dart';

class Keys {
  static final cardDetailsForm =
      GlobalObjectKey<FormState>('card-details-form');
  static final valueToPayInput =
      GlobalObjectKey<FormFieldState>('value-to-pay-input');
  static final cardHolderNameInput =
      GlobalObjectKey<FormFieldState>('card-holder-name-input');
  static final cardNumberInput =
      GlobalObjectKey<FormFieldState>('card-number-input');
  static final cardSafeCodeInput =
      GlobalObjectKey<FormFieldState>('card-safe-code-input');
  static final cardExpirationDateInput =
      GlobalObjectKey<FormFieldState>('card-expiration-date-input');
}

class PaymentDetails {
  int valuePaid = -1;
  String cardHolderName = '';
  int cardNumber = -1;
  int cardSafeCode = -1;
  String cardExpirationDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  PaymentDetails(
      {required this.valuePaid,
      required this.cardHolderName,
      required this.cardNumber,
      required this.cardSafeCode,
      required this.cardExpirationDate});

  String returnDetailsInString() {
    return ('{valuePaid: $valuePaid, cardHolderName: $cardHolderName, cardNumber: $cardNumber, cardSafeCode: $cardSafeCode, cardExpirationDate: $cardExpirationDate}');
  }
}

class ModifyBalance extends StatefulWidget {
  const ModifyBalance({Key? key}) : super(key: key);

  @override
  State<ModifyBalance> createState() => _ModifyBalanceState();
}

class _ModifyBalanceState extends State<ModifyBalance> {
  //TODO : create a shared balance that is accessible throughout the app and that is saved when the app is closed
  double _balance = 1754156451452465;
  int _valueToPay = -1;
  String _cardHolderName = '';
  int _cardNumber = -1;
  int _cardSafeCode = -1;
  DateTime _cardExpirationDate = DateTime.now();

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Container(height: screenHeight * 0.07),
              Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                      color: Colors.white,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Balance()));
                      })),
              Container(height: screenHeight * 0.1),
              Text('Current balance',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              Container(height: screenHeight * 0.05),
              AnimatedDigitWidget(
                duration: Duration(seconds: 1),
                value: _balance,
                enableSeparator: true,
                fractionDigits: 1,
                suffix: ' \$',
                textStyle: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Container(height: screenHeight * 0.1),
              Text('How much do you want to add ?',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              Container(height: screenHeight * 0.05),
              Row(children: [
                Container(width: screenWidth * 0.1),
                Container(
                    constraints: BoxConstraints(
                        minWidth: 0, maxWidth: screenWidth * 0.8),
                    child: NumberFieldWidget(
                        key: Keys.valueToPayInput,
                        value: -1,
                        validator: (value) {
                          if (value == '' ||
                              value == null ||
                              int.parse(value) <= 0) {
                            return 'Please enter a value greater than 0';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _valueToPay = int.parse(value!);
                          });
                        })),
                Container(width: screenWidth * 0.02),
                Text('\$', style: TextStyle(color: Colors.white, fontSize: 20))
              ]),
              Container(height: screenHeight * 0.1),
              ButtonWidget.textButton(
                  label: 'Pay',
                  onPressed: () {
                    if (Keys.valueToPayInput.currentState!.validate()) {
                      Keys.valueToPayInput.currentState?.save();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                shadowColor: Colors.grey.shade800,
                                surfaceTintColor: Colors.black,
                                backgroundColor: Colors.transparent,
                                elevation: 10.0,
                                scrollable: true,
                                title: Text('Enter your card details',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center),
                                content: Padding(
                                    padding: const EdgeInsets.all(0.8),
                                    child: Column(children: [
                                      Container(height: screenHeight * 0.05),
                                      FormWidget(
                                        key: Keys.cardDetailsForm,
                                        fields: [
                                          TextFieldWidget(
                                            key: Keys.cardHolderNameInput,
                                            validator: (value) {
                                              if (value == '' ||
                                                  value == null) {
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
                                            label: 'Card holder name',
                                          ),
                                          NumberFieldWidget(
                                            key: Keys.cardNumberInput,
                                            validator: (value) {
                                              if (value == '' ||
                                                  value == null ||
                                                  int.parse(value) < 0) {
                                                return 'Please enter a valid card number';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              setState(() {
                                                if (value != null) {
                                                  _cardNumber =
                                                      int.parse(value);
                                                }
                                              });
                                            },
                                            label: 'Card number',
                                          ),
                                          NumberFieldWidget(
                                            key: Keys.cardSafeCodeInput,
                                            validator: (value) {
                                              if (value == '' ||
                                                  value == null ||
                                                  int.parse(value) < 0) {
                                                return 'Please enter a valid card safe code';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              setState(() {
                                                if (value != null) {
                                                  _cardSafeCode =
                                                      int.parse(value);
                                                }
                                              });
                                            },
                                            label: 'Card safe code',
                                          ),
                                          DateFieldWidget(
                                            key: Keys.cardExpirationDateInput,
                                            onChange: (DateTime date) {
                                              _cardExpirationDate = date;
                                            },
                                            label: 'Expiration date',
                                          )
                                        ],
                                        onPressed: () {
                                          print(PaymentDetails(
                                                  valuePaid: _valueToPay,
                                                  cardHolderName:
                                                      _cardHolderName,
                                                  cardNumber: _cardNumber,
                                                  cardSafeCode: _cardSafeCode,
                                                  cardExpirationDate: DateFormat(
                                                          'yyyy-MM-dd')
                                                      .format(
                                                          _cardExpirationDate))
                                              .returnDetailsInString());
                                        },
                                      ),
                                    ])));
                          });
                    }
                  },
                  height: screenHeight * 0.07,
                  width: screenWidth * 0.5),
            ],
          ),
        ));
  }
}
