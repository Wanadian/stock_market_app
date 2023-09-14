import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/wallet.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _Splash();
}

class _Splash extends State<SplashScreen> {
  _Splash() {
    pageSwapping();
  }

  void pageSwapping() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const Wallet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Socket',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
              child: Image.asset('assets/stocket-logo.png',
                  width: MediaQuery.of(context).size.width / 3.5),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade800,
    );
  }
}
