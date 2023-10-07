// This class represents a share
import 'package:intl/intl.dart';

class Share {
  String _symbol;
  double _price;
  DateTime _latestTradingDay;
  int _nbShares;
  DateTime _latestRefreshDay;

  Share(this._symbol, this._price, this._latestTradingDay, this._nbShares,
      this._latestRefreshDay);

  // The factory return type allows us to return an object mapped from json
  // Here we want to convert a Share object from the API
  factory Share.fromAPIJson(String symbol, DateTime lastRefreshed, Map<String, dynamic> json) {
    String currentDateFormatted =
    DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Share(
        symbol,
        double.parse(json['4. close']),
        lastRefreshed,
        int.parse(json['5. volume']),
        DateTime.parse('$currentDateFormatted 17:00:00'));
  }

  // The factory return type allows us to return an object mapped from json
  // Here we want to convert a Share object from the database
  factory Share.fromDBJson(Map<String, dynamic> json) {
    return Share(
        json['symbol'],
        json['price'],
        json['latestTradingDay'].toDate(),
        json['nbShares'],
        json['latestRefreshDay'].toDate());
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'symbol': _symbol,
      'price': _price,
      'latestTradingDay': _latestTradingDay,
      'nbShares': _nbShares,
      'latestRefreshDay': _latestRefreshDay,
    };
  }

  String get symbol => _symbol;

  set symbol(String newSymbol) {
    _symbol = newSymbol;
  }

  double get price => _price;

  set price(double newPrice) {
    _price = newPrice;
  }

  DateTime get latestTradingDay => _latestTradingDay;

  set latestTradingDay(DateTime newLatestTradingDay) {
    _latestTradingDay = newLatestTradingDay;
  }

  int get nbShares => _nbShares;

  set nbShares(int newNbShares) {
    _nbShares = newNbShares;
  }

  DateTime get latestRefreshDay => _latestRefreshDay;

  set latestRefreshDay(DateTime newLatestRefreshDay) {
    _latestRefreshDay = newLatestRefreshDay;
  }
}
