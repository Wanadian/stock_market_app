import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/graph.dart';
import 'package:stock_market_app/services/shareService.dart';
import 'package:stock_market_app/services/userSharesService.dart';
import 'package:stock_market_app/widgets/shareBannerWidget.dart';

import '../../../context/inheritedServices.dart';
import '../../../dto/shareDto.dart';
import '../../../entities/userShares.dart';
import '../../../services/symbolService.dart';

class PurchasedShares extends StatefulWidget {
  const PurchasedShares({Key? key}) : super(key: key);

  @override
  State<PurchasedShares> createState() => _PurchasedSharesState();
}

class _PurchasedSharesState extends State<PurchasedShares> {
  Future<List<ShareDto>?> _shareListRequest(UserSharesService userSharesService,
      ShareService shareService, SymbolService symbolService) async {
    List<UserShares>? shareListResponse =
        await userSharesService.getAllUserShares();
    List<ShareDto> shareList = [];
    for (UserShares share in shareListResponse!) {
      shareList.add(ShareDto(
          shareValue: await shareService.getPrice(share.symbol),
          numberOfShares: share.nbShares,
          shareName: await symbolService.getCompanyNameBySymbol(share.symbol),
          shareSymbol: share.symbol));
    }
    return shareList;
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var inheritedServices = InheritedServices.of(context);
    Future<List<ShareDto>?> shareList = _shareListRequest(
        inheritedServices.userSharesService,
        inheritedServices.shareService,
        inheritedServices.symbolService);

    return FutureBuilder<List<ShareDto>?>(
        future: shareList,
        builder: ((context, shareList) {
          if (shareList.hasData) {
            return Scaffold(
                body: SingleChildScrollView(
                    child: Column(
              children: [
                for (ShareDto share in shareList.data!) ...[
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
          } else if (shareList.data == null) {
            return Scaffold(
                body: Column(children: [
                  Container(
                    height: screenHeight * 0.35,
                  ),
                  Container(
                      width: screenWidth * 0.9,
                      child: Text("It seems like you don't have any share in your wallet",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.orange, fontSize: 20)))
                ]));
          } else if (shareList.hasError) {
            return Scaffold(
                body: Column(children: [
              Container(
                height: screenHeight * 0.35,
              ),
              Container(
                  width: screenWidth * 0.9,
                  child: Text('Something went wrong',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 20)))
            ]));
          } else {
            return Scaffold(
                body: Column(children: [
              Container(
                height: screenHeight * 0.35,
              ),
              const CircularProgressIndicator()
            ]));
          }
        }));
  }
}
