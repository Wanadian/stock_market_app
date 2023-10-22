import 'package:flutter/material.dart';

class DropdownInputWidget extends StatefulWidget {
  Key? _key;
  String _label;
  List<dynamic> _items;
  Function(String? value)? _onChange;

  DropdownInputWidget({
    Key? key,
    String label = '',
    required List<dynamic> items,
    Function(String? value)? onChange,
  })  : _key = key,
        _label = label,
        _items = items,
        _onChange = onChange;

  @override
  State<DropdownInputWidget> createState() => _DropdownInputWidgetState();
}

class _DropdownInputWidgetState extends State<DropdownInputWidget> {
  dynamic _value;

  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.white),
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: DropdownButton<String>(
          key: widget._key,
          hint: Text(widget._label),
          value: _value,
          items: widget._items.map((dynamic value) {
            return new DropdownMenuItem<String>(
              value: value.toString(),
              child: new Text(value.toString()),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _value = value;
            });
            widget._onChange!(value);
          },
          style: TextStyle(color: Colors.black),
          isExpanded: true,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          underline: SizedBox(),
        ));
  }
}
