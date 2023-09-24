import 'package:flutter/cupertino.dart';
import 'package:stock_market_app/context/inheritedSymbolService.dart';
import 'package:stock_market_app/context/inheritedServices.dart';
import 'package:stock_market_app/main.dart';
import 'package:stock_market_app/services/shareService.dart';
import 'package:stock_market_app/services/symbolService.dart';
import 'package:intl/intl.dart';

// This Widget is the parent widget, where we can store services and all useful information
class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  SymbolService symbolService = SymbolService();
  ShareService shareService = ShareService();

  @override
  void initState() {
    symbolService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedServices(
      symbolService: symbolService,
      shareService: shareService,
      child: MyApp(),
    );
  }
}
