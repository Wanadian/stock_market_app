import 'package:flutter/material.dart';
import 'package:stock_market_app/widgets/form/fields/numberFieldWidget.dart';
import 'package:stock_market_app/widgets/form/fields/textFieldWidget.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

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
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFieldWidget(
                validator: (value) => null,
                onSaved: (value) => (),
                label: 'Text',
              ),
              Container(height: screenHeight * 0.04),
              NumberFieldWidget(
                validator: (value) => null,
                onSaved: (value) => (),
                label: 'Number',
              )
            ],
          ),
        ));
  }
}
