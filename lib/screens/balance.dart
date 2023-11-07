import 'package:flutter/material.dart';

import 'package:stock_market_app/screens/modifyBalance.dart';
import 'package:stock_market_app/screens/stock-market/stockMarketAppBar.dart';
import 'package:stock_market_app/services/userSharesService.dart';
import 'package:stock_market_app/services/walletService.dart';
import 'package:stock_market_app/widgets/displayBalanceWidget.dart';
import 'package:stock_market_app/context/inheritedServices.dart';

class Balance extends StatefulWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  Future<String?>? _balance;

  Future<String?> _getBalanceRequest(WalletService walletService, UserSharesService userSharesService) async {
    String? balance = await walletService.getWalletBalanceAsString();
    String sharesValue = await userSharesService.getUserSharesBalanceEstimationAsString();
    double value = double.parse(balance!) + double.parse(sharesValue);
    return value.toString();
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var inheritedServices = InheritedServices.of(context);

    _balance = _getBalanceRequest(inheritedServices.walletService);

    return FutureBuilder<String?>(
        future: _balance,
        builder: ((context, balance) {
          return Scaffold(
              body: Column(children: [
                if (balance.hasData) ...[
                  Container(height: screenHeight * 0.3),
                  DisplayBalanceWidget(balance: double.parse(balance.data!))
                ] else if (balance.hasError) ...[
                  Container(
                    height: screenHeight * 0.45,
                  ),
                  Container(
                      width: screenWidth * 0.9,
                      child: Text('Something went wrong',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red, fontSize: 20)))
                ] else ...[
                  Container(
                    height: screenHeight * 0.45,
                  ),
                  const CircularProgressIndicator()
                ]
              ]),
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ModifyBalance()));
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StockMarketAppBar()));
                      },
                    )
                  ]));
        }));
  }
}
