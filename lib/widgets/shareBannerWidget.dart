import 'package:flutter/material.dart';

class ShareBannerWidget extends StatelessWidget {
  String? _shareName;
  Function() _onPressed;

  ShareBannerWidget({
    Alignment alignment = Alignment.center,
    required String? shareName,
    required dynamic Function() onPressed,
  })  : _onPressed = onPressed,
        _shareName = shareName;

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
            child: Row(children: [
              Text(
                _shareName!,
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
              Container(width: screenWidth * 0.05),
              TextButton(
                  onPressed: _onPressed,
                  child: Text('test')
              )
            ])));
  }
}
