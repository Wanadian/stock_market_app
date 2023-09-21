import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/balance.dart';
import 'package:stock_market_app/screens/stock-market/tabs/purchasedShares.dart';
import 'package:stock_market_app/screens/stock-market/tabs/stockMarket.dart';

class StockMarketAppBar extends StatefulWidget {
  double _balance;

  @override
  StockMarketAppBar({Key? key, required double balance})
      : _balance = balance,
        super(key: key);

  @override
  _StockMarketAppBarState createState() => _StockMarketAppBarState();
}

class _StockMarketAppBarState extends State<StockMarketAppBar> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Balance()));
              },
            ),
            bottom: const TabBar(
              tabs: [Tab(text: 'Purchased'), Tab(text: 'Market')],
            ),
            title: Container(
              constraints: BoxConstraints(
                  minWidth: 0, maxWidth: screenWidth * 0.7),
                child: AnimatedDigitWidget(
              duration: Duration(seconds: 1),
              value: widget._balance,
              enableSeparator: true,
              fractionDigits: 1,
              suffix: ' \$',
              textStyle: TextStyle(
                  overflow: TextOverflow.clip,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            )),
          ),
          body: const TabBarView(
            children: [PurchasedShares(), StockMarket()],
          ),
        ),
      ),
    );
  }
}
