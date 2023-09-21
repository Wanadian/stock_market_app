import 'package:flutter/material.dart';

import 'package:stock_market_app/widgets/buttonWidget.dart';

class ShareBannerWidget extends StatelessWidget {
  double _shareValue;
  int? _numberOfShares;
  String _shareName;
  Function() _onPressed;
  IconData _icon;

  ShareBannerWidget(
      {required double shareValue,
      int? numberOfShares,
      required String shareName,
      required dynamic Function() onPressed,
      required IconData icon})
      : _shareValue = shareValue,
        _numberOfShares = numberOfShares,
        _shareName = shareName,
        _onPressed = onPressed,
        _icon = icon;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    //TODO : determine the variation of the share's value byt comparing the value the day before to the actual date
    double shareValueVariation = 0;

    return Align(
        alignment: Alignment.center,
        child: Container(
            width: screenWidth * 0.9,
            height: screenHeight * 0.05,
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
                    Container(width: 10),
                    Container(
                        constraints: BoxConstraints(
                            minWidth: 0, maxWidth: screenWidth * 0.3),
                        child: DefaultTextStyle(
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black, fontSize: 13),
                            child: Text(_shareName))),
                  ]),
                  Row(children: [
                    if (_numberOfShares != null) ...{
                      Container(
                          constraints: BoxConstraints(
                              minWidth: 0, maxWidth: screenWidth * 0.05),
                          child: DefaultTextStyle(
                              overflow: TextOverflow.fade,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                              child: Text('x' + _numberOfShares.toString())))
                    },
                    Container(width: 10),
                    TextButton(
                        onPressed: _onPressed,
                        child: Row(children: [
                          shareValueVariation < 0
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
                                  color: shareValueVariation < 0
                                      ? Colors.red
                                      : Colors.green,
                                  fontSize: 14),
                              child: Text(
                                  shareValueVariation.abs().toString() + '\%'))
                        ])),
                    DefaultTextStyle(
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        child: Text('$_shareValue \$')),
                    ButtonWidget.iconButton(
                        icon: _icon, onPressed: () {}, height: 25, width: 25),
                    Container(width: 5)
                  ])
                ])));
  }
}
