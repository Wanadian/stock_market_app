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
  factory Share.fromAPIJson(Map<String, dynamic> json) {
    String currentDateFormatted =
        DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Share(
        json['01. symbol'],
        double.parse(json['05. price']),
        DateTime.parse(json['07. latest trading day']),
        int.parse(json['06. volume']),
        DateTime.parse('$currentDateFormatted 17:00:00'));
  }

  // The factory return type allows us to return an object mapped from json
  // Here we want to convert a Share object from the database
  factory Share.fromDBJson(Map<String, dynamic> json) {
    return Share(
        json['symbol'],
        double.parse(json['price']),
        DateTime.parse(json['latestTradingDay']),
        int.parse(json['nbShares']),
        DateTime.parse(json['latestRefreshDay']));
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
}
