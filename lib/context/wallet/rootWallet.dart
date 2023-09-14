import 'package:flutter/cupertino.dart';
import 'package:stock_market_app/context/wallet/inheritedWallet.dart';
import 'package:stock_market_app/classes/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class RootWallet extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWallet> {
  var wallet = Wallet();
  late SharedPreferences prefs;

  @override
  void initState() {
    _initCounter();
    super.initState();
  }

  // TODO
  void _initCounter() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  // TODO : Exemple
  void saveWalletAmount() {
    prefs.setDouble('walletAmount', 28);
  }

  @override
  Widget build(BuildContext context) {
    return InheritedWallet(
      wallet: wallet,
      saveWalletAmount: saveWalletAmount,
      child: MyApp(),
    );
  }
}