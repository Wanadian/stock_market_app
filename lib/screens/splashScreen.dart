import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/balance.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _Splash();
}

class _Splash extends State<SplashScreen> {
  _Splash() {
    screenChange();
  }

  void screenChange() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Balance(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Stocket',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: screenHeight / 15),
              child: Image.asset('assets/stocket-logo.png',
                  width: screenWidth / 3.5),
            ),
          ],
        ),
      ),
    );
  }
}
