import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/modifyBalance.dart';
import 'package:stock_market_app/screens/stock-market/stockMarketAppBar.dart';

class Balance extends StatefulWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  bool _isSafeOpen = false;

  //TODO : create a shared balance that is accessible throughout the app and that is saved when the app is closed
  double _balance = 999999;
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

  String _getMoneyImage(double amount) {
    if (amount <= 1000) {
      return 'assets/coins.png';
    }
    if (amount > 1000 && amount <= 10000) {
      return 'assets/money.png';
    }
    return 'assets/money-bag.png';
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
              )
            ] else ...[
              Container(height: screenHeight * 0.3),
              Text('Click to display your balance',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold))
            ],
            AnimatedContainer(
              height: _gapHeight,
              duration: Duration(milliseconds: 500),
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: _isSafeOpen
                  ? Image.asset(_getMoneyImage(_balance),
                      width: screenWidth * 0.5)
                  : Image.asset('assets/wallet.png', width: screenWidth * 0.5),
              iconSize: 300,
              onPressed: () {
                setGapHeight(screenHeight * 0.03);
                setIsSafeOpenToOpposite(_isSafeOpen);
              },
            )
          ],
        ),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                heroTag: 'modify-balance-button',
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                label: Text('Add funds'),
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ModifyBalance()));
                },
              ),
              Container(width: 0, height: screenHeight * 0.02),
              FloatingActionButton.extended(
                heroTag: 'stock-market-button',
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                label: Text('Stock market'),
                icon: Icon(Icons.attach_money),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StockMarketAppBar(balance: _balance)));
                },
              )
            ]));
  }
}
