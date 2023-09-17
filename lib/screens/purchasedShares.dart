import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/balance.dart';

class PurchasedShares extends StatefulWidget {
  const PurchasedShares({Key? key}) : super(key: key);

  @override
  State<PurchasedShares> createState() => _PurchasedSharesState();
}

class _PurchasedSharesState extends State<PurchasedShares> {

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
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