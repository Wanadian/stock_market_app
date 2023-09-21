import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/modifyBalance.dart';
import 'package:stock_market_app/screens/stock-market/stockMarketAppBar.dart';
import 'package:stock_market_app/widgets/buttonWidget.dart';

class Balance extends StatefulWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  bool _isSafeOpen = false;
  double _balance = 0;
  double _gapHeight = 0;

  void setIsSafeOpenToOpposite(bool isSafeOpen) {
    setState(() {
      _isSafeOpen = !isSafeOpen;
    });
  }

  void setBalance(double value) {
    setState(() {
      _balance = value;
    });
  }

  void setGapHeight(double gapHeight) {
    setState(() {
      _isSafeOpen ? _gapHeight = 0 : _gapHeight = gapHeight;
    });
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    //TODO : create a shared balance that is accessible throughout the app and that is saved when the app is closed
    _balance = 156354267698.568;

    return Scaffold(
      body: Column(
        children: [
          if (_isSafeOpen) ...[
            Container(height: screenHeight * 0.25),
            AnimatedDigitWidget(
              duration: Duration(seconds: 1),
              value: _balance,
              enableSeparator: true,
              fractionDigits: 1,
              suffix: ' \$',
              textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            ),
            Container(height: screenHeight * 0.02),
            ButtonWidget.iconButton(
                icon: Icons.add,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ModifyBalance()));
                },
                height: screenHeight * 0.04,
                width: screenWidth * 0.15)
          ] else ...[
            Container(height: screenHeight * 0.3)
          ],
          AnimatedContainer(
            height: _gapHeight,
            duration: Duration(milliseconds: 500),
          ),
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: _isSafeOpen
                //TODO: find new images
                ? Image.asset('assets/open_safe.png', width: screenWidth * 0.6)
                : Image.asset('assets/closed_safe.png',
                    width: screenWidth * 0.5),
            iconSize: 300,
            onPressed: () {
              setGapHeight(screenHeight * 0.03);
              setIsSafeOpenToOpposite(_isSafeOpen);
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        label: Text('Stock market'),
        icon: Icon(Icons.attach_money),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => StockMarketAppBar(balance: _balance)));
        },
      ),
    );
  }
}
