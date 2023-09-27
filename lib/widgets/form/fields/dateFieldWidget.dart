import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_market_app/widgets/buttonWidget.dart';

class DateFieldWidget extends StatefulWidget {
  DateFieldWidget({required Key key, required String label})
      : _label = label,
        _key = key;

  Key _key;
  final String _label;

  @override
  State<DateFieldWidget> createState() => _DateFieldWidget();
}

class _DateFieldWidget extends State<DateFieldWidget> {
  DateTime _date = DateTime.now();

  DateTime getDate() {
    return _date;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        initialDatePickerMode: DatePickerMode.day,
        context: context,
        initialDate: _date,
        firstDate: DateTime(1900),
        lastDate: DateTime(3000));
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Row(children: [
      Container(width: screenWidth * 0.03),
      Container(
          constraints: BoxConstraints(minWidth: 0, maxWidth: screenWidth * 0.4),
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
    ]);
  }
}
