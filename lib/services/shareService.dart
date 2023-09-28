import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_market_app/repositories/shareRepository.dart';
import 'package:stock_market_app/classes/share.dart';
import 'package:stock_market_app/errors/shareError.dart';

// This class will contain all the API calls and calls the associated repository
class ShareService {
  static const String APIKEY = '4V1HEZEB2M5V7LW9';
  ShareRepository shareRepository = ShareRepository();

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
  void addSharesFromAPIToDB(List<String> symbols) {
    final symbolsStream = convertListToStream(symbols);

    StreamSubscription? subscription;

    subscription = symbolsStream.listen((symbol) async {
      Share share = await getShareFromAPI(symbol);
      shareRepository.addShare(share);
    }, onDone: () {
      // Cancel the subscription when needed to stop listening to the stream
      subscription?.cancel();
    });
  }

  // Returns all the shares
  Future<List<Share>?> getAllShares() async {
    return await shareRepository.getShares();
  }

  // Gets the latest refresh day from the database
  Future<DateTime?> getLatestRefreshDate() async {
    return await shareRepository.getLatestRefreshDate();
  }
}
