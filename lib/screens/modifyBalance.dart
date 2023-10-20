import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_market_app/screens/paymentMethode.dart';

import '../context/inheritedServices.dart';
import '../services/walletService.dart';
import '../widgets/form/fields/numberFieldWidget.dart';
import '../widgets/form/formWidget.dart';
import 'balance.dart';

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
  int _amount = -1;

  GlobalKey<FormState> _amountFrom = GlobalKey<FormState>();

  TextEditingController _amountController = TextEditingController();

  Future<String?> _getBalanceRequest(WalletService walletService) async {
    return await walletService.getWalletBalanceAsString();
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var inheritedServices = InheritedServices.of(context);
    Future<String?> _balance =
        _getBalanceRequest(inheritedServices.walletService);

    return FutureBuilder<String?>(
        future: _balance,
        builder: ((context, balance) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Column(children: [
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
                                  builder: (context) => Balance()));
                        })),
                Container(height: screenHeight * 0.15),
                Text('Current balance',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Container(height: screenHeight * 0.03),
                if (balance.hasData) ...[
                  AnimatedDigitWidget(
                    duration: Duration(seconds: 1),
                    value: double.parse(balance.data!),
                    enableSeparator: true,
                    fractionDigits: 1,
                    suffix: ' \$',
                    textStyle: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ] else if (balance.hasError) ...[
                  Text("Something went wrong, we can't load your balance",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 15))
                ] else ...[
                  const CircularProgressIndicator()
                ],
                Container(height: screenHeight * 0.05),
                Text('How much do you want to add ?',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Container(height: screenHeight * 0.05),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(width: screenWidth * 0.1),
                  Container(
                      constraints: BoxConstraints(
                          minWidth: 0, maxWidth: screenWidth * 0.8),
                      child: FormWidget(
                          key: _amountFrom,
                          buttonLabel: 'Pay',
                          fields: [
                            NumberFieldWidget(
                              controller: _amountController,
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
                                  if (value != null) {
                                    _amount = int.parse(value);
                                  }
                                });
                              },
                              label: 'Value you want to credit',
                            ),
                          ],
                          onPressed: () {
                            if (_amountFrom.currentState!.validate()) {
                              _amountFrom.currentState?.save();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PaymentMethode(amount: _amount)));
                            }
                          })),
                  Container(width: screenWidth * 0.02),
                  Container(
                      margin: const EdgeInsets.only(top: 17),
                      child: Text('\$',
                          style: TextStyle(color: Colors.white, fontSize: 20)))
                ]),
              ]));
        }));
  }
}
