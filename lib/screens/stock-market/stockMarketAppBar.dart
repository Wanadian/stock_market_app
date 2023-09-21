import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/balance.dart';
import 'package:stock_market_app/screens/stock-market/screens/purchasedShares.dart';
import 'package:stock_market_app/screens/stock-market/screens/stockMarket.dart';

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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Balance()));
              },
            ),
            bottom: const TabBar(
              tabs: [Tab(text: 'Purchased'), Tab(text: 'Market')],
            ),
            title: Text(widget._balance.toString() + ' \$'),
          ),
          body: const TabBarView(
            children: [PurchasedShares(), StockMarket()],
          ),
        ),
      ),
    );
  }
}
