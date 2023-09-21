import 'package:flutter/material.dart';

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

    return Scaffold(

    );
  }
}