import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';

import 'package:stock_market_app/screens/balance.dart';
import 'package:stock_market_app/screens/stock-market/tabs/purchasedShares.dart';
import 'package:stock_market_app/screens/stock-market/tabs/stockMarket.dart';
import 'package:stock_market_app/context/inheritedServices.dart';
import 'package:stock_market_app/services/walletService.dart';

class StockMarketAppBar extends StatefulWidget {
  StockMarketAppBar({Key? key}) : super(key: key);

  @override
  State<StockMarketAppBar> createState() => _StockMarketAppBarState();
}

class _StockMarketAppBarState extends State<StockMarketAppBar> {
  Future<String?>? _balance;

  Future<String?> _getBalanceRequest(WalletService walletService) async {
    return await walletService.getWalletBalanceAsString();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var inheritedServices = InheritedServices.of(context);

    _balance = _getBalanceRequest(inheritedServices.walletService);

    return FutureBuilder<String?>(
        future: _balance,
        builder: ((context, balance) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Balance()));
                    },
                  ),
                  bottom: const TabBar(
                    tabs: [Tab(text: 'Purchased'), Tab(text: 'Market')],
                  ),
                  title: Column(children: [
                    if (balance.hasData) ...[
                      Container(
                          constraints: BoxConstraints(
                              minWidth: 0, maxWidth: screenWidth * 0.7),
                          child: AnimatedDigitWidget(
                            duration: Duration(seconds: 1),
                            value: double.parse(balance.data!),
                            enableSeparator: true,
                            fractionDigits: 2,
                            suffix: ' \$',
                            textStyle: TextStyle(
                                overflow: TextOverflow.clip,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ))
                    ] else if (balance.hasError) ...[
                      Text('Something went wrong',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red, fontSize: 15))
                    ] else ...[
                      const CircularProgressIndicator()
                    ]
                  ]),
                ),
                body: const TabBarView(
                  children: [PurchasedShares(), StockMarket()],
                ),
              ),
            ),
          );
        }));
  }
}
