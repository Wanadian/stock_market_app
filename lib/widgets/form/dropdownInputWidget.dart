import 'package:flutter/material.dart';

class DropdownInputWidget extends StatefulWidget {
  DropdownInputWidget({
    Key? key,
    String label = '',
    required List<dynamic> items,
  })  : _key = key,
        _label = label,
        _items = items;

  Key? _key;
  String _label;
  List<dynamic> _items;

  @override
  State<DropdownInputWidget> createState() => _DropdownInputWidgetState();
}

class _DropdownInputWidgetState extends State<DropdownInputWidget> {
  dynamic _value;

  Widget build(BuildContext context) {
    return DropdownButton<String>(
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
      },
    );
  }
}
