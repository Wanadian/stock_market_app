import 'dart:convert';

import 'package:flutter/services.dart';

class SymbolService {
  Map<String, String> _symbolMap = {};

  // Lets us read data form Json File
  Future<List<dynamic>> _loadJsonData(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    dynamic jsonData = await json.decode(jsonString);
    return jsonData;
  }

  // Initialises the map with the company names and their symbol
  void init() async {
    String filePath = 'lib/data/symbols.json';
    dynamic dataList = await _loadJsonData(filePath);

    for (var item in dataList) {
      _symbolMap.putIfAbsent(item['symbol'], () => item['companyName']);
    }
  }

  // Returns all the symbols
  List<String> getAllSymbols() {
    return _symbolMap.keys.toList();
  }

  // Returns all the companies
  List<String> getAllCompanyNames() {
    return _symbolMap.values.toList();
  }

  // Returns the symbol of a company
  String? getSymbol(String companyName) {
    return _symbolMap.keys.firstWhere((key) => _symbolMap[key] == companyName);
  }

  // Retruns the campany name of a symbol
  String? getCompanyName(String symbol) {
    return _symbolMap[symbol];
  }
}