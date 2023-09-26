import 'package:flutter/material.dart';
import 'package:stock_market_app/widgets/buttonWidget.dart';

class FormWidget extends StatefulWidget {
  FormWidget(
      {super.key,
      required List<Widget> fields,
      required Function() onPressed,
      String buttonLabel = 'Validate'})
      : _fields = fields,
        _onPressed = onPressed,
        _buttonLabel = buttonLabel;

  List<Widget> _fields = [];
  Function() _onPressed;
  String _buttonLabel;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        width: screenWidth * 0.8,
        child: SingleChildScrollView(
            child: Form(
          key: _key,
          child: Column(
            children: [
              for (Widget field in widget._fields) ...[
                field,
                Container(height: screenHeight * 0.04),
              ],
              ButtonWidget.textButton(
                  label: widget._buttonLabel,
                  onPressed: () => {
                        widget._onPressed(),
                        if (_key.currentState!.validate())
                          {_key.currentState?.save()
                          }
                      },
                  height: screenHeight * 0.07,
                  width: screenWidth * 0.5),
              Container(height: screenHeight * 0.04),
            ],
          ),
        )));
  }
}
