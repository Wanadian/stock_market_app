import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/splashScreen.dart';

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
      home: const SplashScreen(),
    );
  }
}
