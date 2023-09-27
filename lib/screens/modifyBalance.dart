import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_app/widgets/buttonWidget.dart';

import '../widgets/form/fields/dateFieldWidget.dart';
import '../widgets/form/fields/numberFieldWidget.dart';
import '../widgets/form/fields/textFieldWidget.dart';
import '../widgets/form/formWidget.dart';
import 'balance.dart';

class Keys {
  static final cardDetailsForm = GlobalObjectKey<FormState>('card-details-form');
  static final valueToPayInput = GlobalObjectKey<FormFieldState>('value-to-pay-input');
  static final textInput = GlobalObjectKey<FormFieldState>('text-input');
  static final numberInput = GlobalObjectKey<FormFieldState>('number-input');
  static final dateInput = GlobalObjectKey<FormFieldState>('date-input');
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
                          print(value);
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
                    if (Keys.valueToPayInput.currentState!.validate())
                    {Keys.valueToPayInput.currentState?.save();
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
                                          key: Keys.textInput,
                                          validator: (value) {
                                            if (value == '' || value == null) {
                                              return 'Please enter a value';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) => (print(value)),
                                          label: 'Text',
                                        ),
                                        NumberFieldWidget(
                                          key: Keys.numberInput,
                                          validator: (value) {
                                            if (value == '' || value == null) {
                                              return 'Please enter a value';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) => (print(value)),
                                          label: 'Number',
                                        ),
                                        DateFieldWidget(
                                          key: Keys.dateInput,
                                          label: 'Expiration date',
                                        )
                                      ],
                                      onPressed: () {
                                        print('Validated');
                                      },
                                    ),
                                  ])));
                        });
                  }},
                  height: screenHeight * 0.07,
                  width: screenWidth * 0.5),
            ],
          ),
        ));
  }
}
