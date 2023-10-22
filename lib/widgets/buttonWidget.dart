import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  String? _label;
  IconData? _icon;
  Function()? _onPressed;
  double _height;
  double _width;
  Alignment _alignment;
  bool _isProcessing = false;

  ButtonWidget.textButton(
      {Alignment alignment = Alignment.center,
      required String? label,
      required dynamic Function()? onPressed,
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
      required dynamic Function()? onPressed,
      required double height,
      required double width})
      : _alignment = alignment,
        _width = width,
        _height = height,
        _onPressed = onPressed,
        _icon = icon;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    if ((widget._icon == null && widget._label == null) ||
        (widget._icon != null && widget._label != null)) {
      return Builder(builder: (BuildContext context) {
        throw Exception(
            "Error: 'icon' and 'label' can not be null at the same time, nor can they both contain a value that is not null");
      });
    }

    return Align(
        alignment: widget._alignment,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shadowColor: Colors.black,
                backgroundColor:
                    !widget._isProcessing
                        ? Colors.white
                        : Colors.white10,
                foregroundColor: Colors.black,
                disabledBackgroundColor: Colors.white10,
                disabledForegroundColor: Colors.black,
                minimumSize: Size(0, 0),
                fixedSize: Size(widget._width, widget._height)),
            onPressed: widget._onPressed != null
                ? () async{
                    if (!widget._isProcessing) {
                      setState(() {
                        widget._isProcessing = true;
                      });
                      await Future.delayed(const Duration(milliseconds: 500));
                      await widget._onPressed!();
                      await Future.delayed(const Duration(milliseconds: 500));
                      setState(() {
                        widget._isProcessing = false;
                      });
                    }
                  }
                : null,
            child: widget._icon != null
                ? Icon(widget._icon)
                : Text(widget._label!)));
  }
}
