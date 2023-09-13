import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/accountBalance.dart';
import 'package:stock_market_app/screens/creditCard.dart';
import 'package:stock_market_app/screens/stockMarket.dart';
import 'package:stock_market_app/screens/stockPurchased.dart';
import 'package:stock_market_app/screens/wallet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stocket',
      debugShowCheckedModeBanner: false,
      initialRoute: '/wallet',
      routes: {
        '/wallet': (context) => const Wallet(),
        '/stockPurchased': (context) => const StockPurchased(),
        '/stockMarket': (context) => const StockMarket(),
        '/creditCard': (context) => const CreditCard(),
        '/accountBalance': (context) => const AccountBalance(),
      },
    );
  }
}