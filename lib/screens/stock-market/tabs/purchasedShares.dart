import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/graph.dart';
import 'package:stock_market_app/widgets/shareBannerWidget.dart';

class PurchasedShares extends StatefulWidget {
  const PurchasedShares({Key? key}) : super(key: key);

  @override
  State<PurchasedShares> createState() => _PurchasedSharesState();
}

class _PurchasedSharesState extends State<PurchasedShares> {
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
          numberOfShares: 9999999,
          shareName:
              'Nameeeeeeddddddvdlmxcgf g uguiggu  griuagf uazuf izf uzag fgza',
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
          shareValue: 1009890889.0,
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
                        builder: (context) =>
                            Graph(symbol: share.getShareSymbol())));
              },
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
