import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';

import 'package:stock_market_app/widgets/form/fields/numberFieldWidget.dart';
import 'package:stock_market_app/context/inheritedServices.dart';
import 'package:stock_market_app/dto/shareDto.dart';
import 'package:stock_market_app/entities/userSharesEntity.dart';
import 'package:stock_market_app/services/shareService.dart';
import 'package:stock_market_app/services/symbolService.dart';
import 'package:stock_market_app/services/userSharesService.dart';
import 'package:stock_market_app/widgets/shareBannerWidget.dart';

class PurchasedShares extends StatefulWidget {
  const PurchasedShares({Key? key}) : super(key: key);

  @override
  State<PurchasedShares> createState() => _PurchasedSharesState();
}

class _PurchasedSharesState extends State<PurchasedShares> {
  int _numberSharesToPurchase = 0;
  TextEditingController _numberSharesToPurchaseController =
      TextEditingController();

  Future<List<ShareDto>?> _shareListRequest(UserSharesService userSharesService,
      ShareService shareService, SymbolService symbolService) async {
    List<UserSharesEntity>? shareListResponse =
        await userSharesService.getAllUserShares();
    List<ShareDto> shareList = [];
    for (UserSharesEntity share in shareListResponse!) {
      shareList.add(ShareDto(
          shareValue: await shareService.getPrice(share.symbol),
          numberOfShares: share.nbShares,
          shareName: await symbolService.getCompanyNameBySymbol(share.symbol),
          shareSymbol: share.symbol));
    }
    return shareList;
  }

  Future<String> _getWalletEstimation(
      UserSharesService userSharesService) async {
    return await userSharesService.getUserSharesBalanceEstimationAsString();
  }

  Future<void> _sellShare(UserSharesService userSharesService, String symbol) async {
    await userSharesService.removeUserShares(symbol, _numberSharesToPurchase);
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var inheritedServices = InheritedServices.of(context);

    Future<List<ShareDto>?> _shareList = _shareListRequest(
        inheritedServices.userSharesService,
        inheritedServices.shareService,
        inheritedServices.symbolService);
    Future<String> _walletEstimation =
        _getWalletEstimation(inheritedServices.userSharesService);

    return FutureBuilder(
        future: Future.wait([_shareList, _walletEstimation]),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: SingleChildScrollView(
                    child: Column(
              children: [
                for (ShareDto share in snapshot.data![0] as Iterable) ...[
                  Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 0.5),
                        ),
                      ]),
                      child: Column(children: [
                        Container(height: screenHeight * 0.01),
                        Text(
                          'Estimated value of your shares',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                        Container(
                            constraints: BoxConstraints(
                                minWidth: 0, maxWidth: screenWidth * 0.7),
                            child: AnimatedDigitWidget(
                              duration: Duration(seconds: 1),
                              value: double.parse(snapshot.data![1] as String),
                              enableSeparator: true,
                              fractionDigits: 2,
                              suffix: ' \$',
                              textStyle: TextStyle(
                                  overflow: TextOverflow.clip,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )),
                        Container(height: screenHeight * 0.01),
                      ])),
                  ShareBannerWidget(
                      shareValue: share.getShareValue(),
                      numberOfShares: share.getNumberOfShare(),
                      shareName: share.getShareName(),
                      shareSymbol: share.getShareSymbol(),
                      icon: Icons.remove,
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
                                        textAlign: TextAlign.center),
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
                                          await _sellShare(
                                              inheritedServices
                                                  .userSharesService,
                                              share.getShareSymbol());
                                          setState(() {
                                            share.setNumberOfShare(
                                                share.getNumberOfShare() - 1);
                                          });
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
          } else if (snapshot.hasError) {
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
