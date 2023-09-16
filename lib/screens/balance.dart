import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/sharesPurchased.dart';

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

  void setGapHeight(double screenHeight) {
    setState(() {
      _isSafeOpen ? _gapHeight = 0 : _gapHeight = screenHeight * 0.1;
    });
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    //TODO : create a shared balance that is accessible throughout the app and that is saved when the app is closed
    _balance = 156354267698.568;

    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      body: Column(
        children: [
          if (_isSafeOpen) ...[
            Container(height: screenHeight * 0.3),
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
                ? Image.asset('assets/open_safe.png', width: screenWidth * 0.6)
                : Image.asset('assets/closed_safe.png',
                    width: screenWidth * 0.5),
            iconSize: 300,
            onPressed: () {
              setGapHeight(screenHeight);
              setIsSafeOpenToOpposite(_isSafeOpen);
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        label: Text('Stock market'),
        icon: Icon(Icons.data_exploration_outlined),
        onPressed: () {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>SharesPurchased()));
          });
        },
      ),
    );
  }
}
