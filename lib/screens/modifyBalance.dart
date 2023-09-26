import 'package:flutter/material.dart';
import 'package:stock_market_app/widgets/buttonWidget.dart';

import '../widgets/form/fields/dateFieldWidget.dart';
import '../widgets/form/fields/numberFieldWidget.dart';
import '../widgets/form/fields/textFieldWidget.dart';
import '../widgets/form/formWidget.dart';
import 'balance.dart';

class ModifyBalance extends StatefulWidget {
  const ModifyBalance({Key? key}) : super(key: key);

  @override
  State<ModifyBalance> createState() => _ModifyBalanceState();
}

class _ModifyBalanceState extends State<ModifyBalance> {
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
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
          Container(height: screenHeight * 0.3),
          ButtonWidget.textButton(
              label: 'Pay',
              onPressed: () {
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
                                  fields: [
                                    TextFieldWidget(
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
                                      label: 'Expiration date',
                                    )
                                  ],
                                  onPressed: () {
                                    print('test');
                                  },
                                ),
                              ])));
                    });
              },
              height: screenHeight * 0.07,
              width: screenWidth * 0.5),
        ],
      ),
    );
  }
}
