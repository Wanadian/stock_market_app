import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_market_app/context/inheritedServices.dart';
import 'package:stock_market_app/main.dart';
import 'package:stock_market_app/services/cardService.dart';
import 'package:stock_market_app/services/shareService.dart';
import 'package:stock_market_app/services/symbolService.dart';
import 'package:stock_market_app/services/userSharesService.dart';
import 'package:stock_market_app/services/walletService.dart';
import 'package:intl/intl.dart';

// This Widget is the parent widget, where we can store services and all useful information
class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  SymbolService symbolService = SymbolService();
  ShareService shareService = ShareService();
  UserSharesService userSharesService = UserSharesService();
  WalletService walletService = WalletService();
  CardService cardService = CardService();
  late SharedPreferences prefs;

  @override
  void initState() {
    _refreshIfNeeded();
    super.initState();
  }

  // Saves the date at which the next refresh will occur
  void _saveNextRefreshDate(DateTime currentDate) {
    String currentDateFormatted = DateFormat('yyyy-MM-dd hh:mm:ss').format(currentDate.add(Duration(days: 1)));
    // We add 24h because the method DateTime.parse() undestands overflow
    // so, we set the next refresh date which is at midnight the next day
    prefs.setString('nextRefreshDate', currentDateFormatted);
  }

  // Gets the date for the next refresh
  DateTime? _getNextRefreshDate() {
    var nextRefreshDate = prefs.getString('nextRefreshDate');

    if (nextRefreshDate != null) {
      return DateTime.parse(nextRefreshDate);
    }

    return null;
  }

  // Updates the shares list at midnight each day,
  // will be called each time the app is launched
  void _refreshIfNeeded() async {
    prefs = await SharedPreferences.getInstance();
    DateTime? refreshDate =
        _getNextRefreshDate() ?? await shareService.getLatestRefreshDate();

    if ((refreshDate == null) ||
        (DateTime.now().isAfter(refreshDate.add(Duration(days: 1))))) {
      shareService.addSharesFromAPIToDB();
      _saveNextRefreshDate(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    return InheritedServices(
      symbolService: symbolService,
      shareService: shareService,
      userSharesService: userSharesService,
      walletService: walletService,
      cardService: cardService,
      child: MyApp(),
    );
  }
}
