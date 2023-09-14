import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  String? label;
  IconData? icon;
  Function() onPressed;
  double height;
  double width;
  Alignment alignment;

  ButtonWidget.textButton(
      {this.alignment = Alignment.center,
      required this.label,
      required this.onPressed,
      required this.height,
      required this.width});

  ButtonWidget.iconButton(
      {this.alignment = Alignment.center,
      required this.icon,
      required this.onPressed,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    if ((icon == null && label == null) || (icon != null && label != null)) {
      return Builder(builder: (BuildContext context) {
        throw Exception(
            "Error: 'icon' and 'label' can not be null at the same time, nor can they both contain a value that is not null");
      });
    }

    return Align(
        alignment: alignment,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shadowColor: Colors.black,
                backgroundColor: Colors.grey.shade600,
                foregroundColor: Colors.white,
                minimumSize: Size(0, 0),
                fixedSize: Size(width, height)),
            onPressed: () => onPressed,
            child: icon != null ? Icon(icon) : Text(label!)));
  }
}
