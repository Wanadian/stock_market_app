import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_market_app/repositories/shareRepository.dart';
import 'package:stock_market_app/entities/share.dart';
import 'package:stock_market_app/errors/shareError.dart';
import 'package:stock_market_app/services/symbolService.dart';

// This class will contain all the API calls and calls the associated repository
class ShareService {
  static const String APIKEY = '4V1HEZEB2M5V7LW9';
  ShareRepository shareRepository = ShareRepository();
  SymbolService symbolService = SymbolService();

  // Gets a share from the API
  Future<Share?> getShareFromAPI(String symbol) async {
    final response = await http.get(Uri.parse(
        'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$APIKEY'));

    Share share;

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      share = Share.fromAPIJson(data['Global Quote']);
    } else {
      throw ShareError('Error: Could not fetch data from API ${response.reasonPhrase}');
    }

    return share;
  }

  // Converts our list of String to a Stream that emits a value each 13s
  // because the API is limited to 5 calls per minutes (13s and not 12s to be sure)
  Stream<String> convertListToStream(List<String> stringList) async* {
    for (final item in stringList) {
      yield item;
      await Future.delayed(Duration(seconds: 13));
    }
  }

  // Refreshes all shares from API to the database
  void addSharesFromAPIToDB() async {
    List<String>? symbols = await symbolService.getAllSymbols();

    if(symbols != null) {
      final symbolsStream = convertListToStream(symbols);

      StreamSubscription? subscription;

      subscription = symbolsStream.listen((symbol) async {
        Share? share = await getShareFromAPI(symbol);

        if(share != null) {
          shareRepository.addShare(share);
        }
      }, onDone: () {
        // Cancel the subscription when needed to stop listening to the stream
        subscription?.cancel();
      });
    }
    else {
      throw ShareError('Cannot retrieve symbols from database');
    }
  }

  // Returns all the shares
  Future<List<Share>?> getAllShares() async {
    return await shareRepository.getShares();
  }

  // Returns the lastest shares for all symbol
  Future<List<Share>?> getLatestShares() async {
    List<String>? symbols = await symbolService.getAllSymbols();

    if(symbols != null) {
      return await shareRepository.getLatestShares(symbols);
    }

    return null;
  }

  // Returns the lastest share's prices (for each symbol)
  Future<Map<String, double>?> getSharesPrices() async {
    Map<String, double>? sharesPrice;

    List<Share>? shares = await getLatestShares();

    if(shares != null) {
      sharesPrice = {};
      for (var share in shares) {
        sharesPrice[share.symbol] = share.price;
      }
    }

    return sharesPrice;
  }

  // Returns the latest refresh day from the database
  Future<DateTime?> getLatestRefreshDate() async {
    return await shareRepository.getLatestRefreshDate();
  }

  // Returns the latest share by symbol
  Future<Share?> getLatestShare(String symbol) async {
    List<String>? symbols = await symbolService.getAllSymbols();


    if(symbols != null) {
      List<Share>? shares = await shareRepository.getLatestShares(symbols);

      for (var s in shares!) {
        if (s.symbol == symbol) {
          return s;
        }
      }
    }

    return null;
  }

  // Returns the share's price (of a symbol)
  Future<double?> getPrice(String symbol) async {
    return (await getLatestShare(symbol))?.price;
  }

  // Returns the share's number (of a symbol)
  Future<int?> getNbShares(String symbol) async {
    return (await getLatestShare(symbol))?.nbShares;
  }
}
