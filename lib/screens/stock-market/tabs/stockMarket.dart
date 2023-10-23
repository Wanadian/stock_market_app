import 'package:flutter/material.dart';

import 'package:stock_market_app/context/inheritedServices.dart';
import 'package:stock_market_app/dto/shareDto.dart';
import 'package:stock_market_app/entities/shareEntity.dart';
import 'package:stock_market_app/services/shareService.dart';
import 'package:stock_market_app/services/symbolService.dart';
import 'package:stock_market_app/services/userSharesService.dart';
import 'package:stock_market_app/widgets/form/fields/numberFieldWidget.dart';
import 'package:stock_market_app/widgets/shareBannerWidget.dart';

class StockMarket extends StatefulWidget {
  const StockMarket({Key? key}) : super(key: key);

  @override
  State<StockMarket> createState() => _StockMarketState();
}

class _StockMarketState extends State<StockMarket> {
  int _numberSharesToPurchase = 0;
  TextEditingController _numberSharesToPurchaseController =
      TextEditingController();
  Future<List<ShareDto>?>? _shareList;

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
    return await userSharesService.addUserShares(
        symbol, _numberSharesToPurchase);
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var inheritedServices = InheritedServices.of(context);

    _shareList = _shareListRequest(
        inheritedServices.shareService, inheritedServices.symbolService);

    return FutureBuilder<List<ShareDto>?>(
        future: _shareList,
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
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                alignment: Alignment.center,
                                title: Text('Confirm',
                                    textAlign: TextAlign.center),
                                content: SingleChildScrollView(
                                  child: Column(children: [
                                    Container(height: screenHeight * 0.02),
                                    Text(
                                      'Please enter the number of shares you want to purchase',
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(height: screenHeight * 0.05),
                                    NumberFieldWidget(
                                      label: 'Number of shares',
                                      controller:
                                          _numberSharesToPurchaseController,
                                    ),
                                  ]),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                  TextButton(
                                      child: const Text('Confirm'),
                                      onPressed: () async {
                                        if (_numberSharesToPurchaseController
                                                    .text !=
                                                '' &&
                                            int.parse(
                                                    _numberSharesToPurchaseController
                                                        .text) >
                                                0) {
                                          setState(() {
                                            _numberSharesToPurchase = int.parse(
                                                _numberSharesToPurchaseController
                                                    .text);
                                          });
                                          bool isFeasible =
                                              await _purchaseShare(
                                                  inheritedServices
                                                      .userSharesService,
                                                  share.getShareSymbol());
                                          if (!isFeasible) {
                                            setState(() {
                                              share.setNumberOfShare(
                                                  share.getNumberOfShare() - 1);
                                            });
                                          }
                                          Navigator.of(context).pop(true);
                                        }
                                      })
                                ],
                              );
                            });
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
