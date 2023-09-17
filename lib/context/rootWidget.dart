import 'package:flutter/cupertino.dart';
import 'package:stock_market_app/context/inheritedSymbolService.dart';
import 'package:stock_market_app/main.dart';
import 'package:stock_market_app/services/symbolService.dart';

// This Widget is the parent widget, where we can store services and all useful information
class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  SymbolService symbolService = SymbolService();

  @override
  void initState() {
    symbolService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedSymbolService(
      symbolService: symbolService,
      child: MyApp(),
    );
  }
}