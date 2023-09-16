import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/balance.dart';

class SharesPurchased extends StatefulWidget {
  const SharesPurchased({Key? key}) : super(key: key);

  @override
  State<SharesPurchased> createState() => _SharesPurchasedState();
}

class _SharesPurchasedState extends State<SharesPurchased> {

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        label: Text('Return to my safe'),
        icon: Icon(Icons.attach_money),
        onPressed: () {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>Balance()));
          });
        },
      ),
    );;
  }
}