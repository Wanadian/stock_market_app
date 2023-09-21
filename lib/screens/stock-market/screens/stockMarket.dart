import 'package:flutter/material.dart';

import '../../../widgets/shareBannerWidget.dart';

class StockMarket extends StatefulWidget {
  const StockMarket({Key? key}) : super(key: key);

  @override
  State<StockMarket> createState() => _StockMarketState();
}

class _StockMarketState extends State<StockMarket> {
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<Share> shares = [
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 20.0, numberOfShares: 2, shareName: 'Name'),
      Share(
          shareValue: 30.0,
          numberOfShares: 3,
          shareName: 'Long Name to try a long name just to try'),
      Share(shareValue: 20.0, numberOfShares: 2, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
      Share(shareValue: 10.0, numberOfShares: 1, shareName: 'Name'),
    ];

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        for (Share share in shares) ...[
          Container(height: screenHeight * 0.01),
          ShareBannerWidget(
              shareValue: share.getShareValue(),
              shareName: share.getShareName(),
              onPressed: () {},
              icon: Icons.remove)
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

  double getShareValue() {
    return _shareValue;
  }

  int getNumberOfShare() {
    return _numberOfShares;
  }

  String getShareName() {
    return _shareName;
  }

  Share({shareValue, numberOfShares, shareName})
      : this._shareValue = shareValue,
        this._numberOfShares = numberOfShares,
        this._shareName = shareName;
}
