import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_market_app/repositories/shareRepository.dart';
import 'package:stock_market_app/entities/shareEntity.dart';
import 'package:stock_market_app/errors/shareError.dart';
import 'package:stock_market_app/services/symbolService.dart';

// This class will contain all the API calls and calls the associated repository
class ShareService {
  static const String APIKEY = '4V1HEZEB2M5V7LW9';
  ShareRepository shareRepository = ShareRepository();
  SymbolService symbolService = SymbolService();

  // Gets a share from the API
  Future<List<ShareEntity>?> getShareFromAPI(String symbol) async {
    final response = await http.get(Uri.parse(
        'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$APIKEY'));

    List<ShareEntity>? shares;

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Map<String, dynamic> timeSeries = data['Time Series (Daily)'];

      shares = [];
      timeSeries.forEach((key, value) => shares?.add(ShareEntity.fromAPIJson(symbol, DateTime.parse(key), value)));
    } else {
      throw ShareError('Error: Could not fetch data from API ${response.reasonPhrase}');
    }

    return shares;
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
      List<ShareEntity> sharesToAdd = [];

      final symbolsStream = convertListToStream(symbols);
      StreamSubscription? subscription;

      subscription = symbolsStream.listen((symbol) async {
        List<ShareEntity>? shares = await getShareFromAPI(symbol);

        if(shares != null) {
          for (int i = 0; i < shares.length; i++) {
            ShareEntity shareTemp = ShareEntity.copy(shares[i]);

            do {
              sharesToAdd.add(ShareEntity.copy(shareTemp));
              shareTemp.latestTradingDay = shareTemp.latestTradingDay.add(Duration(days: -1));
            } while((i < shares.length - 1) && (shareTemp.latestTradingDay.isAfter(shares[i+1].latestTradingDay)));
          }
        }
        else {
          throw ShareError('No shares found for symbol $symbol');
        }
      }, onDone: () async {
        // Cancel the subscription when needed to stop listening to the stream
        subscription?.cancel();

        // if there is any shares to add then we clean the DB and add the new shares
        if (sharesToAdd.isNotEmpty && await emptyDBShares()) {
          for (ShareEntity share in sharesToAdd) {
            await shareRepository.addShare(share);
          }
        }
      });
    }
    else {
      throw ShareError('Cannot retrieve symbols from database');
    }
  }

  // Returns all the shares
  Future<List<ShareEntity>?> getAllShares() async {
    return await shareRepository.getAllShares();
  }

  // Returns the latest shares for all symbol
  Future<List<ShareEntity>?> getLatestShares() async {
    List<String>? symbols = await symbolService.getAllSymbols();
    List<ShareEntity>? latestShare;

    if(symbols != null) {
      latestShare = [];

      for (var symbol in symbols) {
        ShareEntity? share = await getLatestShare(symbol);
        if (share != null) {
          latestShare.add(share);
        }
      }
    }

    return latestShare;
  }

  // Returns the latest share's prices (for each symbol)
  Future<Map<String, double>?> getSharesPrices() async {
    Map<String, double>? sharesPrice;

    List<ShareEntity>? shares = await getLatestShares();

    if(shares != null) {
      sharesPrice = {};
      for (var share in shares) {
        sharesPrice[share.symbol] = share.price;
      }
    }

    return sharesPrice;
  }

  // Returns the shares prices history (for a symbol)
  Future<Map<DateTime, double>?> getSymbolSharesPricesHistory(String symbol) async {
    Map<DateTime, double>? sharesPricesHistory;

    List<ShareEntity>? shares = await shareRepository.getSymbolSharesPrices(symbol);

    if(shares != null) {
      sharesPricesHistory = {};
      for (var share in shares) {
        sharesPricesHistory[share.latestTradingDay] = share.price;
      }

      // Sort the keys (dates) in ascending order
      var sortedKeys = sharesPricesHistory.keys.toList()..sort();

      // Create a new map with sorted keys
      sharesPricesHistory = Map<DateTime, double>.fromIterable(
        sortedKeys,
        key: (key) => key,
        value: (key) => sharesPricesHistory![key]!,
      );

      return sharesPricesHistory;
    }

    return null;
  }

  // Returns the shares prices history after a special start time (for a symbol)
  Future<Map<DateTime, double>?> getSymbolSharesPricesHistoryWithDate(String symbol, DateTime startTime) async {
    Map<DateTime, double>? symbolSharesPricesHistory = await getSymbolSharesPricesHistory(symbol);
    Map<DateTime, double>? symbolSharesPricesHistoryAfterStartDate;

    if(symbolSharesPricesHistory != null) {
      symbolSharesPricesHistoryAfterStartDate = {};

      DateTime timeTemp = startTime.add(Duration(days: -1));
      while(symbolSharesPricesHistory.entries.first.key.isAfter(timeTemp)) {
        timeTemp = timeTemp.add(Duration(days: 1));
        symbolSharesPricesHistoryAfterStartDate[timeTemp] = -1;
      }

      symbolSharesPricesHistory.forEach((key, value) {
        if(key.isAfter(startTime.add(Duration(days: -1)))) {
          symbolSharesPricesHistoryAfterStartDate?[key] = value;
        }
      });

      return symbolSharesPricesHistoryAfterStartDate;
    }

    return null;
  }

  // Returns the latest refresh day from the database
  Future<DateTime?> getLatestRefreshDate() async {
    return await shareRepository.getLatestRefreshDate();
  }

  // Returns the latest share by symbol
  Future<ShareEntity?> getLatestShare(String symbol) async {
    return await shareRepository.getLatestShare(symbol);
  }

  // Returns the variation in percent of the price between the two latest shares
  Future<double?> getPriceDifference(String symbol) async {
    return await shareRepository.getPriceDifference(symbol);
  }

  // Adds shares by symbol
  Future<void> addNbShares(String symbol, int nbSharesToAdd) async {
    ShareEntity? share = await getLatestShare(symbol);

    if(share != null && share.id != null) {
      await shareRepository.incrementNbShares(share.nbShares + nbSharesToAdd, share.id ?? '');
    }
    else {
      throw ShareError('Share\'s number of $symbol not found');
    }
  }

  // Removes user's shares by symbol
  Future<void> removeNbShares(String symbol, int nbSharesToAdd) async {
    ShareEntity? share = await getLatestShare(symbol);

    if(share != null && share.id != null) {
      int newNbShare = share.nbShares - nbSharesToAdd;

      if(newNbShare < 0) {
        await shareRepository.decrementNbShares(0, share.id ?? '');
      }
      else {
        await shareRepository.decrementNbShares(newNbShare, share.id ?? '');
      }

    }
    else {
      throw ShareError('Share\'s number of $symbol not found');
    }
  }

  // Returns the share's price (of a symbol)
  Future<double?> getPrice(String symbol) async {
    return (await getLatestShare(symbol))?.price;
  }

  // Returns the share's number (of a symbol)
  Future<int?> getNbShares(String symbol) async {
    return (await getLatestShare(symbol))?.nbShares;
  }

  Future<bool> emptyDBShares() async {
    return await shareRepository.emptyDBShares();
  }
}
