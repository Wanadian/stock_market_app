import 'package:flutter/material.dart';

import 'package:stock_market_app/services/shareService.dart';
import 'package:stock_market_app/widgets/buttonWidget.dart';
import 'package:stock_market_app/context/inheritedServices.dart';
import 'package:stock_market_app/screens/graph.dart';

//ignore: must_be_immutable
class ShareBannerWidget extends StatefulWidget {
  double _shareValue;
  int _numberOfShares;
  String _shareName;
  String _shareSymbol;
  IconData _icon;
  Function() _onPressed;

  ShareBannerWidget(
      {required double shareValue,
      required int numberOfShares,
      required String shareName,
      required String shareSymbol,
      required Function() onPressed,
      required IconData icon})
      : _shareValue = shareValue,
        _numberOfShares = numberOfShares,
        _shareName = shareName,
        _shareSymbol = shareSymbol,
        _onPressed = onPressed,
        _icon = icon;

  @override
  State<ShareBannerWidget> createState() => _ShareBannerWidgetState();
}

class _ShareBannerWidgetState extends State<ShareBannerWidget> {
  Future<double?>? _shareValueVariation;

  Future<double?> _getVariation(ShareService shareService) async {
    return await shareService.getPriceDifference(widget._shareSymbol);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var inheritedServices = InheritedServices.of(context);

    _shareValueVariation = _getVariation(inheritedServices.shareService);

    return FutureBuilder<double?>(
        future: _shareValueVariation,
        builder: ((context, shareValueVariation) {
          if (shareValueVariation.hasData) {
            return Visibility(
                visible: widget._numberOfShares <= 0 ? false : true,
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Container(width: screenWidth * 0.04),
                                Container(
                                    constraints: BoxConstraints(
                                        minWidth: 0,
                                        maxWidth: screenWidth * 0.3),
                                    child: DefaultTextStyle(
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 13),
                                        child: Text(widget._shareName))),
                              ]),
                              Row(children: [
                                Container(
                                    constraints: BoxConstraints(
                                        minWidth: 0,
                                        maxWidth: screenWidth * 0.13),
                                    child: DefaultTextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 13),
                                        child: Text('x ' +
                                            widget._numberOfShares
                                                .toString()))),
                                Container(width: screenWidth * 0.03),
                                Column(
                                  children: [
                                    Container(
                                        height: screenHeight * 0.05,
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Graph(
                                                            symbol: widget
                                                                ._shareSymbol,
                                                          )));
                                            },
                                            child: Row(children: [
                                              shareValueVariation.data! < 0
                                                  ? Transform.rotate(
                                                      angle: 1.57,
                                                      child: Icon(
                                                        Icons.call_made,
                                                        color: Colors.red,
                                                      ))
                                                  : Transform.rotate(
                                                      angle: 0,
                                                      child: Icon(
                                                        Icons.call_made,
                                                        color: Colors.green,
                                                      )),
                                              DefaultTextStyle(
                                                  style: TextStyle(
                                                      color: shareValueVariation
                                                                  .data! <
                                                              0
                                                          ? Colors.red
                                                          : Colors.green,
                                                      fontSize: 14),
                                                  child: Text(shareValueVariation
                                                          .data!
                                                          .abs()
                                                          .toStringAsPrecision(
                                                              2) +
                                                      '\%'))
                                            ]))),
                                    Container(
                                      height: screenHeight * 0.05,
                                      alignment: Alignment.center,
                                      constraints: BoxConstraints(
                                          minWidth: 0,
                                          maxWidth: screenWidth * 0.2),
                                      child: DefaultTextStyle(
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          child: Text(
                                            '${widget._shareValue} \$',
                                          )),
                                    )
                                  ],
                                ),
                                ButtonWidget.iconButton(
                                    icon: widget._icon,
                                    onPressed: widget._onPressed,
                                    height: 25,
                                    width: 25),
                                Container(width: 5)
                              ])
                            ]))));
          } else {
            return Container(width: 0, height: 0);
          }
        }));
  }
}
