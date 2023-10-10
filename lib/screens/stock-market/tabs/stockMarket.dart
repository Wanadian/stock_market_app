import 'package:flutter/material.dart';

import '../../../widgets/shareBannerWidget.dart';
import '../../graph.dart';

class StockMarket extends StatefulWidget {
  const StockMarket({Key? key}) : super(key: key);

  @override
  State<StockMarket> createState() => _StockMarketState();
}

class _StockMarketState extends State<StockMarket> {
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // TODO : this should be replaced by a backend call
    List<Share> shares = [
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 20.0,
          numberOfShares: 2,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 30.0,
          numberOfShares: 3,
          shareName: 'Long Name to try a long name just to try',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 20.0,
          numberOfShares: 2,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
      Share(
          shareValue: 10.0,
          numberOfShares: 1,
          shareName: 'Name',
          shareSymbol: "APPLE"),
    ];

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            for (Share share in shares) ...[
              Container(height: screenHeight * 0.01),
              ShareBannerWidget(
                  shareValue: share.getShareValue(),
                  numberOfShares: share.getNumberOfShare(),
                  shareName: share.getShareName(),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Graph(
                                  symbol: share.getShareSymbol(),
                                )));
                  },
                  icon: Icons.add)
            ],
            Container(height: screenHeight * 0.05),
          ],
        )));
  }
}

// TODO : This class is temporary and is used to represent a share
class Share {
  double _shareValue;
  int _numberOfShares;
  String _shareName;
  String _shareSymbol;

  double getShareValue() {
    return _shareValue;
  }

  int getNumberOfShare() {
    return _numberOfShares;
  }

  String getShareName() {
    return _shareName;
  }

  String getShareSymbol() {
    return _shareSymbol;
  }

  Share({shareValue, numberOfShares, shareName, shareSymbol})
      : this._shareValue = shareValue,
        this._numberOfShares = numberOfShares,
        this._shareName = shareName,
        this._shareSymbol = shareSymbol;
}
