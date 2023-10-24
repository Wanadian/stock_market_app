import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:stock_market_app/widgets/buttonWidget.dart';

//ignore: must_be_immutable
class DateFieldWidget extends StatefulWidget {
  Key? _key;
  Function(DateTime date) _onChange;
  dynamic Function(DateTime date)? _validator;
  final String _label;
  final String _errorLabel;
  bool _hasError = false;

  DateFieldWidget(
      {Key? key,
      required Function(DateTime date) onChange,
      dynamic Function(DateTime date)? validator,
      String label = '',
      String errorLabel = 'Invalid date'})
      : _onChange = onChange,
        _validator = validator,
        _label = label,
        _errorLabel = errorLabel,
        _key = key;

  @override
  State<DateFieldWidget> createState() => _DateFieldWidget();
}

class _DateFieldWidget extends State<DateFieldWidget> {
  DateTime _date = DateTime.now();

  DateTime _getDate() {
    return _date;
  }

  void _setHasError(bool hasError) {
    setState(() {
      widget._hasError = hasError;
    });
  }

  bool _isChangeFeasible(DateTime date) {
    if (widget._validator != null) {
      return widget._validator!(date);
    }
    return true;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        initialDatePickerMode: DatePickerMode.day,
        context: context,
        initialDate: _date,
        firstDate: DateTime(1900),
        lastDate: DateTime(3000));
    if (picked != null && picked != _date && _isChangeFeasible(picked)) {
      setState(() {
        _setHasError(false);
        _date = picked;
        widget._onChange(_date);
      });
    } else {
      _setHasError(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(children: [
      Row(children: [
        Container(width: screenWidth * 0.03),
        Container(
            constraints:
                BoxConstraints(minWidth: 0, maxWidth: screenWidth * 0.4),
            child: Text(widget._label,
                style: TextStyle(color: Colors.white, fontSize: 16))),
        Container(width: screenWidth * 0.05),
        ButtonWidget.textButton(
            label: '${DateFormat('yyyy-MM-dd').format(_date)}',
            onPressed: () {
              _selectDate(context);
            },
            height: screenHeight * 0.05,
            width: screenWidth * 0.3)
      ]),
      if (widget._hasError) ...[
        Container(height: screenHeight * 0.01),
        Container(
            constraints:
                BoxConstraints(minWidth: 0, maxWidth: widget._label != '' ? screenWidth * 0.7 : screenWidth * 0.3),
            child:
                Text(widget._errorLabel, style: TextStyle(color: Colors.red)))
      ]
    ]);
  }
}
