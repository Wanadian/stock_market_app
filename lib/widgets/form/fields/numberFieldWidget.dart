import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberFieldWidget extends StatefulWidget {
  NumberFieldWidget({
    required Key key,
    required FormFieldValidator<String> validator,
    required FormFieldSetter<String> onSaved,
    int value = -1,
    String label = '',
  })  : _validator = validator,
        _onSaved = onSaved,
        _value = value,
        _label = label,
        _key = key;

  Key _key;
  FormFieldValidator<String> _validator;
  FormFieldSetter<String> _onSaved;
  int _value;
  String _label;

  @override
  State<NumberFieldWidget> createState() => _NumberFieldWidget();
}

class _NumberFieldWidget extends State<NumberFieldWidget> {
  int getValue() {
    return widget._value;
  }

  Widget build(BuildContext context) {
    return TextFormField(
      key: widget._key,
      onChanged: (value) {
        setState(() {
          widget._value = int.parse(value);
        });
      },
      validator: widget._validator,
      onSaved: widget._onSaved,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: widget._label,
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    );
  }
}
