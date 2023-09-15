import 'package:flutter/material.dart';
import 'package:stock_market_app/widgets/shareBannerWidget.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body:  Container(
        child: ShareBannerWidget(shareValue: 20,shareName: 'Axa IT department', onPressed: () {},),
      ),
    );
  }
}