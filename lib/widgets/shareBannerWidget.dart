import 'package:flutter/material.dart';
import 'dart:math';

import 'package:stock_market_app/widgets/buttonWidget.dart';

class ShareBannerWidget extends StatelessWidget {
  double _shareValue;
  String _shareName;
  Function() _onPressed;

  ShareBannerWidget({
    required double shareValue,
    required String shareName,
    required dynamic Function() onPressed,
  })  : _shareValue = shareValue,
        _shareName = shareName,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    if (false) {
      return Builder(builder: (BuildContext context) {
        throw Exception(
            "Error: 'icon' and 'label' can not be null at the same time, nor can they both contain a value that is not null");
      });
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(width: 10),
                    DefaultTextStyle(
                        style: TextStyle(color: Colors.black, fontSize: 13),
                        child: Text(_shareName))
                  ]),
                  Row(children: [
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
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14),
                        child: Text('$_shareValue \$')),
                    ButtonWidget.iconButton(icon: Icons.remove, onPressed: (){}, height: 25, width: 25),
                    Container(width: 5)
                  ])
                ])));
  }
}
