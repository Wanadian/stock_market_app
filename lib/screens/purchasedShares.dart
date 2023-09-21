import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/balance.dart';

import '../widgets/appBarWidget.dart';

class PurchasedShares extends StatefulWidget {
  const PurchasedShares({Key? key}) : super(key: key);

  @override
  State<PurchasedShares> createState() => _PurchasedSharesState();
}

class _PurchasedSharesState extends State<PurchasedShares> {
  double _balance = 0;

  void setBalance(double value) {
    setState(() {
      _balance = value;
    });
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    //TODO : create a shared balance that is accessible throughout the app and that is saved when the app is closed
    _balance = 156354267698.568;

    return Scaffold(
      appBar: AppBarWidget(balance: _balance,),
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        // TODO : rename button when image is found
        label: Text('Return to my safe'),
        icon: Icon(Icons.attach_money),
        onPressed: () {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Balance()));
          });
        },
      ),
    );
  }
}