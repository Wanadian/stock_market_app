import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  String? _label;
  IconData? _icon;
  Function() _onPressed;
  double _height;
  double _width;
  Alignment _alignment;

  ButtonWidget.textButton(
      {Alignment alignment = Alignment.center,
      required String? label,
      required dynamic Function() onPressed,
      required double height,
      required double width})
      : _alignment = alignment,
        _width = width,
        _height = height,
        _onPressed = onPressed,
        _label = label;

  ButtonWidget.iconButton(
      {Alignment alignment = Alignment.center,
      required IconData? icon,
      required dynamic Function() onPressed,
      required double height,
      required double width})
      : _alignment = alignment,
        _width = width,
        _height = height,
        _onPressed = onPressed,
        _icon = icon;

  @override
  Widget build(BuildContext context) {
    if ((_icon == null && _label == null) ||
        (_icon != null && _label != null)) {
      return Builder(builder: (BuildContext context) {
        throw Exception(
            "Error: 'icon' and 'label' can not be null at the same time, nor can they both contain a value that is not null");
      });
    }

    return Align(
        alignment: _alignment,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shadowColor: Colors.black,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: Size(0, 0),
                fixedSize: Size(_width, _height)),
            onPressed: () => _onPressed,
            child: _icon != null ? Icon(_icon) : Text(_label!)));
  }
}
