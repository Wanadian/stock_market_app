import 'package:flutter/material.dart';

//ignore: must_be_immutable
class DropdownFieldWidget extends StatefulWidget {
  Key? _key;
  String _label;
  List<dynamic> _items;
  Function(String? value)? _onChange;

  DropdownFieldWidget({
    Key? key,
    String label = '',
    required List<dynamic> items,
    Function(String? value)? onChange,
  })  : _key = key,
        _label = label,
        _items = items,
        _onChange = onChange;

  @override
  State<DropdownFieldWidget> createState() => _DropdownFieldWidgetState();
}

class _DropdownFieldWidgetState extends State<DropdownFieldWidget> {
  dynamic _value;

  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.white),
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
            widget._onChange != null ? widget._onChange!(value) : null;
          },
          style: TextStyle(color: Colors.black),
          isExpanded: true,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          underline: SizedBox(),
        ));
  }
}
