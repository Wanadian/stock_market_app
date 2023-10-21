import 'package:flutter/material.dart';

import '../../../context/inheritedServices.dart';
import '../../../dto/shareDto.dart';
import '../../../entities/shareEntity.dart';
import '../../../services/shareService.dart';
import '../../../services/symbolService.dart';
import '../../../services/userSharesService.dart';
import '../../../widgets/shareBannerWidget.dart';

class StockMarket extends StatefulWidget {
  const StockMarket({Key? key}) : super(key: key);

  @override
  State<StockMarket> createState() => _StockMarketState();
}

class _StockMarketState extends State<StockMarket> {
  Future<List<ShareDto>?> _shareListRequest(
      ShareService shareService, SymbolService symbolService) async {
    List<ShareEntity>? shareListResponse = await shareService.getLatestShares();
    List<ShareDto> shareList = [];
    for (ShareEntity share in shareListResponse!) {
      shareList.add(ShareDto(
          shareValue: share.price,
          numberOfShares: share.nbShares,
          shareName: await symbolService.getCompanyNameBySymbol(share.symbol),
          shareSymbol: share.symbol));
    }
    return shareList;
  }

  Future<bool> _purchaseShare(
      UserSharesService userSharesService, String symbol) async {
    return await userSharesService.addUserShares(symbol, 1);
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var inheritedServices = InheritedServices.of(context);
    Future<List<ShareDto>?> shareList = _shareListRequest(
        inheritedServices.shareService, inheritedServices.symbolService);

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
                      shareSymbol: share.getShareSymbol(),
                      icon: Icons.add,
                      onPressed: () async => {
                            if (!await _purchaseShare(
                                inheritedServices.userSharesService,
                                share.getShareSymbol()))
                              {
                                setState(() {
                                  share.setNumberOfShare(
                                      share.getNumberOfShare() - 1);
                                })
                              }
                          })
                ],
                Container(height: screenHeight * 0.05),
              ],
            )));
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
