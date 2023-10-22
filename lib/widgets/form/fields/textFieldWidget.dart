import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  Key? _key;
  TextEditingController? _controller;
  FormFieldValidator<String>? _validator;
  FormFieldSetter<String>? _onSaved;
  String _value;
  String _label;

  TextFieldWidget({
    Key? key,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    FormFieldSetter<String>? onSaved,
    String value = '',
    String label = '',
  })  : _controller = controller,
        _validator = validator,
        _onSaved = onSaved,
        _value = value,
        _label = label,
        _key = key;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidget();
}

class _TextFieldWidget extends State<TextFieldWidget> {
  String getValue() {
    return widget._value;
  }

  Widget build(BuildContext context) {
    return TextFormField(
        key: widget._key,
        onChanged: (value) {
          setState(() {
            widget._value = value;
          });
        },
        controller: widget._controller,
        validator: widget._validator,
        onSaved: widget._onSaved,
        keyboardType: TextInputType.text,
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
        ));
  }
}
