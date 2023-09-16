import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool _isWalletOpen = false;
  double _balance = 0;

  void setIsWalletOpenToOpposite(bool isWalletOpen) {
    setState(() {
      _isWalletOpen = !isWalletOpen;
    });
  }

  void setBalance(double value) {
    setState(() {
      _balance = value;
    });
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    //TODO : create a shared balance that is accessible throughout the app and that is saved when the app is closed
    double currentBalance = 156354267698.568;

    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      body: Column(
        children: [
          if (_isWalletOpen) ...[
            Container(height: screenHeight * 0.3),
            AnimatedDigitWidget(
              value: currentBalance,
              enableSeparator: true,
              fractionDigits: 1,
              suffix: ' \$',
              textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            ),
            Container(height: screenHeight * 0.1)
          ] else ...[
            Container(height: screenHeight * 0.33)
          ],
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: _isWalletOpen
                ? Image.asset('assets/wallet-open.png')
                : Image.asset('assets/wallet-closed.png'),
            iconSize: 300,
            onPressed: () {
              setIsWalletOpenToOpposite(_isWalletOpen);
            },
          )
        ],
      ),
    );
  }
}
