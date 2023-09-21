import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_market_app/context/rootWidget.dart';
import 'package:stock_market_app/screens/splashScreen.dart';

void main() {
  runApp(RootWidget());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Stocket',
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey.shade800),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
